local M = {}

function M.setup()
  local jdtls_ok, jdtls = pcall(require, 'jdtls')
  if not jdtls_ok then vim.notify('JDTLS not found', vim.log.levels.ERROR) end

  ---@type string?
  local home = os.getenv('HOME')

  -- --- Project-specific workspace ---
  -- get the root dir for the buffer
  local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
  local root_dir = vim.fs.root(0, root_markers)
  if not root_dir then root_dir = vim.fn.getcwd() end

  local project_name = vim.fn.fnamemodify(root_dir, ':t')
  local workspace_dir = home .. '/.local/share/jdtls-eclipse/' .. project_name -- jdtls will use this to index your project

  -- --- OS-specific and Mason path helpers ---
  local os_name = vim.uv.os_uname().sysname -- get OS name
  local jdtls_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'packages', 'jdtls')
  local mason_packages = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'packages')

  -- --- 1. Dynamically find the launcher jar ---

  local launcher_pattern = vim.fs.joinpath(jdtls_dir, 'plugins', 'org.eclipse.equinox.launcher_*.jar')
  local launcher_jar = vim.fn.glob(launcher_pattern, true, true)[1]

  -- Check if launcher jar was found properly
  if not launcher_jar or launcher_jar == '' then
    vim.notify('Could not find jdtls launcher jar with pattern: ' .. launcher_pattern, vim.log.levels.ERROR)
    return
  end

  -- --- 2. Dynamically find the configuration directory ---
  -- should add other configs here

  local os_lookup = {
    Windows_NT = 'win',
    Linux = 'linux',
    Darwin = 'mac',
  }

  local os = os_lookup[os_name]

  if not os then
    vim.notify('Unregistered OS: ' .. tostring(os_name) .. '. JDTLS startup interrupted', vim.log.levels.ERROR)
    return
  end

  local config_dir_name = 'config_' .. os
  local config_dir = vim.fs.joinpath(jdtls_dir, config_dir_name)

  if not vim.fn.isdirectory(config_dir) then
    vim.notify('Config file directory not valid: ' .. config_dir .. '. JDTLS startup interrupted', vim.log.levels.ERROR)
    return
  end

  -- --- 3. Find DAP/Test Jars ---

  -- These are installed by Mason (or other)
  local bundles = {}

  local debug_glob = vim.fs.joinpath(
    mason_packages,
    'java-debug-adapter',
    'extension',
    'server',
    'com.microsoft.java.debug.plugin-*.jar'
  )

  local java_debug_jar = vim.fn.glob(debug_glob, true, true)[1]

  if java_debug_jar and java_debug_jar ~= '' then
    table.insert(bundles, java_debug_jar)
  else
    vim.notify(
      'java debug jar was not found. Check your vscode-java-debug installation',
      vim.log.levels.WARN,
      { title = ' JDTLS' }
    )
  end

  local test_glob = vim.fs.joinpath(mason_packages, 'java-test', 'extension', 'server', '*.jar')
  local java_test_jars = vim.fn.glob(test_glob, true, true)
  local excluded = {
    'com.microsoft.java.test.runner-jar-with-dependencies.jar',
    'jacocoagent.jar',
  }

  -- notify if debug/test jars are not found
  if #java_test_jars > 0 then
    for _, java_test_jar in ipairs(java_test_jars) do
      local fname = vim.fn.fnamemodify(java_test_jar, ':t')
      if not vim.tbl_contains(excluded, fname) then table.insert(bundles, java_test_jar) end
    end
  else
    vim.notify(
      'java test jars were not found. Check your vscode-java-test installation',
      vim.log.levels.WARN,
      { title = ' JDTLS' }
    )
  end

  -- --- 4. Find lombok.jar ---

  local lombok = vim.fs.joinpath(jdtls_dir, 'lombok.jar')

  -- Notify if lombok.jar was not found
  if not vim.fn.filereadable(lombok) then
    vim.notify('Could not find lombok.jar in ' .. jdtls_dir .. '. Check your JDTLS installation', vim.log.levels.WARN)
  end

  -- --- 5. Define on_attach ---

  --- define on_attach behaviour
  ---@param client vim.lsp.Client
  ---@param bufnr integer
  local on_attach = function(client, bufnr)
    jdtls.setup_dap { hotcodereplace = 'auto' }
    local dap_ok, jdtls_dap = pcall(require, 'jdtls.dap')
    if dap_ok then jdtls_dap.setup_dap_main_class_configs() end

    local map = vim.keymap.set
    map('n', '<leader>jtc', function() jdtls.test_class() end, { buffer = bufnr, desc = 'Java Test Class' })
    map('n', '<leader>jtm', function() jdtls.test_nearest_method() end, { buffer = bufnr, desc = 'Java Test Method' })
    map('n', '<leader>jo', function() jdtls.organize_imports() end, { buffer = bufnr, desc = 'Java Organize Imports' })
  end

  -- --- Final LSP Config ---
  ---@type vim.lsp.ClientConfig
  local config = {
    cmd = {
      'java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xmx1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens',
      'java.base/java.util=ALL-UNNAMED',
      '--add-opens',
      'java.base/java.lang=ALL-UNNAMED',
      '-javaagent:' .. lombok,
      '-jar',
      launcher_jar,
      '-configuration',
      config_dir,
      '-data',
      workspace_dir,
    },
    root_dir = root_dir,

    on_attach = on_attach,

    settings = {
      java = {
        format = {
          enabled = true,
          settings = {
            url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
          },
        },
        eclipse = { downloadSources = true },
        maven = { downloadSources = true },
        implementationsCodeLens = { enabled = true },
        referencesCodeLens = { enabled = true },
        references = { enabled = true },
        signatureHelp = { enabled = true },
        inlayHints = {
          parameterNames = {
            enabled = 'all',
          },
        },
        import = { enabled = true },
        rename = { enabled = true },
        saveActions = { organizeImports = true },
        codeGeneration = {
          toString = {
            template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
          },
          useBlocks = true,
        },
        configuration = {
          updateBuildConfiguration = 'interactive',
          -- ensure java jdk paths are correct
          runtimes = {
            {
              name = 'JavaSE-25',
              path = '/usr/lib/jvm/java-25-openjdk/',
            },
            {
              name = 'JavaSE-21',
              path = '/usr/lib/jvm/java-21-openjdk/',
              default = true,
            },
          },
        },
        compile = {
          nullAnalysis = {
            mode = 'automatic',
          },
        },
      },
    },
    init_options = {
      bundles = bundles,
    },
  }

  jdtls.start_or_attach(config)
end

return M

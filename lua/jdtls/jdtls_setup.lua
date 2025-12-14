local M = {}

-- See `:help vim.lsp.start` for an overview of the supported `config` options.
function M:setup()
  local jdtls = require('jdtls')
  local home = os.getenv('HOME')

  -- --- Project-specific workspace ---
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t') -- get currently open file in shell (etc. /where/you/are returns "are")
  local workspace_dir = home .. '/.local/share/jdtls-eclipse/' .. project_name -- jdtls will use this to index your project

  -- --- OS-specific and Mason path helpers ---
  local os_name = vim.loop.os_uname().sysname -- get OS name
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

  local os_lookup = {
    Windows_NT = 'win',
    Linux = 'linux',
    Darwin = 'mac',
  }

  local key = os_lookup[os_name]

  if not key then
    vim.notify('Unregistered OS' .. tostring(os_name) .. '. JDTLS startup interrupted.', vim.log.levels.ERROR)
    return
  end

  -- --- 2. Dynamically find the configuration directory ---
  local config_dir_name = 'config_' .. key
  local config_dir = vim.fs.joinpath(jdtls_dir, config_dir_name)

  -- --- 3. Find DAP/Test Jars ---
  -- These are installed by mason-nvim-dap
  local debug_glob = vim.fs.joinpath(
    mason_packages,
    'java-debug-adapter',
    'extension',
    'server',
    'com.microsoft.java.debug.plugin-*.jar'
  )
  local test_glob =
    vim.fs.joinpath(mason_packages, 'java-test', 'extension', 'server', 'com.microsoft.java.test.plugin-*.jar')

  local java_debug_jar = vim.fn.glob(debug_glob, true, true)[1]
  local java_test_jar = vim.fn.glob(test_glob, true, true)[1]

  local bundles = {}
  if java_debug_jar then table.insert(bundles, java_debug_jar) end
  if java_test_jar then table.insert(bundles, java_test_jar) end

  -- --- 4. Define on_attach ---
  -- nvim-jdtls needs this to set up DAP
  local on_attach = function(client, bufnr)
    if vim.bo[bufnr].filetype:match('^dapui') then return end
    local map = vim.keymap.set
    map('n', '<leader>jd', "<Cmd>lua require'jdtls'.test_class()<CR>", { desc = 'JDTLS test class' })
    map('n', '<leader>jt', "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", { desc = 'JDTLS test nearest method' })
    jdtls.setup_dap { hotcodereplace = 'auto' }
  end

  -- --- Final LSP Config ---
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
      '-jar',
      launcher_jar,
      '-configuration',
      config_dir,
      '-data',
      workspace_dir,
    },
    root_dir = vim.fs.root(0, { 'gradlew', '.git', 'mvnw', 'pom.xml', '.project' }),

    on_attach = on_attach,

    settings = {
      java = {
        import = { enabled = true },
        rename = { enabled = true },
        configuration = {
          runtimes = {
            {
              name = 'JavaSE-25',
              path = '/usr/lib/jvm/java-25-openjdk/',
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

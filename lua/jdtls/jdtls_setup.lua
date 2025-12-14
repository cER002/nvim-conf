local M = {}

-- See `:help vim.lsp.start` for an overview of the supported `config` options.
function M:setup()
  local jdtls = require('jdtls')
  local home = os.getenv('HOME')

  -- --- Project-specific workspace ---
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local workspace_dir = home .. '/.local/share/jdtls-eclipse/' .. project_name

  -- --- OS-specific and Mason path helpers ---
  local os_name = vim.loop.os_uname().sysname
  local path_sep = package.config:sub(1, 1) -- Gets / or \
  local jdtls_dir = vim.fn.stdpath('data') .. path_sep .. 'mason' .. path_sep .. 'packages' .. path_sep .. 'jdtls'
  local mason_packages = vim.fn.stdpath('data') .. path_sep .. 'mason' .. path_sep .. 'packages'

  -- --- 1. Dynamically find the launcher jar ---
  local launcher_glob = jdtls_dir .. path_sep .. 'plugins' .. path_sep .. 'org.eclipse.equinox.launcher_*.jar'
  local launcher_jar = vim.fn.split(vim.fn.glob(launcher_glob), '\n')[1]

  -- Safety check
  if not launcher_jar or launcher_jar == '' then
    vim.notify('Could not find jdtls launcher jar at: ' .. launcher_glob, vim.log.levels.ERROR)
    return
  end

  local os_lookup = {
    Windows_NT = 'win',
    Linux = 'linux',
    Darwin = 'mac',
  }

  -- --- 2. Dynamically find the configuration directory ---
  local config_dir_name = 'config_' .. os_lookup[os_name]
  local config_dir = jdtls_dir .. path_sep .. config_dir_name

  -- --- 3. Find DAP/Test Jars ---
  -- These are installed by mason-nvim-dap
  local debug_glob = mason_packages
    .. path_sep
    .. 'java-debug-adapter'
    .. path_sep
    .. 'extension'
    .. path_sep
    .. 'server'
    .. path_sep
    .. 'com.microsoft.java.debug.plugin-*.jar'
  local test_glob = mason_packages
    .. path_sep
    .. 'java-test'
    .. path_sep
    .. 'extension'
    .. path_sep
    .. 'server'
    .. path_sep
    .. 'com.microsoft.java.test.plugin-*.jar'

  local java_debug_jar = vim.fn.split(vim.fn.glob(debug_glob), '\n')[1]
  local java_test_jar = vim.fn.split(vim.fn.glob(test_glob), '\n')[1]

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

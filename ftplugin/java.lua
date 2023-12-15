local jdtls = require("jdtls")
local mason_registry = require("mason-registry")
local jdtls_install = mason_registry
    .get_package('jdtls')
    :get_install_path()
local path = {}
path.data_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls'
path.java_agent = jdtls_install .. '/lombok.jar'
path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')

if vim.fn.has('mac') == 1 then
    path.platform_config = jdtls_install .. '/config_mac'
elseif vim.fn.has('unix') == 1 then
    path.jdk_homes = "$HOME/.sdkman/candidates/java/"
    path.jdk_bin = path.jdk_homes .. "current/bin/java"
    path.platform_config = jdtls_install .. '/config_linux'
elseif vim.fn.has('win32') == 1 then
    local current_java_home = os.getenv("JAVA_HOME")
    path.jdk_homes = string.sub(current_java_home, 1, current_java_home:match '^.*()\\')
    path.platform_config = jdtls_install .. '/config_win'
end

path.bundles = {}

---
-- Include java-test bundle if present
---
local java_test_path = mason_registry
    .get_package('java-test')
    :get_install_path()

local java_test_bundle = vim.split(
    vim.fn.glob(java_test_path .. '/extension/server/*.jar'),
    '\n'
)

if java_test_bundle ~= nil and java_test_bundle[1] ~= '' then
    vim.list_extend(path.bundles, java_test_bundle)
end

---
-- Include java-debug-adapter bundle if present
---
local java_debug_path = mason_registry
    .get_package('java-debug-adapter')
    :get_install_path()

local java_debug_bundle = vim.split(
    vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar'),
    '\n'
)

if java_debug_bundle[1] ~= '' then
    vim.list_extend(path.bundles, java_debug_bundle)
end

local jdk_17_path = vim.split(
    vim.fn.glob(path.jdk_homes .. '*17*'),
    '\n')

if jdk_17_path[1] ~= "" then
    path.jdk_17_home = jdk_17_path[1]
end

local jdk_11_path = vim.split(
    vim.fn.glob(path.jdk_homes .. '*11*'),
    '\n')

if jdk_11_path[1] ~= "" then
    path.jdk_11_home = jdk_11_path[1]
end

local jdk_8_path = vim.split(
    vim.fn.glob(path.jdk_homes .. '*1.8*'),
    '\n')

if jdk_8_path[1] ~= "" then
    path.jdk_8_home = jdk_8_path[1]
end

if vim.fn.has("win32") == 1  then
    path.jdk_bin = path.jdk_17_home "\\bin\\java"
end

path.runtimes = {
    {
        name = "JavaSE-1.8",
        path = path.jdk_8_home
    },
    {
        name = "JavaSE-11",
        path = path.jdk_11_home
    },
    {
        name = "JavaSE-17",
        path = path.jdk_17_home
    }
}
local data_dir = path.data_dir .. '/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local config = {
    cmd = {
        'java',

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. path.java_agent,
        '-Xms4g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',

        '-jar',
        path.launcher_jar,

        '-configuration',
        path.platform_config,

        '-data',
        data_dir,
    },
    root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
    settings = {
        java = {
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = 'interactive',
                runtimes = path.runtimes,
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            -- inlayHints = {
            --   parameterNames = {
            --     enabled = 'all' -- literals, all, none
            --   }
            -- },
            format = {
                enabled = true,
                -- settings = {
                --   profile = 'asdf'
                -- },
            }
        },
        signatureHelp = {
            enabled = true,
        },
        completion = {
            favoriteStaticMembers = {
                'org.hamcrest.MatcherAssert.assertThat',
                'org.hamcrest.Matchers.*',
                'org.hamcrest.CoreMatchers.*',
                'org.junit.jupiter.api.Assertions.*',
                'java.util.Objects.requireNonNull',
                'java.util.Objects.requireNonNullElse',
                'org.mockito.Mockito.*',
            },
        },
        contentProvider = {
            preferred = 'fernflower',
        },
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            }
        },
        codeGeneration = {
            toString = {
                template =
                '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
            },
            useBlocks = true,
        },
    },
    on_attatch = function (client, bufnr)
        jdtls.setup_dap({ hotcodereplace = 'auto' })
    end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    init_options = {
        bundles = path.bundles,
    }
}
jdtls.start_or_attach(config)

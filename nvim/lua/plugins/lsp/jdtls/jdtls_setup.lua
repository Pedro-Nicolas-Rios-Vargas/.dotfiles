local M = {}

function M.setup()
  local jdtls_setup = require("jdtls.setup")
  local home = os.getenv("HOME")

  local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
  local root_dir = jdtls_setup.find_root(root_markers)

  local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
  local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

  -- print("Project Name: " .. project_name)
  -- print("Workspace dir: " .. workspace_dir)

  local mason_package_path = home .. "/.local/share/nvim/mason/packages/"

  local path_to_jdtls = mason_package_path .. "jdtls/"
  local path_to_config = path_to_jdtls .. "/config_linux"
  local path_to_jar = path_to_jdtls .. "/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar"

  -- TODO: Add the repos/java-debug for jdebug
  local bundles = {}

  local on_attach = require("plugins.lsp.keymaps")

  --[[
  local capabilities = {
    workspace = {
      configuration = true
    },
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  }
  --]]
  local function buildCapabilities()
    local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")

    return vim.tbl_deep_extend(
      "force",
      {
        workspace = {
          configuration = true
        },
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true
            }
          }
        }
      },
      has_cmp and cmp.default_capabilities() or {}
    )
  end
  local capabilities = buildCapabilities()
  local config = {
    flags = {
      allow_incremental_sync = true,
    }
  }

  config.cmd = {
    --
    -- 				-- 💀
    "java", -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    -- "-javaagent:" .. lombok_path,
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    -- 💀
    "-jar", path_to_jar,
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version

    -- 💀
    "-configuration", path_to_config,
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.

    -- 💀
    -- See `data directory configuration` section in the README
    "-data", workspace_dir,
  }

  config.settings = {
    java = {
      references = {
        includeDecompiledSources = true,
      },
      --[[
      format = {
      enabled = true,
      settings = {
      url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
      profile = "GoogleStyle",
      },
      },
      --]]
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      signatureHelp = { enabled = true },
      -- contentProvider = { preferred = "fernflower" }
      completion = {
        favoriteStaticMembers = {
          "org.amcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    },
  }

  config.on_attach = on_attach
  config.capabilities = capabilities
  config.on_init = function (client, _)
    client.notify('workspace/didChangeConfiguration', { settings = config.settings })
  end

  local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  config.init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities,
  }

  require('jdtls').start_or_attach(config)
end

return M

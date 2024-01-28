local custom_attach = require("plugins.lsp.keymaps")

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = function (_)
          require("mason").setup()
        end
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "lua_ls",
            "jdtls",
            "tsserver",
            "gradle_ls",
            "gopls",
            "pylsp",
            "html",     -- 
            "cssls",    -- This four lsp's use the same resource 
            "jsonls",   -- hrsh7th/vscode-langservers-extracted
            "eslint",   --
          },
        },
      },
    },
    opts = {
      on_init = function (client)
        client.config.flags = client.config.flags or {}
        client.config.flags.allow_incremental_sync = true
      end,
      servers = {
        pylsp = true,
        html = false,
        cssls = true,
        jsonls = false,
        jdtls = true,
        hls = true,
        gopls = true,
        gradle_ls = true,
        eslint = false,
        lua_ls = {
          on_init = function (client)
            print("lua_ls init...")
            local path = client.workspace_folders[1].name
            if not vim.uv.fs_stat(path .. '/.luarc.json') and not vim.uv.fs_stat(path .. '/.luarc.jsonc') then
              client.config.settings = vim.tbl_deep_extend(
                "force",
                client.config.settings, {
                  Lua = {
                    runtime = {
                      -- default for ls lua neovim version
                      version = 'LuaJIT',
                      -- Help in the search/loading of files when 'require' is
                      -- used
                    },
                    diagnostics = {
                      globals = { 'vim' },
                    },
                    workspace = {
                      checkThirdParty = false,
                      library = {
                        vim.env.VIMRUNTIME,
                      },
                    },
                  },
                }
              )
              client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            end
            return true
          end,
        },
        tsserver = {
            cmd = { "typescript-language-server", "--stdio" },
            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
            },
            on_attach = function (client)
                -- client.resolved_capabilities.document_formatting = false
                client.server_capabilities.document_formatting = false
                custom_attach(client)
            end
        },
        arduino_language_server = {
            cmd = {
                -- Required
                "arduino-language-server",
                "-cli-config", "$HOME/.arduino15/arduino-cli.yaml",
                -- Optional
                "-cli", "$HOME/bin/arduino-cli",
                "-clangd", "/usr/bin/clangd-12",
                "fqbn", "arduino:avr:uno"
            },
            filetypes = { "ino", "arduino" },
            root_dir = function (startpath)
                --print('Start path of arduino-ls: ', startpath)
                return startpath
            end
        }
      },
    },
    config = function (_, opts)
      local custom_init = opts.on_init
      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server, config)
        if not config then
          return
        end

        if type(config) ~= "table" then
          config = {}
        end

        --[[
        if server == "lua_ls" then
        custom_init = config.on_init
        end
        --]]

        config = vim.tbl_deep_extend("force", {
          on_init = custom_init,
          on_attach = custom_attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 50,
          },
        }, config)

        require("lspconfig")[server].setup(config)
      end

      for server, config in pairs(servers) do
        setup(server, config)
      end
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    dependencies = {
      "neovim/nvim-lspconfig"
    }
  },
  --[[
  {
    "hrsh7th/vscode-langservers-extracted",
    dependencies = {
      "neovim/nvim-lspconfig"
    }
  },
  --]]

}

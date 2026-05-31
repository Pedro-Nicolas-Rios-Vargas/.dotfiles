local custom_attach = require("plugins.lsp.keymaps")

return {
  {
    "williamboman/mason.nvim",
    config = function (_)
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry"
        }
      })
    end
  },
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    opts = {
      filewatching = "roslyn",
      broad_search = true
    },
    dependencies = {
      "mason-org/mason.nvim",
    },
    config = function ()
      -- Use one of the methods in the Integration section to compose the
      -- command
      local roslyn_path = vim.fn.expand("$MASON/packages/roslyn")
      --local rzls_path = vim.fs.joinpath(roslyn_path, "libexec")
      local cmd = {
        vim.fs.joinpath(roslyn_path, "roslyn"),
        "--stdio",
        "--logLevel=Information",
        "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        --"--razorSourceGenerator=" .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
        --"--razorDesignTimePath=" .. vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
        --"--extension",
        --vim.fs.joinpath(rzls_path, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
      }

      vim.lsp.config("roslyn", {
        --cmd = cmd,
        --handlers = require("rzls.roslyn_handlers"),
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,

            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
          ["csharp|completion"] = {
            dotnet_provide_regex_completions = false,
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true
          }
        }
      })
      vim.lsp.enable("roslyn")
    end,
    init = function ()
      -- We add the Razor file types before the plugin loads.
      vim.filetype.add({
        extension = {
          razor = "razor",
          cshtml = "razor"
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      --"tris203/rzls.nvim",
      "seblyng/roslyn.nvim",
      --{
      --  "GustavEikaas/easy-dotnet.nvim",
      --  dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
      --  config = function()
      --    require("easy-dotnet").setup()
      --  end
      --}
    },
    opts = {
      on_init = function (client)
        client.config.flags = client.config.flags or {}
        client.config.flags.allow_incremental_sync = true
      end,
      servers = {
        pylsp = true,
        html = true,
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
            if client.workspace_folders then
              local path = client.workspace_folders[1].name
              if path ~= vim.fn.stdpath('config')
                 and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then

                 return
              end
            end

            client.config.settings.Lua = vim.tbl_deep_extend(
              'force',
              client.config.settings.Lua, {
                runtime = {
                  -- default for ls lua neovim version
                  version = 'LuaJIT'
                  -- Help in the search/loading of files when 'require' is
                  -- used
                },
                diagnostics = {
                  globals = { 'vim' }
                },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME
                  }
                }
              }
            )
            client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          end,
          settings = {
            Lua = {}
          }
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
        },
        --roslyn = {
        --  cmd =  {
        --    vim.fs.joinpath(vim.fn.stdpath("data"), "mason/packages/roslyn/", "roslyn"),
        --    "--stdio",
        --    "--logLevel=Information",
        --    "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        --    "--razorSourceGenerator=" .. vim.fs.joinpath(vim.fn.stdpath("data"), "mason/packages/rzls-unstable/libexec", "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
        --    "--razorDesignTimePath=" .. vim.fs.joinpath(vim.fn.stdpath("data"), "mason/packages/rzls-unstable/libexec", "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targtets"),
        --    "--extension",
        --    vim.fs.joinpath(vim.fn.stdpath("data"), "mason/packages/rzls-unstable/libexec", "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll")
        --  },
        --  --config = {
        --  --  handlers = require("rzls.roslyn_handlers"),
        --  --}
        --}
      },
    },
    config = function (_, opts)
      require("plugins.lsp.utils").setup_lsp(opts)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "jdtls",
        -- "ts_ls",
        "gradle_ls",
        "gopls",
        "pylsp",
        "html",     -- 
        "cssls",    -- This four lsp's use the same resource 
        "jsonls",   -- hrsh7th/vscode-langservers-extracted
        "eslint",   --
      },
    },
    dependencies = {
      "neovim/nvim-lspconfig"
    }
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

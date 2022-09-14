local mapper = vim.keymap.set

local has_lsp, nvim_lsp = pcall(require, "lspconfig")
if not has_lsp then
    print("NEOVIM DOESN'T HAVE LSP PLUGGED IN")
    return
end

local custom_init = function (client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local filetype_attach = setmetatable({
    html = function(client)
        vim.cmd [[
            augroup lsp_buf_format
                au! BufWritePre <buffer>
                autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
            augroup END
        ]]
    end,
},{
    __index = function()
        return function() end
    end,
})

local custom_attach = function(client)
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    mapper('i', '<c-s>', vim.lsp.buf.signature_help)

    mapper('n', 'gd', vim.lsp.buf.definition)
    mapper('n', 'gD', vim.lsp.buf.declaration)
    mapper('n', '<gi>', vim.lsp.buf.implementation)
    mapper('n', '<C-k>', vim.lsp.buf.signature_help)
    mapper('n', '<leader>D', vim.lsp.buf.type_definition)
    mapper('n', '<leader>rn', vim.lsp.buf.rename)
    mapper('n', '<leader>ca', vim.lsp.buf.code_action)
    mapper('n', 'gr', vim.lsp.buf.references)
    mapper('n', '<leader>f', vim.lsp.buf.formatting)

    if filetype ~= "lua" then
        mapper('n', 'K', vim.lsp.buf.hover)
    end

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Attach any filetype specific options to the client
    filetype_attach[filetype](client)
end

--{{{
--Sumneko_lua thinks
local system_name
local sumneko_root_path
if vim.fn.has("mac") == 1 then
    system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
    sumneko_root_path = "/home/ordep/my_repositories/lua-language-server"
elseif vim.fn.has("win32") == 1 then
    system_name = "Windows"
    sumneko_root_path = "D:/pnrv2/Documents/Programas/lua/lua-language-server"
else
    print("Unsuported system for sumneko")
end

local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
--}}}

-- Other installed servers
-- denols
-- jdtls
-- pyright
-- tsserver
-- pylsp
-- hls
local servers = {
    pylsp = true,
    html = false,
    cssls = true,
    jsonls = false,
    jdtls = true,
    hls = true,
    -- {
    --     cmd = {
    --         'haskell-language-server-wrapper-1.7.0.0', '--lsp'
    --     }
    -- },
    sumneko_lua = {
        cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = runtime_path,
                },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
            },
        },
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
}

local setup_server = function (server, config)
    if not config then
        return
    end

    if type(config) ~= "table" then
        config = {}
    end

    config = vim.tbl_deep_extend("force", {
        on_init = custom_init,
        on_attach = custom_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 50,
        },
    }, config)

    nvim_lsp[server].setup(config)
end

for server, config in pairs(servers) do
    setup_server(server, config)
end

return {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = capabilities,
}

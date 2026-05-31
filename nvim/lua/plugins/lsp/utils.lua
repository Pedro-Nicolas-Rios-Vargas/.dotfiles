local M = {}

function M.setup_lsp(opts)
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

    config = vim.tbl_deep_extend("force", {
      on_init = custom_init,
      on_attach = custom_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 50,
      },
    }, config)

    vim.lsp.config(server, config)
  end

  for server, config in pairs(servers) do
    setup(server, config)
  end
end

return M

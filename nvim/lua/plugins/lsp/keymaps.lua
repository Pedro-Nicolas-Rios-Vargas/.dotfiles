local filetype_attach = setmetatable({
  html = function(client)
    vim.cmd [[
    augroup lsp_buf_format
      au! BufWritePre <buffer>
      autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
    augroup END
    ]]
  end,
}, {
  __index = function ()
    return function () end
  end
})

local custom_attach = function(client, bufnr)
  local mapper = vim.keymap.set
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  mapper('i', '<c-s>', vim.lsp.buf.signature_help, { desc = "LSP Display signature information about the symbols under the cursor in a floating window."})

  mapper('n', 'gd', vim.lsp.buf.definition, { desc = "LSP Jumps to the definition of the symbol under the cursor." })
  mapper('n', 'gD', vim.lsp.buf.declaration, { desc = "LSP Jumps to the declaration of the symbol under the cursor." })
  mapper('n', '<gi>', vim.lsp.buf.implementation, { desc = "LSP Lsts all the implementations for the symbol under the cursor in the quickfix window." })
  mapper('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "LSP Displays signature information about the symbol under the cursor in a floating window." })
  mapper('n', '<leader>D', vim.lsp.buf.type_definition, { desc = "LSP Jumps to the definition of the type of the symbol under the cursor." })
  mapper('n', '<leader>rn', vim.lsp.buf.rename, { desc = "LSP Renames all references to the symbol under the cursor." })
  mapper('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "LSP Selects a code action available at the current cursor position." })
  mapper('n', 'gr', vim.lsp.buf.references, { desc = "LSP Lists all the references to the symbol under the cursor in the quickfix window." })
  mapper('n', '<leader>f', vim.lsp.buf.format, { desc = "LSP Formats a buffer using the attached (and optionally filtered) language server clients." })

  if filetype ~= "lua" then
      mapper('n', 'K', vim.lsp.buf.hover, { desc = "LSP Displays hover information about the symbol under the cursor in a floating window. Calling the function twice will jump into the floating window." })
  end

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Attach any filetype specific options to the client
  filetype_attach[filetype](client)
end

return custom_attach

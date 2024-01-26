local yank_group = vim.api.nvim_create_augroup("yanking", {
  clear = false
})
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = yank_group,
  pattern = "*",
  callback = function (_)
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 150, on_visual = true }
  end
})

local jdtls_lsp = vim.api.nvim_create_augroup("jdtls_lsp", {
  clear = false
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = jdtls_lsp,
  pattern = "java",
  callback = function (_)
    require("plugins.lsp.jdtls.jdtls_setup").setup()
  end
})

return {
  "AndrewRadev/splitjoin.vim",
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app & yarn install",
    init = function ()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true,
    keys = {
      { "<esc>", [[<C-\><C-n>]], mode = "t", desc = "ToggleTerm escapes the terminal buffer to Normal mode" },
      { "<a-1>", ":ToggleTerm size=50 direction=horizontal<CR>", desc = "ToggleTerm toggle a terminal buffer in a float windows" },
      { "<a-2>", ":ToggleTerm direction=float<CR>", desc = "ToggleTerm toggle a terminal buffer in a float windows" },
    }
  }
}

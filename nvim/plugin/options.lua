local opt = vim.opt

opt.langmenu = "en_US.UTF-8"

-- tab things
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.backupcopy = "yes"

-- show the relative number of lines from cursor
opt.relativenumber = true
-- show the real number of actual line.
opt.number = true
-- Highlight search
opt.hlsearch = true
-- Retain the buffers (windows/files) opened.
opt.hidden = true
opt.wrap = false
opt.colorcolumn = "80"
opt.signcolumn = "yes"
opt.incsearch = true -- Move the cursor to the closer pattern matched to cursor.
opt.scrolloff = 8
opt.showmode = false
opt.termguicolors = true
opt.encoding = "UTF-8"
opt.modelines = 0

-- windows things
opt.splitright = true

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

opt.relativenumber = true -- show the relative number of lines from cursor
opt.number = true -- and show the real number of actual line.
opt.hlsearch = true -- Highlight search
opt.hidden = true -- Retain the buffers (windows/files) opened.
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

-- complete options for nvim-cmp
--vim.o.completeopt = "menuone,noinsert,noselect"

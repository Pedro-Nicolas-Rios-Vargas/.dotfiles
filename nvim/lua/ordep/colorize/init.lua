local has_nvim_colorizer, colorizer = pcall(require, "colorizer")
if not has_nvim_colorizer then
    print("Nvim-colorizer isn't installed yet.")
    return
end

vim.o.termguicolors = true
colorizer.setup()

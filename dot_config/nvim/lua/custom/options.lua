vim.wo.relativenumber = true
vim.opt.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.scrolloff = 10
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.backspace = { "start", "eol", "indent" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
  end,
})

-- 基础设置
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- 剪贴板设置
vim.schedule(function()
  pcall(function()
    vim.opt.clipboard = "unnamedplus"
  end)
end)

-- Leader 键设置
vim.g.mapleader = " "
vim.g.maplocalleader = " "

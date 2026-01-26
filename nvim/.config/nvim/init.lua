require("config.lazy")

-- 基础UI设置
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

-- 编码和剪贴板设置
vim.opt.encoding = "utf-8"
-- Avoid E21 when current buffer is not modifiable (e.g. Lazy UI)
vim.opt_global.fileencoding = "utf-8"
-- 安全设置剪贴板，避免在某些环境下的错误
vim.schedule(function()
  pcall(function()
    vim.opt.clipboard = "unnamedplus"
  end)
end)

-- 缩进设置
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- 显示和行为设置
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.colorcolumn = "100"
-- 代码折叠设置
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false

-- 搜索行为设置
-- 搜索时忽略大小写
vim.opt.ignorecase = true
-- 搜索包含大写字母时区分大小写
vim.opt.smartcase = true
-- 高亮搜索匹配结果
vim.opt.hlsearch = true
-- 实时显示搜索结果（增量搜索）
vim.opt.incsearch = true

-- 窗口管理设置
vim.opt.splitright = true
vim.opt.splitbelow = true

-- 性能设置
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

-- 启用所有模式的鼠标支持
vim.opt.mouse = "a"

-- 禁用交换文件（不产生.swp文件）
vim.opt.swapfile = false
-- 禁用备份文件（不产生~备份文件）
vim.opt.backup = false
-- 启用持久撤销
vim.opt.undofile = true

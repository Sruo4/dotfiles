require("config.lazy")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.expandtab      = true -- <Tab> 用空格替代
vim.opt.tabstop        = 4      -- 1 个 <Tab> 占多少列
vim.opt.softtabstop    = 4      -- <Tab>/<BS> 在插入模式下移动的列数
vim.opt.shiftwidth     = 4      -- >> << 或自动缩进宽度
vim.opt.smartindent    = true   -- 新行前自动对齐上一层缩进
vim.opt.wrap = false -- 长行不自动折行（需要折行时再手工开）
vim.opt.scrolloff = 8 -- 光标距离上下边 8 行
vim.opt.sidescrolloff = 8
-- vim.opt.virtualedit    = 'block'-- 允许在虚拟列（不存在的列）中移动，方便块选

vim.opt.colorcolumn = '80'

-- 文件安全与恢复
vim.opt.swapfile = false           -- 不创建交换文件(.swp)
vim.opt.backup = false             -- 不创建备份文件(~文件)
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true            -- 启用持久化撤销


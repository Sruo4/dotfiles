local vscode = require("vscode")

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 调用 VSCode 命令的辅助函数
local function call(cmd)
  return function()
    vscode.call(cmd)
  end
end

-- 文件操作
keymap("n", "<leader>w", call("workbench.action.files.save"), opts)
keymap("n", "<leader>q", call("workbench.action.closeActiveEditor"), opts)
keymap("n", "<leader>e", call("workbench.action.toggleSidebarVisibility"), opts)

-- 文件查找
keymap("n", "<leader>ff", call("workbench.action.quickOpen"), opts)
keymap("n", "<leader>fg", call("workbench.action.findInFiles"), opts)
keymap("n", "<leader>fb", call("workbench.action.showAllEditorsByMostRecentlyUsed"), opts)
keymap("n", "<leader>fr", call("workbench.action.openRecent"), opts)

-- 代码导航
keymap("n", "gd", call("editor.action.revealDefinition"), opts)
keymap("n", "gr", call("editor.action.goToReferences"), opts)
keymap("n", "gi", call("editor.action.goToImplementation"), opts)
keymap("n", "gt", call("editor.action.goToTypeDefinition"), opts)
keymap("n", "K", call("editor.action.showHover"), opts)

-- 代码操作
keymap("n", "<leader>ca", call("editor.action.quickFix"), opts)
keymap("n", "<leader>rn", call("editor.action.rename"), opts)
keymap("n", "<leader>cf", call("editor.action.formatDocument"), opts)
keymap("v", "<leader>cf", call("editor.action.formatSelection"), opts)

-- 折叠
keymap("n", "za", call("editor.toggleFold"), opts)
keymap("n", "zR", call("editor.unfoldAll"), opts)
keymap("n", "zM", call("editor.foldAll"), opts)
keymap("n", "zo", call("editor.unfold"), opts)
keymap("n", "zc", call("editor.fold"), opts)

-- 窗口/编辑器导航
keymap("n", "<C-h>", call("workbench.action.focusLeftGroup"), opts)
keymap("n", "<C-l>", call("workbench.action.focusRightGroup"), opts)
keymap("n", "<C-j>", call("workbench.action.focusBelowGroup"), opts)
keymap("n", "<C-k>", call("workbench.action.focusAboveGroup"), opts)

-- 分屏
keymap("n", "<leader>sv", call("workbench.action.splitEditorRight"), opts)
keymap("n", "<leader>sh", call("workbench.action.splitEditorDown"), opts)

-- 注释（使用 VSCode 原生注释）
keymap("n", "gcc", call("editor.action.commentLine"), opts)
keymap("v", "gc", call("editor.action.commentLine"), opts)

-- Git 操作
keymap("n", "<leader>gg", call("workbench.view.scm"), opts)
keymap("n", "<leader>gb", call("gitlens.toggleFileBlame"), opts)

-- 终端
keymap("n", "<leader>t", call("workbench.action.terminal.toggleTerminal"), opts)

-- 问题面板
keymap("n", "<leader>xx", call("workbench.actions.view.problems"), opts)
keymap("n", "]d", call("editor.action.marker.next"), opts)
keymap("n", "[d", call("editor.action.marker.prev"), opts)

-- 书签（如果安装了 Bookmarks 扩展）
keymap("n", "mm", call("bookmarks.toggle"), opts)
keymap("n", "mn", call("bookmarks.jumpToNext"), opts)
keymap("n", "mp", call("bookmarks.jumpToPrevious"), opts)
keymap("n", "ma", call("bookmarks.listFromAllFiles"), opts)

-- 更好的缩进（保持选中状态）
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- 移动选中的行
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- 保持光标居中
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- 取消高亮
keymap("n", "<leader>nh", ":nohl<CR>", opts)

-- 删除不覆盖寄存器
keymap("x", "<leader>p", [["_dP]], opts)
keymap({ "n", "v" }, "<leader>d", [["_d]], opts)

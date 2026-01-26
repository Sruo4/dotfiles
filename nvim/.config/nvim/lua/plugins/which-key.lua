return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "modern",
        delay = 500,
        icons = {
            breadcrumb = "»",
            separator = "➜",
            group = "+",
        },
        spec = {
            -- 文件管理分组
            { "<leader>f", group = "查找" },
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "查找文件" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "全局搜索" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "查找缓冲区" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "帮助标签" },
            { "<leader>fr", "<cmd>Neotree reveal_force_cwd<CR>", desc = "在文件树中显示当前文件" },

            -- 文件树分组
            { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "切换文件树" },

            -- Git分组
            { "<leader>g", group = "Git" },
            { "<leader>gs", "<cmd>Git<CR>", desc = "Git状态" },
            { "<leader>gd", "<cmd>Gitsigns diffthis<CR>", desc = "查看差异" },
            { "<leader>gb", "<cmd>Git blame<CR>", desc = "查看责任" },
            { "<leader>gh", "<cmd>Telescope git_branches<CR>", desc = "切换分支" },
            { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "查看提交" },

            -- 缓冲区操作
            { "<leader>b", group = "缓冲区" },
            { "<leader>bd", "<cmd>bdelete<CR>", desc = "关闭缓冲区" },
            { "<leader>bn", "<cmd>bnext<CR>", desc = "下一个缓冲区" },
            { "<leader>bp", "<cmd>bprevious<CR>", desc = "上一个缓冲区" },
            { "<leader>bl", "<cmd>Telescope buffers<CR>", desc = "缓冲区列表" },

            -- 窗口管理
            { "<leader>w", group = "窗口" },
            { "<leader>wv", "<cmd>vsplit<CR>", desc = "垂直分割" },
            { "<leader>ws", "<cmd>split<CR>", desc = "水平分割" },
            { "<leader>wc", "<cmd>close<CR>", desc = "关闭窗口" },
            { "<leader>wo", "<cmd>only<CR>", desc = "关闭其他窗口" },
            { "<leader>wh", "<C-w>h", desc = "左窗口" },
            { "<leader>wj", "<C-w>j", desc = "下窗口" },
            { "<leader>wk", "<C-w>k", desc = "上窗口" },
            { "<leader>wl", "<C-w>l", desc = "右窗口" },

            -- 系统操作
            { "<leader>q", group = "退出" },
            { "<leader>qq", "<cmd>q<CR>", desc = "退出" },
            { "<leader>qw", "<cmd>wq<CR>", desc = "保存并退出" },
            { "<leader>qa", "<cmd>qa<CR>", desc = "全部退出" },

            -- 搜索
            { "<leader>s", group = "搜索" },
            { "<leader>ss", "<cmd>Telescope grep_string<CR>", desc = "搜索光标下文字" },
            { "<leader>sr", "<cmd>Telescope oldfiles<CR>", desc = "最近文件" },
            { "<leader>sc", "<cmd>Telescope commands<CR>", desc = "命令" },
            { "<leader>sh", "<cmd>Telescope command_history<CR>", desc = "命令历史" },

            -- Git signs 映射
            { "]c", "<cmd>Gitsigns next_hunk<CR>", desc = "下一个变更" },
            { "[c", "<cmd>Gitsigns prev_hunk<CR>", desc = "上一个变更" },
            { "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", desc = "暂存变更" },
            { "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", desc = "重置变更" },
            { "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", desc = "预览变更" },

            -- LSP分组
            { "<leader>l", group = "LSP" },
            { "<leader>ld", vim.diagnostic.open_float, desc = "显示诊断" },
            { "<leader>lr", "<cmd>LspUI rename<CR>", desc = "重命名" },
            { "<leader>la", "<cmd>LspUI code_action<CR>", desc = "代码操作" },
            { "<leader>lf", function() vim.lsp.buf.format { async = true } end, desc = "格式化" },
            { "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", desc = "文档符号" },
            { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "工作区符号" },
            { "<leader>lD", vim.lsp.buf.type_definition, desc = "类型定义" },
            { "<leader>lwa", vim.lsp.buf.add_workspace_folder, desc = "添加工作区文件夹" },
            { "<leader>lwr", vim.lsp.buf.remove_workspace_folder, desc = "移除工作区文件夹" },
            { "<leader>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "列出工作区文件夹" },
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "显示缓冲区键位",
        },
        {
            "<leader><space>",
            function()
                require("which-key").show()
            end,
            desc = "显示全局键位",
        },
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
    end,
}

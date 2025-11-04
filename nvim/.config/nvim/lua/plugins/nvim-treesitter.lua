return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = 'main',
        build = ":TSUpdate",
        opts = function()
            return {
                ensure_installed = {
                    "python", "lua", "vim", "javascript", "html", "css", "json", "yaml",
                    "markdown", "bash", "dockerfile", "sql", "toml"
                },

                -- 启用语法高亮模块
                highlight = {
                    additional_vim_regex_highlighting = false,
                    enable = true,
                },
                indent = {
                    enable = true,
                },
                -- 确保在后台同步安装解析器
                sync_install = false,
                -- 自动安装缺失的解析器
                auto_install = true,
            }
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require('treesitter-context').setup({
                enable = true,           -- 启用插件
                max_lines = 3,           -- 上下文窗口最多�
                min_window_height = 0,   -- 即使窗口很小也显示
                line_numbers = true,
                multiline_threshold = 2, -- 单行上下文超过2行时才多行显示
                trim_scope = 'outer',    -- 显示从最外层开始的上下文
                mode = 'cursor',         -- 'cursor': 跟随光标; 'topline': 跟随屏幕顶行
                -- separator = '-',
                zindex = 20,
                on_attach = nil, -- 回调函数
            })
        end
    }
}

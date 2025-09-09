return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        style = "night", -- tokyonight theme
    },
    config = function(_, opts)
        -- 设置背景为 dark (对于 night, storm 等深色主题是好习惯)
        vim.opt.background = "dark"

        -- 加载配置并应用色彩主题
        require("tokyonight").setup(opts)
        vim.cmd.colorscheme("tokyonight")
    end,
}

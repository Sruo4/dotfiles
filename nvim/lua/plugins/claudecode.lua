return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- 必需，用于git等功能
  },
  config = function()
    require("claude-code").setup({
      -- 窗口配置：这里用浮动窗，方便随时呼出
      window = {
        position = "float",
        float = {
          width = "90%",
          height = "90%",
          row = "center",
          col = "center",
          relative = "editor",
          border = "double",
        },
        enter_insert = true, -- 打开后直接进入插入模式
      },
      -- 文件刷新配置
      refresh = {
        enable = true,
        updatetime = 100,
        timer_interval = 1000,
        show_notifications = true,
      },
      -- Git 项目相关
      git = { use_git_root = true },
      -- 命令设置（可添加 variants）
      command = "claude",
      command_variants = {
        continue = "--continue",
        resume = "--resume",
        verbose = "--verbose",
      },
      -- 快捷键设置
      keymaps = {
        toggle = {
          normal = "<C-,>",
          terminal = "<C-,>",
          variants = {
            continue = "<leader>cC",
            verbose = "<leader>cV",
          },
        },
        window_navigation = true,
        scrolling = true,
      },
    })
  end,
}


return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    -- 设置默认终端方向为浮动窗口
    direction = "float",
    -- 浮动窗口的配置
    float_opts = {
      border = "double",  -- 边框样式（double/single/shadow/rounded 等）
      winblend = 0,       -- 透明度（0-100，0 为不透明）
      -- 其他可选配置
      -- width = function() return math.floor(vim.o.columns * 0.8) end,  -- 宽度占屏幕 80%
      -- height = function() return math.floor(vim.o.lines * 0.8) end,    -- 高度占屏幕 80%
      -- title_pos = "center",  -- 标题位置（left/center/right）
    },
    -- 其他可选配置
    size = 20,           -- 非浮动模式下的默认大小（这里可忽略，因为已设为 float）
    open_mapping = [[<c-\>]],  -- 切换终端的快捷键（Ctrl+\）
    start_in_insert = true,    -- 打开终端时自动进入插入模式
  }
}


-- VSCode-Neovim 专用配置
-- 此配置仅在 VSCode 中使用 vscode-neovim 插件时加载

local config_dir = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")
vim.opt.rtp:prepend(config_dir)
package.path = table.concat({
  config_dir .. "/lua/?.lua",
  config_dir .. "/lua/?/init.lua",
  package.path,
}, ";")

require("config.options")
require("config.plugins")
require("config.keymaps")

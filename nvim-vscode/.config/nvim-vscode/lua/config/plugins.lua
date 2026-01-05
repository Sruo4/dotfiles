-- Lazy.nvim 插件管理器（仅管理轻量编辑类插件）
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "rhysd/clever-f.vim",
    init = function()
      vim.g.clever_f_smart_case = 1
      vim.g.clever_f_fix_key_direction = 1
      vim.g.clever_f_repeat_last_char_inputs = { "\r", "\n" }
    end,
  },
})

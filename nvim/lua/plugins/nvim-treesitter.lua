return {
  {
      "nvim-treesitter/nvim-treesitter", 
      branch = 'main', 
      lazy = false, 
      build = ":TSUpdate",
      opts = {
          ensure_installed = {
              "python", "lua", "vim", "javascript", "html", "css", "json", "yaml", 
              "markdown", "bash", "dockerfile", "sql", "toml"
          },
          highlight = {
              enable = true,
          },
      }
  }
}

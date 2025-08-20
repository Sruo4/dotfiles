return {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.8',
    dependencies = { 
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        
        -- 修复treesitter兼容性问题
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = { "node_modules", ".git" },
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    },
                },
                -- 禁用treesitter高亮避免兼容性问题
                preview = {
                    treesitter = false
                }
            },
--[[             extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
  ]]       })
    end,
}

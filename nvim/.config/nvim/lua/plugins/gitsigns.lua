return {
    'lewis6991/gitsigns.nvim',
    opts = {
        signs = {
            add          = { text = '+' },
            change       = { text = '~' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signcolumn = true,
        current_line_blame = true,
        on_attach = function(bufnr)
            local gitsigns = require('gitsigns')

            vim.keymap.set('n', ']c', gitsigns.next_hunk, { buffer = bufnr, desc = "下一个变更" })
            vim.keymap.set('n', '[c', gitsigns.prev_hunk, { buffer = bufnr, desc = "上一个变更" })
            vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { buffer = bufnr, desc = "暂存变更" })
            vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { buffer = bufnr, desc = "重置变更" })
            vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { buffer = bufnr, desc = "预览变更" })
        end
    }
}

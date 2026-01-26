return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = { "lua_ls", "pyright", "ruff" },
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    config = function()
        -- Enable language servers using new Nvim 0.11+ API
        vim.lsp.enable('lua_ls')
        vim.lsp.enable('pyright')
        vim.lsp.enable('ruff')

        -- Global diagnostic keybindings (non-leader keys)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = '上一个诊断' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = '下一个诊断' })

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings (non-leader keys)
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

                -- LspUI mappings
                vim.keymap.set('n', 'K', '<cmd>LspUI hover<CR>', opts)
                vim.keymap.set('n', 'gr', '<cmd>LspUI reference<CR>', opts)
                vim.keymap.set('n', '<leader>rn', '<cmd>LspUI rename<CR>', { buffer = ev.buf, desc = '重命名符号' })
                vim.keymap.set('n', '<leader>ca', '<cmd>LspUI code_action<CR>', { buffer = ev.buf, desc = '代码操作' })
            end,
        })
    end
}

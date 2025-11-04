return {
    'MattesGroeger/vim-bookmarks',
    keys = {
        { 'mm', '<Plug>BookmarkToggle' },
        { 'mi', '<Plug>BookmarkAnnotate' },
        { 'ma', '<Plug>BookmarkShowAll' },
        { 'mn', '<Plug>BookmarkNext' },
        { 'mp', '<Plug>BookmarkPrev' },
        { 'mx', '<Plug>BookmarkClearAll' },
        { 'mc', '<Plug>BookmarkClear' },
    },
    config = function()
        vim.g.bookmark_highlight_lines = 1
        vim.api.nvim_set_hl(0, 'BookmarkLine', { bg = '#FDFD96' })
        vim.api.nvim_set_hl(0, 'BookmarkSign', { fg = '#E34234', bold = true })
        vim.api.nvim_set_hl(0, 'BookmarkAnnotationLine', { bg = '#ADD8E6' })
        vim.api.nvim_set_hl(0, 'BookmarkAnnotationSign', { fg = '#50C878' })
    end,
}

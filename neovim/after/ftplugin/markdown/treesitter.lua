vim.treesitter.start(0, 'markdown')
vim.treesitter.start(0, 'markdown_inline')

vim.opt_local.foldmethod = 'expr'
vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

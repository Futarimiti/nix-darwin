vim.lsp.start {
  cmd = { 'lua-language-server' },
  name = 'lua-ls',
  root_dir = vim.fs.root(0, { '.luarc.json', '.git' }),
}

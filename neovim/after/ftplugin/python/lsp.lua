vim.lsp.start {
  cmd = { 'pyright-langserver', '--stdio' },
  name = 'pyright',
  root_dir = vim.fs.root(0, { '__init__.py', '.git', 'pyrightconfig.json' }),
}

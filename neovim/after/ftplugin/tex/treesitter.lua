vim.treesitter.start(0, 'latex')

vim.keymap.set(
  'n',
  '<localleader>I',
  function() vim.treesitter.inspect_tree { lang = 'latex' } end,
  { buffer = true }
)

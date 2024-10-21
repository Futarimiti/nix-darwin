vim.keymap.set(
  { 'n', 'v' },
  '<leader>x',
  [[:substitute/\v(\s*)- \[ \]/\1- \[x\]<CR><CMD>nohlsearch<CR>]],
  { buffer = true, silent = true }
)

local nix_darwin = vim.fs.normalize '$XDG_CONFIG_HOME/nix-darwin'
if vim.fn.isdirectory(nix_darwin) == 0 then return end
nix_darwin = vim.fn.fnamemodify(nix_darwin, ':~')

vim.keymap.set('n', '<localleader>n', ':edit ' .. nix_darwin .. '/**/')
vim.keymap.set('n', '<localleader>N', ':vimgrep  ' .. nix_darwin .. '/**<C-Left><Left>')
vim.keymap.set('c', '<C-Space>n', nix_darwin .. '/**/', { nowait = true })
vim.keymap.set('c', '<C-Space><C-N>', '<C-Space>n', { nowait = true, remap = true })

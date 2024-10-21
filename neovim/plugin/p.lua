-- not sure where to put this...

local has_preview_window = function()
  return vim
    .iter(vim.fn.getwininfo())
    :any(function(win) return vim.fn.win_gettype(win.winnr) == 'preview' end)
end

local project_dir = vim.fs.normalize '~/Documents/Projects'

vim.keymap.set(
  'n',
  '<localleader>p',
  function()
    return has_preview_window() and '<CMD>pclose<CR>' or (':edit %s/**/'):format(project_dir)
  end,
  { expr = true }
)

vim.keymap.set(
  'n',
  '<localleader>P',
  function() return (':vimgrep  %s/**<C-Left><Left>'):format(project_dir) end,
  { expr = true }
)

vim.keymap.set('c', '<C-Space>p', project_dir, { expr = true })
vim.keymap.set('c', '<C-Space><C-P>', '<C-Space>p', { remap = true })

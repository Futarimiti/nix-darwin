-- FIXME cmdline is faked - no full completion

vim.keymap.set('n', 'y:', function()
  local ok, input_cmd = pcall(vim.fn.input, {
    prompt = '(yank) :',
    default = '',
    completion = 'command',
    cancelreturn = '',
  })
  if not ok or input_cmd == '' then return end
  local output = vim.api.nvim_exec2(input_cmd, { output = true }).output
  if output == '' then return end
  vim.fn.setreg(vim.v.register, output)
end)

-- opens a window with cmd output
vim.keymap.set('n', '<C-W>:', function()
  local ok, input_cmd = pcall(vim.fn.input, {
    prompt = '(capture) :',
    default = '',
    completion = 'command',
    cancelreturn = '',
  })
  if not ok or input_cmd == '' then return end
  local output = vim.api.nvim_exec2(input_cmd, { output = true }).output
  if output == '' then return end
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, '\n'))
  local win = vim.api.nvim_open_win(buf, true, {
    height = vim.o.cmdwinheight,
    split = 'below',
    win = 0,
  })
  vim.wo[win].statusline = ':' .. input_cmd
end)

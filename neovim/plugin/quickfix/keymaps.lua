local qf = function()
  if vim.iter(vim.fn.getwininfo()):any(function(win) return win.quickfix == 1 end) then
    vim.cmd.cclose()
  else
    if vim.fn.exists ':Copen' == 2 then vim.cmd.Copen() end
    vim.cmd.copen()
  end
end
vim.keymap.set('n', '<localleader>q', qf)
vim.keymap.set('n', '<localleader>c', qf)
vim.keymap.set('n', '<localleader>l', function()
  if vim.iter(vim.fn.getwininfo()):any(function(win) return win.loclist == 1 end) then
    vim.cmd.lclose()
  else
    local successful, _ = pcall(vim.cmd.lwindow)
    if not successful then
      vim.schedule(
        function() vim.api.nvim_echo({ { 'E776: No location list', 'ErrorMsg' } }, true, {}) end
      )
    end
  end
end)

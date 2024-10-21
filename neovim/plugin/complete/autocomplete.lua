-- adapted from https://github.com/glepnir/nvim/blob/main/lua/internal/completion.lua

local group = vim.api.nvim_create_augroup('autocomplete', {})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'lsp autocomplete',
  group = group,
  callback = function(args)
    local buf = args.buf
    local client_id = args.data.client_id
    vim.lsp.completion.enable(true, client_id, buf, {
      autotrigger = true,
      convert = function(item) return { abbr = item.label:gsub('%b()', ''), kind = '' } end,
    })
    -- for chars not in triggerchars
    -- vim.api.nvim_create_autocmd('InsertCharPre', {
    --   buffer = buf,
    --   group = group,
    --   callback = function()
    --     if
    --       vim.fn.pumvisible() == 0
    --       and vim.v.char:match '[%w_]'
    --       and not vim.list_contains(
    --         vim.tbl_get(
    --           vim.lsp.get_client_by_id(client_id),
    --           'server_capabilities',
    --           'completionProvider',
    --           'triggerCharacters'
    --         ) or {},
    --         vim.v.char
    --       )
    --     then
    --       vim.lsp.completion.trigger()
    --     end
    --   end,
    -- })
  end,
})

local complete_in_progress = false

vim.api.nvim_create_autocmd('InsertCharPre', {
  desc = 'filepath & keyword completion',
  group = group,
  callback = function(args)
    if complete_in_progress or vim.fn.pumvisible() == 1 then return end
    complete_in_progress = true
    local buf = args.buf
    if vim.tbl_contains({ 'terminal', 'prompt', 'help' }, vim.bo[buf].buftype) then return end
    if vim.v.char == '/' then
      vim.api.nvim_feedkeys(vim.keycode '<C-X><C-F>', 'ni', false)
    elseif
      vim.fn.match(vim.v.char, [[\k]]) ~= -1 -- inserted keyword
      and vim.tbl_isempty(vim.lsp.get_clients {
        bufnr = buf,
        method = vim.lsp.protocol.Methods.textDocument_completion,
      }) -- absence of lsp
    then
      vim.api.nvim_feedkeys(vim.keycode '<C-N>', 'ni', false)
    end
  end,
})

vim.api.nvim_create_autocmd({ 'TextChangedP', 'TextChangedI' }, {
  desc = 'finish autocomplete',
  group = group,
  callback = function() complete_in_progress = false end,
})

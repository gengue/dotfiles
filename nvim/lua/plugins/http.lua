-- HTTP clients and API tools - Currently using Kulala, extensible for other REST clients

vim.filetype.add {
  extension = {
    ['http'] = 'http',
  },
}

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    local buf_type = vim.api.nvim_buf_get_option(0, 'buftype')
    local buf_name = vim.api.nvim_buf_get_name(0)
    -- kulala.nvim UI buffers are usually 'nofile' and may have a specific name
    if buf_name:match 'kulala://ui' then
      vim.opt_local.foldenable = false
      vim.opt_local.foldmethod = 'manual'
      vim.opt_local.foldcolumn = '0'
    end
  end,
})

return {
  {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    keys = {
      { '<leader>Rs', desc = 'Send request' },
      { '<leader>Ra', desc = 'Send all requests' },
      { '<leader>Rb', desc = 'Open scratchpad' },
    },
    opts = {
      default_view = 'body',
      debug = false,
      global_keymaps = true,
      global_keymaps_prefix = '<leader>R',
      kulala_keymaps_prefix = '',
    },
  },
}

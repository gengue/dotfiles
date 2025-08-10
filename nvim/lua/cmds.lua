vim.api.nvim_create_user_command('JQ', '%!jq .', {
  desc = 'Format JSON with jq',
})

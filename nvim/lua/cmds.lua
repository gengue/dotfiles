vim.api.nvim_create_user_command('JQ', '%!jq .', {
  desc = 'Format JSON with jq',
})

vim.api.nvim_create_user_command('CopyFilePath', 'let @+=expand("%:p")', {
  desc = 'Copy full file path to clipboard',
})

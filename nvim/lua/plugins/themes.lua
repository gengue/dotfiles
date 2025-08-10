return {
  -- { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  -- { 'EdenEast/nightfox.nvim' },
  -- {
  --   'metalelf0/black-metal-theme-neovim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('black-metal').setup {}
  --     require('black-metal').load()
  --   end,
  -- },
  {
    'webhooked/kanso.nvim',
    lazy = false,
    priority = 1000,
  },
  { 'lunacookies/vim-colors-xcode' },
  {
    'f-person/auto-dark-mode.nvim',
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value('background', 'dark', {})
        -- vim.cmd 'colorscheme terafox'
        vim.cmd 'colorscheme kanso'
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value('background', 'light', {})
        -- vim.cmd 'colorscheme dawnfox'
        vim.cmd 'colorscheme xcodelight'
      end,
    },
  },

  { -- Nice cursor animation effect
    'sphamba/smear-cursor.nvim',
    opts = {},
  },
}

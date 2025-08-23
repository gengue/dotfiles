local italics = {
  comments = true,
  keywords = false,
  functions = false,
  strings = false,
  variables = false,
}

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = true,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = true,
  },
  {
    'tiesen243/vercel.nvim',
    lazy = true,
    opts = {
      transparent = true,
      theme = 'dark',
      italics = italics,
    },
  },
  {
    'rockerBOO/boo-colorscheme-nvim',
    lazy = true,
    config = function()
      require('boo-colorscheme').use {
        italic = true,
      }
    end,
  },
  { 'kyazdani42/blue-moon', lazy = true },
  { 'nikolvs/vim-sunbather', lazy = true },
  {
    'metalelf0/black-metal-theme-neovim',
    lazy = true,
    priority = 1000,
    config = function()
      require('black-metal').setup {}
      require('black-metal').load()
    end,
  },
  {
    'webhooked/kanso.nvim',
    lazy = false,
    priority = 1000,
    opts = { transparent = true },
  },
  { 'lunacookies/vim-colors-xcode', lazy = true },
  {
    'f-person/auto-dark-mode.nvim',
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value('background', 'dark', {})
        -- vim.cmd 'colorscheme terafox'
        -- vim.cmd 'colorscheme base16-valua'
        vim.cmd 'colorscheme kanso-zen'
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

-- local italics = {
--   comments = true,
--   keywords = false,
--   functions = false,
--   strings = false,
--   variables = false,
-- }

return {
  -- { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  -- { 'EdenEast/nightfox.nvim' },
  -- {
  --   'tiesen243/vercel.nvim',
  --   opts = {
  --     theme = 'dark',
  --     italics = italics,
  --   },
  -- },
  -- { 'atmosuwiryo/vim-winteriscoming' },
  -- {
  --   'rockerBOO/boo-colorscheme-nvim',
  --   config = function()
  --     require('boo-colorscheme').use {
  --       italic = true,
  --     }
  --   end,
  -- },
  -- { 'kyazdani42/blue-moon' },
  -- { 'nikolvs/vim-sunbather' },
  -- { 'dasupradyumna/midnight.nvim', lazy = false, priority = 1000 },
  -- {
  --   'metalelf0/black-metal-theme-neovim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('black-metal').setup {}
  --     require('black-metal').load()
  --   end,
  -- },
  -- {
  --   'datsfilipe/vesper.nvim',
  --   config = function()
  --     require('vesper').setup {
  --       transparent = false,
  --       italics = italics,
  --       overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
  --       palette_overrides = {},
  --     }
  --   end,
  -- },
  {
    'webhooked/kanso.nvim',
    lazy = false,
    priority = 1000,
    opts = { transparent = true },
  },
  { 'lunacookies/vim-colors-xcode' },
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

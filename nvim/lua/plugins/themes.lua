local italics = {
  comments = true,
  keywords = false,
  functions = false,
  strings = false,
}

return {
  'MunifTanjim/nui.nvim',
  'nvim-telescope/telescope.nvim',
  {
    'folke/tokyonight.nvim',
    config = function()
      require('tokyonight').setup {
        transparent = true,
        styles = {
          sidebars = 'transparent',
          floats = 'transparent',
        },
      }
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        transparent_background = true,
      }
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      options = {
        transparent = true,
      },
    },
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = true,
    config = function()
      require('nightfox').setup {
        options = {
          -- transparent = true,
        },
      }
    end,
  },
  {
    'tiesen243/vercel.nvim',
    priority = 1000,
    opts = {
      transparent = true,
      theme = 'dark',
      italics = italics,
    },
    config = function(_, opts)
      local ok, vercel = pcall(require, 'vercel')
      if not ok then
        return
      end

      vercel.setup(opts)

      local function set_vercel_visual()
        local colors = vercel.colors
        local utils = vercel.utils
        local bg

        if colors and utils and colors.blue and colors.background then
          bg = utils.shade(colors.blue, 0.40, colors.background)
        end

        vim.api.nvim_set_hl(0, 'Visual', { bg = bg or '#1f4f6f' })
        vim.api.nvim_set_hl(0, 'VisualNOS', { link = 'Visual' })
      end

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = 'vercel',
        callback = set_vercel_visual,
      })

      vim.api.nvim_create_autocmd({ 'FileType', 'BufEnter' }, {
        callback = function()
          if vim.g.colors_name == 'vercel' then
            set_vercel_visual()
          end
        end,
      })

      if vim.g.colors_name == 'vercel' then
        set_vercel_visual()
      end
    end,
  },
  {
    'webhooked/kanso.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
  {
    'fraeso/xcodedark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('xcodedark').setup {
        transparent = true,
        integrations = {
          telescope = true,
          nvim_tree = true,
          gitsigns = true,
          bufferline = true,
          incline = true,
          lazygit = true,
          which_key = true,
          notify = true,
          snacks = true,
          blink = true,
        },
        terminal_colors = true,
      }
    end,
  },
  {
    'datsfilipe/vesper.nvim',
    config = function()
      require('vesper').setup {
        transparent = true,
        italic = italics,
        overrides = {},
        palette_overrides = {},
      }

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = 'vesper',
        callback = function()
          -- Indent guides
          -- vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#3a3a3a' })
          -- vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#3a3a3a' })
          -- vim.api.nvim_set_hl(0, 'IblScope', { fg = '#4a4a4a' })
          -- vim.api.nvim_set_hl(0, 'IblWhitespace', { fg = '#3a3a3a' })
          -- -- Window separators
          vim.api.nvim_set_hl(0, 'VertSplit', { fg = '#3a3a3a' })
          vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#3a3a3a' })
          -- Other whitespace characters
          vim.api.nvim_set_hl(0, 'Whitespace', { fg = '#3a3a3a' })
          vim.api.nvim_set_hl(0, 'NonText', { fg = '#3a3a3a' })
        end,
      })
    end,
  },
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_enable_italic = 0
      vim.g.everforest_transparent_background = 1
    end,
  },
  {
    'tiagovla/tokyodark.nvim',
    opts = {
      transparent_background = true,
    },
  },
  {
    'olivercederborg/poimandres.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('poimandres').setup {
        -- disable_background = true,
      }
    end,
  },
  {
    'oxfist/night-owl.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('night-owl').setup {
        transparent_background = true,
      }
    end,
  },
  {
    'dgox16/oldworld.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      terminal_colors = true,
      variant = 'default',
      integrations = {
        alpha = true,
        gitsigns = true,
        telescope = true,
        mason = true,
        notify = true,
        cmp = true,
      },
    },
    config = function()
      require('oldworld').setup {
        transparent = true,
        terminal_colors = true,
        variant = 'default',
        styles = {
          comments = { italic = true },
        },
        integrations = {
          alpha = true,
          gitsigns = true,
          telescope = true,
          mason = true,
          notify = true,
          cmp = true,
        },
      }

      -- Force transparent backgrounds for oldworld theme
      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = 'oldworld',
        callback = function()
          vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'NONE' })
          -- vim.api.nvim_set_hl(0, 'LineNr', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })
          -- vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'NONE' })
          -- vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
        end,
      })
    end,
  },
  {
    'HoNamDuong/hybrid.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'ramojus/mellifluous.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('mellifluous').setup {
        transparent_background = {
          enabled = true,
          floating_windows = true,
          telescope = true,
          file_tree = true,
          cursor_line = true,
          status_line = false,
        },
      }
    end,
  },

  -- {
  --   'Yazeed1s/oh-lucy.nvim',
  --   priority = 1000,
  -- },
  -- {
  --   'kyazdani42/blue-moon',
  --   opts = {
  --     termguicolors = true,
  --   },
  -- },
  -- {
  --   'kuri-sun/yoda.nvim',
  --   opts = {
  --     transparent = true,
  --     transparent_background = false,
  --   },
  -- },
  {
    'zenbones-theme/zenbones.nvim',
    lazy = false,
    priority = 1000,
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = 'rktjmp/lush.nvim',
    config = function()
      vim.g.neobones_transparent_background = true
      vim.g.forestbones_transparent_background = true
    end,
  },
  {
    'f-person/auto-dark-mode.nvim',
    dependencies = { 'projekt0n/github-nvim-theme', 'tiesen243/vercel.nvim' },
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.g.neovide_transparency = 0.98
        vim.api.nvim_set_option_value('background', 'dark', {})
        -- vim.cmd 'colorscheme terafox'
        -- vim.cmd 'colorscheme base16-valua'
        -- vim.cmd 'colorscheme kanso-zen'
        -- vim.cmd 'colorscheme neobones'
        vim.defer_fn(function()
          vim.cmd 'colorscheme vercel'
        end, 200)
      end,
      set_light_mode = function()
        vim.g.neovide_transparency = 0.98
        vim.api.nvim_set_option_value('background', 'light', {})
        vim.defer_fn(function()
          vim.cmd 'colorscheme github_light_default'
        end, 200)
        -- vim.cmd 'colorscheme dayfox'
        -- vim.cmd 'colorscheme neobones'
      end,
    },
  },

  { -- Nice cursor animation effect
    'sphamba/smear-cursor.nvim',
    opts = {
      stiffness = 0.6,
      trailing_stiffness = 0.5,
      -- cursor_color = '#333333',
    },
  },
}

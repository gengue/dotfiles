return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      '<c-\\>',
      function()
        Snacks.terminal.toggle(nil, { win = { position = 'float' } })
      end,
      mode = { 'n', 't' },
      desc = 'Toggle Terminal',
    },
    {
      '<c-t>=',
      function()
        Snacks.terminal.toggle(nil, { win = { position = 'bottom', height = 20 } })
      end,
      mode = { 'n', 't' },
      desc = 'Toggle Horizontal Terminal',
    },
    {
      '<c-t>|',
      function()
        Snacks.terminal.toggle(nil, { win = { position = 'float' } })
      end,
      mode = { 'n', 't' },
      desc = 'Toggle Floating Terminal',
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'LazyGit',
    },
  },
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        header = [[

 ██████╗ ███████╗███╗   ██╗███████╗███████╗██╗███████╗
██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔════╝██║██╔════╝
██║  ███╗█████╗  ██╔██╗ ██║█████╗  ███████╗██║███████╗
██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ╚════██║██║╚════██║
╚██████╔╝███████╗██║ ╚████║███████╗███████║██║███████║
 ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚══════╝╚═╝╚══════╝
]],
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = '⇄', key = 'G', desc = 'Git', action = ':LazyGit' },
          { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
    },

    bigfile = {
      enabled = true,
      notify = false, -- show notification when big file detected
      size = 1.5 * 1024 * 1024, -- 1.5MB
      line_length = 1000, -- average line length (useful for minified files)
    },

    input = { enabled = true },

    -- telescope alternative
    picker = {
      enabled = true,
      -- Use ripgrep/fd options to respect .gitignore
      sources = {
        files = {
          cmd = 'fd', -- Use fd for file finding (respects .gitignore by default)
          hidden = false,
          follow = false,
          -- fd respects .gitignore by default, these args ensure it
          args = { '--type', 'f', '--color', 'never' },
        },
        grep = {
          cmd = 'rg', -- Use ripgrep (respects .gitignore by default)
          hidden = false,
          -- rg respects .gitignore by default
          args = { '--color', 'never', '--smart-case' },
        },
      },
      formatters = {
        file = {
          filename_first = false, -- Show filepath naturally
        },
      },
    },

    -- toast notifications (also shows LSP progress, replaces fidget.nvim)
    notifier = {
      enabled = true,
      timeout = 3000,
    },

    -- When doing nvim somefile.txt, it will render the file as quickly as possible, before loading your plugins.
    quickfile = { enabled = true },

    -- Auto-show LSP references and quickly navigate between them
    words = { enabled = true },

    -- Terminal - replaces toggleterm.nvim
    terminal = {
      enabled = true,
      win = {
        position = 'float',
        border = 'rounded',
      },
    },

    -- LazyGit integration - replaces lazygit.nvim
    lazygit = {
      enabled = true,
      -- Fix for dimmed buffer after closing
      win = {
        backdrop = false, -- Disable the dimmed backdrop
      },
    },

    -- Auto-detect indentation - replaces guess-indent.nvim
    indent = {
      enabled = true,
      priority = 1, -- Run early
    },
  },
  config = function(_, opts)
    local Snacks = require 'snacks'
    Snacks.setup(opts)

    -- Picker keymaps (replacing Telescope)
    vim.keymap.set('n', '<leader>sh', function()
      Snacks.picker.help()
    end, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', function()
      Snacks.picker.keymaps()
    end, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', function()
      Snacks.picker.files()
    end, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', function()
      Snacks.picker()
    end, { desc = '[S]earch [S]elect Picker' })
    vim.keymap.set('n', '<leader>sw', function()
      Snacks.picker.grep_word()
    end, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', function()
      Snacks.picker.grep()
    end, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', function()
      Snacks.picker.diagnostics()
    end, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', function()
      Snacks.picker.resume()
    end, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', function()
      Snacks.picker.recent()
    end, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', function()
      Snacks.picker.buffers()
    end, { desc = '[ ] Find existing buffers' })

    -- Current buffer fuzzy find
    vim.keymap.set('n', '<leader>/', function()
      Snacks.picker.lines()
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- Grep in open files
    vim.keymap.set('n', '<leader>s/', function()
      Snacks.picker.grep {
        cwd = vim.fn.getcwd(),
        grep_open_files = true,
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Search Neovim config files
    vim.keymap.set('n', '<leader>sn', function()
      Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}

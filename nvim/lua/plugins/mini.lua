vim.api.nvim_set_keymap('n', '<leader>e', ':lua MiniFiles.open()<CR>', { noremap = true, silent = true, desc = 'Files explorer' })

return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    require('mini.icons').setup {
      -- Set to true if you have a Nerd Font
      use_nerd_font = vim.g.have_nerd_font,
    }

    require('mini.files').setup {
      windows = {
        -- preview = true,
      },
    }
    vim.keymap.set('n', '-', function()
      local MiniFiles = require 'mini.files'
      local _ = MiniFiles.close() or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
      vim.defer_fn(function()
        MiniFiles.reveal_cwd()
      end, 30)
    end, { noremap = true, silent = true, desc = 'Files explorer' })

    -- telescope alternative
    -- require('mini.pick').setup { }

    -- Auto pairs - replaces nvim-autopairs
    require('mini.pairs').setup()

    -- Clue for key hints - replaces which-key
    local miniclue = require 'mini.clue'
    miniclue.setup {
      triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
      },

      clues = {
        -- Enhance this by adding descriptions for your custom mappings
        { mode = 'n', keys = '<Leader>s', desc = '+[S]earch' },
        { mode = 'n', keys = '<Leader>t', desc = '+[T]oggle' },
        { mode = 'n', keys = '<Leader>h', desc = '+Git [H]unk' },
        { mode = 'v', keys = '<Leader>h', desc = '+Git [H]unk' },
        { mode = 'n', keys = '<Leader>l', desc = '+[L]SP' },
        { mode = 'n', keys = '<Leader>R', desc = '+[R]equests' },

        -- Include mini.clue's built-in clues
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },

      window = {
        delay = 600,
        config = {
          width = 'auto',
        },
      },
    }

    -- Highlight patterns - replaces todo-comments.nvim and nvim-highlight-colors
    require('mini.hipatterns').setup {
      highlighters = {
        -- TODO/FIXME/HACK/NOTE/PERF/WARNING highlighting
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        perf = { pattern = '%f[%w]()PERF()%f[%W]', group = 'MiniHipatternsNote' },
        warning = { pattern = '%f[%w]()WARNING()%f[%W]', group = 'MiniHipatternsFixme' },

        -- Hex color highlighting (#rrggbb)
        hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
      },
    }
  end,
}

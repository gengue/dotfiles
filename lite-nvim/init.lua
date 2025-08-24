-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Enable syntax highlighting
vim.opt.termguicolors = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

vim.o.laststatus = 3 -- always show the status line

-- auto refresh the tree when files change
vim.opt.autoread = true

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- nice window borders
vim.o.winborder = 'rounded'

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<C-Q>', '<cmd>q<CR>', { desc = 'Force quit' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'Hover [D]iagnostics' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- resize windows
vim.keymap.set('n', '<leader><left>', ':vertical resize +20<cr>')
vim.keymap.set('n', '<leader><right>', ':vertical resize -20<cr>')
vim.keymap.set('n', '<leader><up>', ':resize +10<cr>')
vim.keymap.set('n', '<leader><down>', ':resize -10<cr>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- toggle explorer in the current working directory
-- vim.keymap.set('n', '<leader>e', '<cmd>Lexplore<CR>', { desc = 'Open file explorer' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- close buffers
vim.keymap.set('n', '<leader>c', '<Cmd>bdelete<CR>', { desc = 'Close buffer' })
-- close window
-- vim.keymap.set('n', '<C-Q>', '<Cmd>q!<CR>', { desc = 'force quit' })

-- update nvim
vim.keymap.set('n', '<leader>u', ':update<CR> :source<CR>', { desc = 'Reload nvim' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local augroup = vim.api.nvim_create_augroup('genesis', {})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup,
  callback = function()
    vim.hl.on_yank()
  end,
})
-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'javascript,javascriptreact,typescript,typescriptreact',
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'go',
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd('TermClose', {
  group = augroup,
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd('TermOpen', {
  group = augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
  end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd('VimResized', {
  group = augroup,
  callback = function()
    vim.cmd 'tabdo wincmd ='
  end,
})

-- [[ Basic Commands ]]

vim.api.nvim_create_user_command('JQ', '%!jq .', {
  desc = 'Format JSON with jq',
})

-- [[ Plugins ]]

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath 'data' .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd 'echo "Installing `mini.nvim`" | redraw'
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim',
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd 'packadd mini.nvim | helptags ALL'
  vim.cmd 'echo "Installed `mini.nvim`" | redraw'
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup { path = { package = path_package } }

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add { -- Highlight, edit, and navigate code
  source = 'nvim-treesitter/nvim-treesitter',
  hooks = {
    post_checkout = function()
      vim.cmd 'TSUpdate'
    end,
  },
}
add {
  source = 'L3MON4D3/LuaSnip',
  hooks = {
    post_checkout = function()
      return 'make install_jsregexp'
    end,
  },
  depends = { 'rafamadriz/friendly-snippets' },
}
add {
  source = 'saghen/blink.cmp',
  depends = { 'rafamadriz/friendly-snippets' },
  checkout = '1.*',
}
add 'lewis6991/gitsigns.nvim'
add {
  source = 'neovim/nvim-lspconfig',
  depends = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
  },
}
add 'stevearc/conform.nvim'
add 'mfussenegger/nvim-lint'
add { source = 'windwp/nvim-ts-autotag', depends = { 'nvim-treesitter/nvim-treesitter' } }

now(function()
  require('mini.ai').setup { n_lines = 500 }
end)
now(function()
  require('mason').setup {}
end)
now(function()
  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  require('mini.surround').setup()
  -- Simple and easy statusline.
  local statusline = require 'mini.statusline'
  -- set use_icons to true if you have a Nerd Font
  statusline.setup { use_icons = vim.g.have_nerd_font }
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function()
    return '%2l:%-2v'
  end
end)
now(function()
  require('mini.files').setup {
    windows = { preview = false },
  }
  vim.keymap.set('n', '-', function()
    local MiniFiles = require 'mini.files'
    local _ = MiniFiles.close() or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    vim.defer_fn(function()
      MiniFiles.reveal_cwd()
    end, 30)
  end, { noremap = true, silent = true, desc = 'Files explorer' })
end)
-- telescope alternative
now(function()
  require('mini.pick').setup {}

  vim.ui.select = require('mini.pick').ui_select
  vim.keymap.set('n', '<leader>sf', ':Pick files<CR>', { noremap = true, silent = true, desc = '[S]earch [f]iles' })
  vim.keymap.set('n', '<leader><leader>', ':Pick buffers<CR>', { desc = 'Pick existing buffers' })
  vim.keymap.set('n', '<leader>sh', ':Pick help<CR>', { desc = '[S]earch [H]elp' })
  vim.keymap.set({ 'n', 'v' }, '<leader>sw', function()
    local filetype = string.match(vim.api.nvim_buf_get_name(0), '%.%w*$') or vim.o.filetype
    if filetype then
      -- greps a word under cwd and then opens quickfix list with the results
      vim.api.nvim_input([[:vim <C-R><C-W> **/*]] .. filetype .. [[<CR>:cope<CR>]])
    else
      vim.notify("Filetype is nil. Can't grep that shit.", vim.log.levels.ERROR, {})
    end
  end, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', ':Pick grep_live<CR>', { desc = '[S]earch by [G]rep', silent = true })
  vim.keymap.set('n', '<leader>sr', ':Pick resume<CR>', { desc = '[S]earch [R]esume', silent = true })
  vim.keymap.set('n', '<leader>sn', function()
    MiniPick.builtin.files(nil, { source = { cwd = vim.fn.stdpath 'config' } })
  end, { desc = '[S]earch [N]eovim files' })
end)
now(function()
  require('mini.pairs').setup()
end)
now(function()
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
end)
now(function()
  require('mini.starter').setup {}
end)
now(function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'bash',
      'diff',
      'html',
      'lua',
      'luadoc',
      'go',
      'markdown',
      'markdown_inline',
      'query',
      'sql',
      'css',
      'typescript',
      'tsx',
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = { enable = true },
  }
end)
now(function()
  require('blink.cmp').setup {
    keymap = { preset = 'default' },
    appearance = { nerd_font_variant = 'mono' },
    completion = {
      menu = {
        auto_show = function(ctx)
          return ctx.mode ~= 'cmdline'
        end,
        border = 'rounded',
        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
        draw = {
          treesitter = { 'lsp' },
        },
      },
      accept = {
        auto_brackets = { enabled = false },
      },
      -- By default, you may press `<c-space>` to show the documentation.
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        window = {
          border = 'rounded',
          winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
        },
      },
      ghost_text = { enabled = true, show_with_menu = false },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {},
    },
    snippets = { preset = 'luasnip' },
    fuzzy = {
      implementation = 'lua',
    },
    -- Shows a signature help window while you type arguments for a function
    signature = {
      enabled = true,
      window = {
        border = 'rounded',
        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
      },
    },
  }
end)
now(function()
  require('mini.extra').setup()
end)

later(function()
  require('mini.icons').setup {
    -- Set to true if you have a Nerd Font
    use_nerd_font = vim.g.have_nerd_font,
  }
end)
later(function()
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
end)
later(function()
  require('luasnip.loaders.from_vscode').lazy_load()
end)
later(function()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('genesis-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end
      map('<leader>lr', vim.lsp.buf.rename, '[r]ename')
      map('<leader>la', vim.lsp.buf.code_action, 'Code [a]ction', { 'n', 'x' })
      map('<leader>lR', function()
        require('mini.extra').pickers.lsp { scope = 'references' }
      end, 'Go to [R]eferences')

      map('gi', function()
        require('mini.extra').pickers.lsp { scope = 'implementation' }
      end, 'Go to [i]mplementation')

      map('gd', function()
        require('mini.extra').pickers.lsp { scope = 'definition' }
      end, 'Go to [d]efinition')

      map('gO', function()
        require('mini.extra').pickers.lsp { scope = 'document_symbol' }
      end, 'Open Document Symbols')

      map('gW', function()
        require('mini.extra').pickers.lsp {
          scope = 'workspace_symbol',
          symbol_query = vim.fn.input 'Query: ',
        }
      end, 'Open [W]orkspace Symbols')

      map('gy', function()
        require('mini.extra').pickers.lsp { scope = 'type_definition' }
      end, 'Go to T[y]pe Definition')
      local function client_supports_method(client, method, bufnr)
        if vim.fn.has 'nvim-0.11' == 1 then
          return client:supports_method(method, bufnr)
        else
          return client.supports_method(method, { bufnr = bufnr })
        end
      end
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('genesis-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })
        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('genesis-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'genesis-lsp-highlight', buffer = event2.buf }
          end,
        })
      end
      -- The following code creates a keymap to toggle inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end
    end,
  })
  vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚 ',
        [vim.diagnostic.severity.WARN] = '󰀪 ',
        [vim.diagnostic.severity.INFO] = '󰋽 ',
        [vim.diagnostic.severity.HINT] = '󰌶 ',
      },
    } or {},
    virtual_text = {
      source = 'if_many',
      spacing = 2,
      format = function(diagnostic)
        local diagnostic_message = {
          [vim.diagnostic.severity.ERROR] = diagnostic.message,
          [vim.diagnostic.severity.WARN] = diagnostic.message,
          [vim.diagnostic.severity.INFO] = diagnostic.message,
          [vim.diagnostic.severity.HINT] = diagnostic.message,
        }
        return diagnostic_message[diagnostic.severity]
      end,
    },
  }
  local capabilities = require('blink.cmp').get_lsp_capabilities()
  local servers = {
    gopls = {},
    vtsls = {},
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          diagnostics = { disable = { 'missing-fields' } },
        },
      },
    },
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = 'double',
      silent = true,
    }),
  }
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    'stylua',
    'biome',
    'prettier',
    'eslint_d',
  })
  require('mason-tool-installer').setup { ensure_installed = ensure_installed }
  require('mason-lspconfig').setup {
    ensure_installed = {}, -- explicitly set to an empty table (populates installs via mason-tool-installer)
    automatic_installation = false,
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        -- This handles overriding only values explicitly passed
        -- by the server configuration above. Useful when disabling
        -- certain features of an LSP (for example, turning off formatting for ts_ls)
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        require('lspconfig')[server_name].setup(server)
      end,
    },
  }
end)
later(function()
  require('gitsigns').setup {
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Jump to next git [c]hange' })
      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Jump to previous git [c]hange' })
      -- Actions
      -- visual mode
      map('v', '<leader>hs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'git [s]tage hunk' })
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'git [r]eset hunk' })
      -- normal mode
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
      map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
      map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
      map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
      map('n', '<leader>hD', function()
        gitsigns.diffthis '@'
      end, { desc = 'git [D]iff against last commit' })
      -- Toggles
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
      map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
    end,
  }
end)

later(function()
  function setup_conform()
    require('conform').setup {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local lsp_format_opt = 'never'
        return { timeout_ms = 500, lsp_format = lsp_format_opt }
      end,
      formatters = {
        prettier = { require_cwd = true },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        json = { 'biome' },
        jsonc = { 'biome' },
        html = { 'biome' },
        javascript = { 'prettier', 'biome', stop_after_first = true },
        javascriptreact = { 'prettier', 'biome', stop_after_first = true },
        ['typescript.tsx'] = { 'prettier', 'biome', stop_after_first = true },
        typescript = { 'prettier', 'biome', stop_after_first = true },
        typescriptreact = { 'prettier', 'biome', stop_after_first = true },
        go = { 'goimports', 'gofmt' },
      },
    }
    vim.keymap.set({ 'n' }, '<leader>f', function()
      require('conform').format { async = true, lsp_fallback = true }
    end, { desc = '[F]ormat buffer' })
  end

  -- Load Conform before first real buffer so format_on_save works
  vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('deps-conform', { clear = true }),
    once = true,
    callback = setup_conform,
  })
end)

later(function()
  function setup_lint()
    local lint = require 'lint'
    lint.linters_by_ft = {
      json = { 'biome' },
    }
    -- Disable unwanted defaults if present
    lint.linters_by_ft['clojure'] = nil
    lint.linters_by_ft['dockerfile'] = nil
    lint.linters_by_ft['inko'] = nil
    lint.linters_by_ft['janet'] = nil
    lint.linters_by_ft['json'] = nil
    lint.linters_by_ft['markdown'] = nil
    lint.linters_by_ft['terraform'] = nil
    lint.linters_by_ft['text'] = nil

    local grp = vim.api.nvim_create_augroup('lint', { clear = true })
  end

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    group = grp,
    callback = function()
      if vim.bo.modifiable then
        require('lint').try_lint()
      end
    end,
  })

  vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('deps-nvim-lint', { clear = true }),
    once = true,
    callback = setup_lint,
  })
end)

later(function()
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('deps-autotag', { clear = true }),
    pattern = { 'html', 'xml', 'typescriptreact', 'javascriptreact', 'tsx', 'jsx', 'svelte', 'vue' },
    callback = function()
      require('nvim-ts-autotag').setup {}
    end,
  })
end)

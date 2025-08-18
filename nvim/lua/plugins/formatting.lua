-- Code formatting and linting

return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre', 'BufReadPre', 'BufNewFile' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local lsp_format_opt = 'never'
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      -- Configure formatters to respect project config
      formatters = {
        prettier = {
          require_cwd = true, -- Only run if a Prettier config is found in CWD
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        json = { 'biome' },
        jsonc = { 'biome' },
        html = { 'biome' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        javascript = { 'prettier', 'biome', stop_after_first = true },
        javascriptreact = { 'prettier', 'biome', stop_after_first = true },
        ['typescript.tsx'] = { 'prettier', 'biome', stop_after_first = true },
        typescript = { 'prettier', 'biome', stop_after_first = true },
        typescriptreact = { 'prettier', 'biome', stop_after_first = true },
        go = { 'goimports', 'gofmt' },
      },
    },
  },

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        -- json = { 'jsonlint' },
        json = { 'biome' },
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      lint.linters_by_ft['clojure'] = nil
      lint.linters_by_ft['dockerfile'] = nil
      lint.linters_by_ft['inko'] = nil
      lint.linters_by_ft['janet'] = nil
      lint.linters_by_ft['json'] = nil
      lint.linters_by_ft['markdown'] = nil
      lint.linters_by_ft['terraform'] = nil
      lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },

  {
    'nmac427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup {}
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
}

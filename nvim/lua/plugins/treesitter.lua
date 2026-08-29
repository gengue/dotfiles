return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main', -- master is frozen and breaks on nvim 0.12+
    build = ':TSUpdate',
    lazy = false,
    config = function()
      local ensure_installed = {
        'bash',
        'diff',
        'html',
        'lua',
        'luadoc',
        'go',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'sql',
        'css',
        'typescript',
        'tsx',
      }
      require('nvim-treesitter').install(ensure_installed)

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter-setup', {}),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if lang and pcall(vim.treesitter.start, args.buf, lang) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}

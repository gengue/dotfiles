-- Media handling - Images, markdown rendering, and media utilities

return {
  { -- Enhanced markdown rendering
    'MeanderingProgrammer/render-markdown.nvim',
    lazy = true,
    ft = { 'markdown' },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = { blink = { enabled = true } },
      file_types = { 'markdown' },
      code = {
        disable_background = true,
        language = false,
      },
    },
  },

  { -- Image support in terminal
    '3rd/image.nvim',
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    lazy = true,
    ft = { 'markdown' },
    opts = {
      processor = 'magick_cli',
      integrations = {
        markdown = {
          clear_in_insert_mode = true,
          only_render_image_at_cursor = true,
          only_render_image_at_cursor_mode = 'inline',
        },
      },
    },
  },

  { -- Clipboard image pasting
    'HakonHarnes/img-clip.nvim',
    lazy = true,
    ft = { 'markdown' },
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { '<leader>p', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
    },
  },
}

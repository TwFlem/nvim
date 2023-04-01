vim.keymap.set('n', 'gf', '<cmd>diffget //2<CR>')
vim.keymap.set('n', 'gj', '<cmd>diffget //3<CR>')
return {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
      -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
}

local initUndoTree = function()
  vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndotree toggle' })
end
local initHarpoon = function()
  vim.keymap.set('n', '<leader>a', function() require('harpoon.mark').add_file() end, { desc = 'Harpoon [A]dd File' })
  vim.keymap.set('n', '<leader>j', function() require('harpoon.ui').nav_next() end, { desc = 'Harpoon Nav Next' })
  vim.keymap.set('n', '<leader>f', function() require('harpoon.ui').nav_prev() end, { desc = 'Harpoon Nav Previous' })
  vim.keymap.set('n', '<leader>h', function() require('harpoon.ui').toggle_quick_menu() end,
    { desc = '[H]arpoon Toggle Quick Menu' })
end
return {
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',         opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-context' },
  {
    'mbbill/undotree',
    init = initUndoTree
  },
  {
    'ThePrimeagen/harpoon',
    init = initHarpoon
  },
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = { "TodoTelescope" },
    config = true,
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>sT", "<cmd>TodoTelescope<cr>", desc = "[S]earch [T]odo" },
    },
  },
}

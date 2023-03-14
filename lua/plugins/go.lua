local init = function ()
 vim.keymap.set('n', '<leader>gor', '<cmd>GoRun<cr>', { desc = '[G][O] [R]un'})
 vim.keymap.set('n', '<leader>gob', '<cmd>GoBuild<cr>', { desc = '[G][O] [B]uild'})
 vim.keymap.set('n', '<leader>got', '<cmd>GoTestFunc<cr>', { desc = '[G][O] [T]est Func'})
 vim.keymap.set('n', '<leader>goT', '<cmd>GoTest<cr>', { desc = '[G][O] run all [T]ests'})
 vim.keymap.set('n', '<leader>god', '<cmd>GoDoc<cr>', { desc = '[G][O] [D]oc'})
 vim.keymap.set('n', '<leader>goi', '<cmd>GoInfo<cr>', { desc = '[G][O] [I]nfo'})
end
return {
  {
    "fatih/vim-go",
    init = init
  }
}

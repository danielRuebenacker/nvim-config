return {
  {
    "preservim/nerdtree",
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      -- optionally auto-open NERDTree
      -- vim.cmd([[ NERDTree ]])
    end,
  },
}

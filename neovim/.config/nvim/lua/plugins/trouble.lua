-- TODO: UPDATE TROUBLE TOGGLE CONFIG
return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>")
    end
  }
}

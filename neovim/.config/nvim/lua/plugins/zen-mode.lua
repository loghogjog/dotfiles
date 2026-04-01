return {
  {
    "folke/zen-mode.nvim",
    opts = {},
    config = function()
      vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>")
    end
  }
}

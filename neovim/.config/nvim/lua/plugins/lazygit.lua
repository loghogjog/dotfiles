return {
  {
    "kdheepak/lazygit.nvim",
    config = function()
      vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "Toggle LazyGit" })
    end
  }
}

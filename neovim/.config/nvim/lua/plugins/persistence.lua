return {
  {
    "folke/persistence.nvim",
    opts = {},
    config = function()
      vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end, { desc = "Load Current Dir's Session" })
      vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end, { desc = "Select Session to Load" })
      vim.keymap.set("n", "<leader>ql", function() require("persistence").load_last() end, { desc = "Load Last Session" })
      vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Do Not Save Session on Exit" })
    end
  }
}

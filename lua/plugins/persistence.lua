return {
  {
    "folke/persistence.nvim",
    opts = {},
    config = function()
      vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end)
      vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end)
      vim.keymap.set("n", "<leader>ql", function() require("persistence").load_last() end)
      vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end)
    end
  }
}

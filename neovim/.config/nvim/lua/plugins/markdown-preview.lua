return {
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown" },
    config = function()
      require("markview").setup({
        preview = {
          enable = true,
        },
      })

      vim.keymap.set("n", "<leader>mp", "<cmd>Markview Toggle<CR>", { desc = "Toggle Markdown Preview" })
    end
  }
}

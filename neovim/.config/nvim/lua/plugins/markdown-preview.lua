return {
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown" },
    dependencies = { "latex-lsp/tree-sitter-latex"},
    config = function()
      vim.opt.conceallevel = 2
      vim.opt.concealcursor = "nc"

      require("markview").setup({
        preview = {
          enable = true,
        },
        markdown = {
          list_items = {
            enable = true,
          },
          checkboxes = {
            enable = true,
          },
        },
      })

      vim.keymap.set("n", "<leader>cb", "<cmd>Checkbox toggle<CR>", { desc = "Toggle Checkbox" })
      vim.keymap.set("n", "<leader>mt", "<cmd>Markview Toggle<CR>", { desc = "Toggle Markdown Preview" })
    end
  }
}

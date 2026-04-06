return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  config = function()
    require("img-clip").setup({
      dir_path = function()
        local file_dir = vim.fn.expand("%:p:h")
        local assets_dir = file_dir .. "/.assets"

        if vim.fn.isdirectory(assets_dir) == 0 then
          vim.fn.mkdir(assets_dir, "p")
        end

        return assets_dir
      end,
    })

    vim.keymap.set("n", "<leader>p", "<cmd>PasteImage<CR>", {
      desc = "Paste image from system clipboard",
    })
  end,
}

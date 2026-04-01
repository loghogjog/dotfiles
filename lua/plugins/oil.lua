return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,     --
      delete_to_trash = true,          --
      skip_confirm_for_simple_edits = true, --
      columns = { "icon" },            --
      view_options = { show_hidden = true }, --
      keymaps = {
        ["<CR>"] = "actions.select",
        ["-"] = "actions.parent",      --
        ["q"] = "actions.close",
      },
    })
    -- Global map to open oil
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }) --
  end,
}


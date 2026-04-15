return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim"
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        layout_config = {
          horizontal = { preview_width = 0.6 },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    })

    telescope.load_extension("live_grep_args")
    telescope.load_extension("yank_history")

    -- Keymaps
    local map = vim.keymap.set

    map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    map("n", "<leader>fg", telescope.extensions.live_grep_args.live_grep_args, { desc = "Live Grep" })
    map("n", "<leader>fb", builtin.buffers, { desc = "File Buffers" })
  end
}

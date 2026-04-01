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
      }
    })

    telescope.load_extension("live_grep_args")

    -- Keymaps
    local map = vim.keymap.set

    map("n", "<leader>ff", builtin.find_files)
    map("n", "<leader>fg", telescope.extensions.live_grep_args.live_grep_args)
    map("n", "<leader>fb", builtin.buffers)
  end
}

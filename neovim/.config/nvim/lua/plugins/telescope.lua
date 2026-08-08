return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup{
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          height = 0.95,
          width = 0.95,
          preview_height = 0.65,
          -- prompt_position = "bottom",
        },
        border = true,
        prompt_prefix = "NIGGA> ",
      },
      pickers = {
        find_files = {
          hidden = true,
        }
      },
    }

    vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#141218", bg = "#B69DF8" })
    vim.api.nvim_set_hl(0, "TelescopePreviewLine", { bg = "#B69DF8", bold = true })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#B69DF8", bg = "#141218" })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#B69DF8", bg = "#141218" })
    vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#B69DF8", bg = "#141218" })
    vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#B69DF8", bg = "#141218" })

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffer" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
    vim.keymap.set("n", "<leader>ch", builtin.command_history, { desc = "View Command History" })
    vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Find String Under Cursor" })
  end,
}

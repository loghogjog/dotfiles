return {
  {
    "sanjay-np/nvim-yt-player",
    dependencies = { "nvim-lualine/lualine.nvim" }, -- optional, for statusline component
    config = function()
      require("yt-player").setup({
        -- your configuration options here (see Configuration section)
      })

    -- Keymaps
    vim.keymap.set("n", "<leader>ym", "<cmd>YT mini<cr>", { desc = "Open YT Mini Player" })
    vim.keymap.set("n", "<leader>yp", "<cmd>YT playlists<cr>", { desc = "Show YT Playlist" })
    vim.keymap.set("n", "<leader>yh", "<cmd>YT history<cr>", { desc = "Show YT History" })
    vim.keymap.set("n", "<leader>yr", "<cmd>YT resume<cr>", { desc = "YT Resume Last Playback" })
    vim.keymap.set("n", "<leader>yq", "<cmd>YT queue_edit<cr>", { desc = "Edit YT Queue" })
    vim.keymap.set("n", "<leader>ys", "<cmd>YT search<cr>", { desc = "YT Search" })

    end,
  }
}

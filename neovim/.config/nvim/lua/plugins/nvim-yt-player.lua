return {
  {
    "sanjay-np/nvim-yt-player",
    dependencies = { "nvim-lualine/lualine.nvim" }, -- optional, for statusline component
    config = function()
      require("yt-player").setup({
        -- your configuration options here (see Configuration section)
        statusline = {
          format = "{icon} {title} - [{position}/{duration} {progress}]",
        },
        search = {
          limit = 20,
        },
        notifications = {
          notify_on_track_change = false,
        },
      })

    -- Keymaps
    vim.keymap.set("n", "<leader>mm", "<cmd>YT mini<cr>", { desc = "Open Music Mini Player" })
    vim.keymap.set("n", "<leader>mp", "<cmd>YT playlists<cr>", { desc = "Show Music Playlist" })
    vim.keymap.set("n", "<leader>mh", "<cmd>YT history<cr>", { desc = "Show Music History" })
    vim.keymap.set("n", "<leader>mr", "<cmd>YT resume<cr>", { desc = "Resume Last Music Playback" })
    vim.keymap.set("n", "<leader>mq", "<cmd>YT queue_edit<cr>", { desc = "Edit Music Queue" })
    vim.keymap.set("n", "<leader>ms", "<cmd>YT search<cr>", { desc = "Music Search" })
    -- Other Commands
    -- :YT queue_playlists <url> - play entire playlist
    -- :YT player - open player in sidebar
    -- :YT history_clear - Clear local play history
    -- :YT queue <url> - append url to active queue

    end,
  }
}

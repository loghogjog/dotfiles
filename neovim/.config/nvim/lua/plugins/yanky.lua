return {
  "gbprod/yanky.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    highlight = { on_yank = true, timer = 200 },
    picker = {
      select = {
        action = nil, -- default put after cursor action
      },
    },
  },
  keys = {
    -- Opens clipboard hist using telescope
    { "<leader>p", "<cmd>Telescope yank_history<cr>", desc = "Open Clipboard History" },
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Paste after cursor" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Paste before cursor" },
  },
}

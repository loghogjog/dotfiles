return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = { theme = "auto" }
    }
  },
  -- {
  --   "folke/noice.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim" },
  --   opts = {}
  -- },
  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")

      wk.setup({})

      wk.register({
       {
        { "<leader>e", desc = "Toggle Explorer" },
        { "<leader>f", group = "Find" },
        { "<leader>fb", desc = "Buffers" },
        { "<leader>ff", desc = "Find Files" },
        { "<leader>fg", desc = "Live Grep" },
        { "<leader>ft", desc = "Find TODOs" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>la", desc = "Code Action" },
        { "<leader>ld", desc = "Definition" },
        { "<leader>lr", desc = "Rename" },
      }
    })
    end
  },
}


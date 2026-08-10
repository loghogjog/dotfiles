return {
  {
    "folke/tokyonight.nvim",
    -- config = function ()
    --   require("tokyonight").setup({
    --     style = "night",
    --     transparent = true,
    --   })
    -- end
  },
  {
    "RRethy/base16-nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight-night")

      -- -- Background Override
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "SignColumnSB", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "WinBar", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "WinBarNC", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "NormalSB", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "Comment", { fg = "#9d99a5", italic = true, })
    end
  }
}

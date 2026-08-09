return {
  -- { "EdenEast/nightfox.nvim" },
  { "folke/tokyonight.nvim" },
  {
    "RRethy/base16-nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight-night")

      -- Background Override
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "Comment", { fg = "#9d99a5", italic = true, })
    end
  }
}

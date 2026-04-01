return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "lua", "python", "javascript", "bash", "c" },
    highlight = { enable = true },
  }
}

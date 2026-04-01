return {
  {
    "folke/flash.nvim",
    opts = {},
    config = function()
      vim.keymap.set({ "n", "x", "o" }, "s", function()
        require("flash").jump()
      end)
    end
  }
}

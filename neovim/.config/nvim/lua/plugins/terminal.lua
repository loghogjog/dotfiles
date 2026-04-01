return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = {
          border = "rounded",
        },
      })

      local Terminal = require("toggleterm.terminal").Terminal

      -- Persistent terminal
      local term = Terminal:new({ hidden = true })

      function _TOGGLE_TERM()
        term:toggle()
      end

      vim.keymap.set("n", "<leader>tt", _TOGGLE_TERM, { desc= "Toggle Terminal" })
    end
  }
}

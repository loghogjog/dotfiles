return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        direction = "horizontal",
        -- float_opts = {
        --   border = "rounded",
        -- },

      })

      local Terminal = require("toggleterm.terminal").Terminal

      local term = Terminal:new({ hidden = true }) -- persistence

      function _TOGGLE_TERM()
        term:toggle()
      end

      local opts = {buffer = 0}

      vim.keymap.set("n", "<leader>t1", "<cmd>ToggleTerm 1<CR>", { desc = "Open Terminal 1" })
      vim.keymap.set("n", "<leader>t2", "<cmd>ToggleTerm 2<CR>", { desc = "Open Terminal 2" })
      vim.keymap.set("n", "<leader>t3", "<cmd>ToggleTerm 3<CR>", { desc = "Open Terminal 3" })
      vim.keymap.set("n", "<leader>t4", "<cmd>ToggleTerm 4<CR>", { desc = "Open Terminal 4" })
      vim.keymap.set("n", "<leader>t5", "<cmd>ToggleTerm 5<CR>", { desc = "Open Terminal 5" })

      vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>hi]])
      -- vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]])
      -- vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]])
      vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>li]])

      vim.keymap.set('t', '<ESC>', [[<C-\><C-n>]])

    end
  }
}

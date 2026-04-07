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

      vim.keymap.set("n", "<leader>tt", _TOGGLE_TERM, { desc= "Toggle Terminal" })
      -- vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", [[<C-\><C-n>]], {noremap=true, silent=true})
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end
  }
}

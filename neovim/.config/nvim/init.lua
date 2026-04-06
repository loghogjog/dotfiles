require("core.options")
require("core.keymaps")
require("core.lazy")
require("core.dap")

vim.g.python3_host_prog = vim.fn.expand("~/.config/nvim/mynvimenv/bin/python3")

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(event)
    local file = event.match
    local dir = vim.fn.fnamemodify(file, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- Formatter Config
require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_format", "black" },
  },
})

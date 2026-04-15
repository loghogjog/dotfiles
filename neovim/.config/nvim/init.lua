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

-- FIX: oil.nvim creates C dir in curr dir
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    desc = "Create parent directories automatically on write",
    callback = function(args)
        local bufname = vim.api.nvim_buf_get_name(args.buf)
        if bufname:match("^oil://") then
            return
        end
        local dir = vim.fn.expand("<afile>:p:h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
})

-- -- Auto Focus on new Window
-- vim.api.nvim_create_autocmd("WinNew", {
--   callback = function()
--     vim.cmd("")
-- })

-- Formatter Config
require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_format", "black" },
  },
})

local map = vim.keymap.set

-- Better navigation
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Clear search
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- File explorer
map("n", "<leader>e", vim.cmd.Ex)

-- Block Tabbing
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Row Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Row Up" })

-- Copy Paste
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })
vim.keymap.set("v", "p", '"_dP')

-- Better Escape
vim.keymap.set("i", "jk", "<Esc>", { desc = "Fast escape" })

-- LSP
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })

-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics list" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>Q", ":q!<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })

-- Rename
vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename All Instances" })

-- Better Quit Button
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>Q", ":q!<CR>", { noremap = true, silent = true })

-- Python Run
local function run_python()
  vim.cmd("w")
  local file = vim.fn.expand("%")
  -- 'botright' ensures terminal opens at the bottom 
  vim.cmd("botright split | terminal python3 " .. file)
end

vim.keymap.set("n", "<leader>rp", run_python, { desc = "Run Python file" })

-- Debugging
vim.keymap.set("n", "<F5>", function() require("dap").continue() end, { desc = "Continue" })
vim.keymap.set("n", "<F10>", function() require("dap").step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", function() require("dap").step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<F12>", function() require("dap").step_out() end, { desc = "Step Out" })

vim.keymap.set("n", "<leader>b", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>B", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Set Breakpoint with Condition" })

-- Open REPL for debugging (Lowkey can remove alr since DAP UI is added)
vim.keymap.set("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "Open Debug REPL" })
vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run Last Debug Configuration" })

-- Split Pane, Navigation g
vim.keymap.set("n", "<leader>|", "<C-w>v", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>-", "<C-w>s", { desc = "Horizontal split" })
-- Nav
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

vim.keymap.set("n", "<C-Left>", "<C-w>h")
vim.keymap.set("n", "<C-Right>", "<C-w>l")
vim.keymap.set("n", "<C-Down>", "<C-w>j")
vim.keymap.set("n", "<C-Up>", "<C-w>k")

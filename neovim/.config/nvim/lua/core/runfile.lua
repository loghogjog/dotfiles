-- Run File in neovim
local Terminal = require("toggleterm.terminal").Terminal

local function run_cmd(cmd)
  local term = Terminal:new({
    cmd = cmd,
    hidden = true,
  })
  term:toggle()
end

local function run_file()
  local file = vim.fn.expand("%")
  local ft = vim.bo.filetype
  local name = vim.fn.expand("%:r")

  vim.cmd("w")

  if ft == "c" then
    run_cmd("gcc " .. file .. " -o " .. name .. " && ./" .. name)

  elseif ft == "python" then
    run_cmd("python " .. file)

  elseif ft == "sh" then
    run_cmd("bash " .. file)

  elseif ft == "javascript" then
    run_cmd("node " .. file)

  else
    print("No runner for " .. ft)
  end
end

vim.keymap.set("n", "<leader>r", run_file)

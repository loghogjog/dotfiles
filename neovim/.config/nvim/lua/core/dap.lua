local dap = require("dap")

-- Python adapter
dap.adapters.python = {
  type = "executable",
  command = os.getenv("HOME") .. "/.config/nvim/mynvimenv/bin/python",
  args = { "-m", "debugpy.adapter" },
}

-- Python configurations
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      return '/usr/bin/python'
    end,
  },
}

-- UI
local dap, dapui = require("dap"), require("dapui")

dapui.setup()

-- Auto open/close UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

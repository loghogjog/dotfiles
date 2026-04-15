local dap = require("dap")

-- Python configurations
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
  },
}

-- UI
local dap, dapui = require("dap"), require("dapui")

dapui.setup()

-- Auto open UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

-- No Auto Close UI 
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end

-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

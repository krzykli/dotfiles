local dap = require('dap')

vim.fn.sign_define('DapBreakpoint', {text="🔴"})
vim.fn.sign_define('DapStopped', {text="⭕"})

-- python
local dap_python = require('dap-python')
dap_python.setup('python')
dap_python.test_runner = 'pytest'

dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch';
        name = "Launch file";
        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
        program = "${file}"; -- This configuration will launch the current file if used.
    },
}

-- local dapui = require("dapui")
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end


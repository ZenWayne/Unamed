local M = {}

function M.setup()
  local dap = require("dap")
  local dapui = require("dapui")
  local dap_python = require("dap-python")

  -- 配置 DAP UI
  dapui.setup()

  -- 配置 Python DAP - 使用当前环境的 Python
  dap_python.setup(vim.fn.exepath("python3"))

  -- ====== 关键：配置 attach 到远程 debugpy ======
  dap.configurations.python = {
    {
      type = 'python',
      request = 'attach',
      name = 'Attach to Docker debugpy (5678)',
      connect = {
        host = '127.0.0.1',
        port = 5678,
      },
      pathMappings = {
        {
          -- Docker 容器内的路径
          localRoot = vim.fn.getcwd(),
          remoteRoot = "/workspace",
        },
      },
      justMyCode = false,
    },
  }

  -- 自动打开/关闭 DAP UI
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  -- 调试快捷键
  vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = 'DAP: Continue' })
  vim.keymap.set('n', '<F6>', function() dapui.toggle() end, { desc = 'DAP: Toggle UI' })
  vim.keymap.set('n', '<F9>', function() dap.toggle_breakpoint() end, { desc = 'DAP: Toggle Breakpoint' })
  vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = 'DAP: Step Over' })
  vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = 'DAP: Step Into' })
  vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = 'DAP: Step Out' })

  -- 高级断点（带条件）
  vim.keymap.set('n', '<Leader>B', function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
  end, { desc = 'DAP: Set Conditional Breakpoint' })

  -- 查看变量
  vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end, { desc = 'DAP: Open REPL' })
  vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end, { desc = 'DAP: Run Last' })
end

return M

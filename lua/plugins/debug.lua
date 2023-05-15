local function get_arguments()
  local co = coroutine.running()
  if co then
    return coroutine.create(function()
      local args = {}
      vim.ui.input({ prompt = "Args: " }, function(input)
        args = vim.split(input or "", " ")
      end)
      coroutine.resume(co, args)
    end)
  else
    local args = {}
    vim.ui.input({ prompt = "Args: " }, function(input)
      args = vim.split(input or "", " ")
    end)
    return args
  end
end

local initDap   = function()
  local dap = require('dap')
  vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[D]AP: Toggle [B]reakpoint' })
  vim.keymap.set('n', '<leader>dl', dap.list_breakpoints, { desc = '[D]AP: [L]ist Breakpoints' })
  vim.keymap.set('n', '<leader>dD', dap.clear_breakpoints, { desc = '[D]AP: [D]ump All Breakpoints' })

  vim.keymap.set('n', '<leader>dB', dap.step_back, { desc = '[D]AP: [S]tep [B]ack' })
  vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]AP: [S]tep [I]nto' })
  vim.keymap.set('n', '<leader>do', dap.step_over, { desc = '[D]AP: [S]tep [O]over' })
  vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = '[D]AP: [S]tep [O]out' })

  vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]AP: [C]ontinue' })
  vim.keymap.set('n', '<leader>dC', dap.reverse_continue, { desc = '[D]AP: Reverse [C]ontinue' })
  vim.keymap.set('n', '<leader>dR', function() dap.restart(nil, {}) end, { desc = '[D]AP: [R]estart' })
  vim.keymap.set('n', '<leader>dK', dap.terminate, { desc = '[D]AP: [K]ill Session' })

  vim.keymap.set('n', '<leader>dP', dap.repl.toggle, { desc = '[D]AP: Toggle Re[P]l' })

  vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointCondition', { text = '🤔', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapLogPoint', { text = '🌳', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped', { text = '🟢', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointRejected', { text = '🚫', texthl = '', linehl = '', numhl = '' })
end
local initGoDap = function()
  local goDap = require('dap-go')
  vim.keymap.set('n', '<leader>dgot', goDap.debug_test, { desc = '[D]AP: Debug [G][O] [T]est' })
  goDap.setup {
    dap_configurations = {
      {
        -- Must be "go" or it will be ignored by the plugin
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}"
        -- env = {
        --   EXAMPLE = "example"
        -- }
        -- args = get_arguments
      },
    },
  }
end
local initDapUi = function()
  local dap = require('dap')
  local dapUi = require('dapui')

  vim.keymap.set('n', '<leader>duo', dapUi.open, { desc = '[D]AP: [U]I [O]pen' })
  vim.keymap.set('n', '<leader>duc', dapUi.close, { desc = '[D]AP: [U]I [C]lose' })

  dap.listeners.after['launch']['dap'] = function()
    dapUi.open()
  end
  dap.listeners.after['terminate']['dap'] = function()
    dapUi.close()
  end
  dap.listeners.after['disconnect']['dap'] = function()
    dapUi.close()
  end
  dap.listeners.after['restart']['dap'] = function()
    dapUi.close()
  end
  dapUi.setup()
end
return {
  {
    'mfussenegger/nvim-dap',
    init = initDap,
  },
  {
    'leoluz/nvim-dap-go',
    init = initGoDap,
  },
  {
    'rcarriga/nvim-dap-ui',
    init = initDapUi,
  },
  {
    'theHamsta/nvim-dap-virtual-text'
  },
  {
    'nvim-telescope/telescope-dap.nvim'
  },
}

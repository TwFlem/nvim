local dap = require('dap')
local mr = require('mason-registry')
local utils = require('debug.utils')

-- rust
local codelldb = mr.get_package('codelldb'):get_install_path() .. '/codelldb'
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = codelldb,
		args = { "--port", "${port}" },
	}
}

dap.configurations.rust = {
	{
		name = "Launch Project Generic",
		type = "codelldb",
		request = "launch",
		program = '${workspaceFolder}/target/debug/${workspaceFolderBasename}',
	},
}

-- go
require('dap-go').setup({
	dap_configurations = {
		{
			name = "Launch Project Generic",
			type = "go",
			request = "launch",
			program = '${workspaceFolder}/main.go',
			-- env = {
			--         EXAMPLE: 'example',
			-- }
		},
		{
			name = "Launch Project With Args Generic",
			type = "go",
			request = "launch",
			program = '${workspaceFolder}/main.go',
			args = utils.get_args,
		},
	},
})

-- c
dap.configurations.c = {
	{
		name = "Launch Project Generic",
		type = "codelldb",
		request = "launch",
		program = '${workspaceFolder}/target/debug/${workspaceFolderBasename}',
	}
}

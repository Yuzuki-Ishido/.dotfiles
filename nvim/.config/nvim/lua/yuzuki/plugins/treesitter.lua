return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.config")
			config.setup({
				auto_install = true,
				ensure_installed = {
					"bash",
					"html",
					"css",
					"javascript",
					"typescript",
					"json",
					"lua",
				},
				highlight = { enable = true },
				indent = { enable = false },
			})
		end,
	},
}

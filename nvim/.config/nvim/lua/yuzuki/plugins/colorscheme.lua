return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- from lightest to darkest: latte, frappe, macchiato, and mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false, -- disables setting the background color
			show_end_of_buffer = false, -- shows '~' characters after the end of buffers
			term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
			dim_inactive = {
				enabled = true, -- dims the background color of the inactive window
				shade = "dark",
				percentage = 0.15,
			},
			no_italic = false, -- force no italic
			no_bold = false, -- force no bold
			no_underline = false, -- force no underline
			styles = { -- handles the style of general hi groups (see `:h highlight-args`)
				comments = { "italic" }, -- change the style of comments
				conditionals = { "italic" },
			},
			color_overrides = {
				mocha = {
					-- base = "#222330",
				},
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}

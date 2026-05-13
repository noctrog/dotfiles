local M = {}

M.lazy_spec = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			term_colors = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				mason = true,
				telescope = true,
				treesitter = true,
				which_key = true,
			},
		})

		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}

function M.use_packer(use)
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				term_colors = true,
			})
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	})
end

return M

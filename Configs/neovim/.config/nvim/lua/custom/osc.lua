-- vim.g.clipboard = {
-- 	name = "OSC 52",
-- 	copy = {
-- 		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
-- 		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
-- 	},
-- 	paste = {
-- 		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
-- 		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
-- 	},
-- }
return {
	"ojroques/nvim-osc52",
	config = function()
		vim.keymap.set("n", "<leader>c", require("osc52").copy_operator, { expr = true })
		vim.keymap.set("n", "<leader>cc", "<leader>c_", { remap = true })
		vim.keymap.set("v", "<leader>c", require("osc52").copy_visual)
	end,
}

return {
	{
		"mistricky/codesnap.nvim",
		build = "make",
		enabled = function()
			return jit.os == "Linux"
		end,
	},
}

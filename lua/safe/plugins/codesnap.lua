return {
	{
		"mistricky/codesnap.nvim",
		build = "make",
        version = "0.8.*",
		enabled = function()
			return jit.os == "Linux"
		end,
	},
}

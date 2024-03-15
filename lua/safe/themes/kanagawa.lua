local colors = {
	black = "#0d0c0c",
	white = "#c5c9c5",
	red = "#c4746e",
	green = "#87a987",
	blue = "#8ba4b0",
	yellow = "#c4b28a",
	gray = "#9e9b93",
	darkgray = "#7a8382",
	lightgray = "#a6a69c",
	inactivegray = "#7c6f64",
	transparent = nil,
}
return {
	normal = {
		a = { bg = colors.gray, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.transparent, fg = colors.gray },
	},
	insert = {
		a = { bg = colors.blue, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.transparent, fg = colors.white },
	},
	visual = {
		a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.transparent, fg = colors.black },
	},
	replace = {
		a = { bg = colors.red, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.transparent, fg = colors.white },
	},
	command = {
		a = { bg = colors.green, fg = colors.black, gui = "bold" },
		b = { bg = colors.lightgray, fg = colors.white },
		c = { bg = colors.transparent, fg = colors.black },
	},
	inactive = {
		a = { bg = colors.darkgray, fg = colors.gray, gui = "bold" },
		b = { bg = colors.darkgray, fg = colors.gray },
		c = { bg = colors.transparent, fg = colors.gray },
	},
}

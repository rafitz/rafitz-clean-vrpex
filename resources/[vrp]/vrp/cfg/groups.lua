local cfg = {}

cfg.groups = {
	["CEO"] = {
		_config = {
			title = "C.E.O",
			gtype = "jobdois",
		},
		"ceo.permissao",
		"admin.permissao",
		"suporte.permissao"
	},
	["Admin"] = {
		_config = {
			title = "Admin",
			gtype = "jobdois",
		},
		"admin.permissao",
		"suporte.permissao"
	},
}

cfg.users = {
	[0] = { "CEO" },
	[1] = { "CEO" },
	[2] = { "CEO" },
}

cfg.selectors = {}

return cfg
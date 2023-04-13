return {
	settings = {
		python = {
			analysis = {
				useLibraryCodeForTypes = true,
				diagnosticSeverityOverrides = {
					reportUnusedVariable = "warning", -- or anything
				},
				typeCheckingMode = "basic",
			},
		},
	},
}

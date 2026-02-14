-- vim.o
vim.o.autochdir = false
vim.o.autoindent = true
vim.o.autoread = true
vim.o.background = "dark"
vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 0
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.fileencoding = "utf-8"
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = false
vim.o.number = true
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.showcmd = true
vim.o.showmatch = true
vim.o.showmode = false
vim.o.showtabline = 2
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.splitbelow = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.wildmenu = true
vim.o.wrap = false
vim.o.writebackup = false

-- vim.opt
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.termguicolors = true

-- vim.g
vim.g.encoding = "utf-8"
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.editorconfig = true

-- keymap
vim.api.nvim_set_keymap("n", "<S-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-l>", "<C-w>l", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<A-Up>", ":m-2<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-Down>", ":m+<cr>", { silent = true })

vim.api.nvim_set_keymap("n", "<leader>v", "<cmd>edit $MYVIMRC<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>wqa<cr>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-f>", "*", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>a", "gg<S-v>G", { noremap = true, silent = true })

-- folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local mirror = ""

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		mirror .. "https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	git = {
		url_format = mirror .. "https://github.com/%s.git",
	},
	checker = {
		enabled = true,
		notify = false,
	},
	rocks = {
		enabled = false,
	},
}

local lsp_server = {
	"lua_ls",
	"stylua",
	"gopls",
	"shfmt",
	"isort",
	"black",
}

local fmt_setttings = {
	lua = { "stylua" },
	sh = { "shfmt" },
	python = { "isort", "black" },
}

local lsps = {
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},
	{
		"williamboman/mason.nvim",
		opts = {
			max_concurrent_installers = require("math").huge,
			github = {
				download_url_template = mirror .. "https://github.com/%s/releases/download/%s/%s",
			},
			ui = {
				icons = {
					package_installed = "++",
					package_pending = "->",
					package_uninstalled = "--",
				},
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = lsp_server,
		},
	},
	{
		"jinzhongjia/LspUI.nvim",
		branch = "main",
		opts = {},
	},
}

local treesitters = {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		build = ":TSUpdate",
	},
	{
		"Wansmer/treesj",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{ "<leader>j", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
		},
		opts = {
			use_default_keymaps = false,
			max_join_length = 150 * 2,
		},
	},
	{
		"xzbdmw/colorful-menu.nvim",
		opts = {},
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},
}

local uis = {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = true,
				section_separators = "",
				component_separators = "",
			},
			sections = {
				lualine_b = {
					"branch",
					"diff",
					"diagnostics",
				},
				lualine_c = {
					{ "filename", path = 2 },
				},
				lualine_x = {
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
					},
					{
						function()
							return require("lsp-info").lsp_info()
						end,
					},
					{ "datetime", style = "iso" },
					{
						function()
							return require("lsp-info").loaded_slash_count()
						end,
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		},
	},
	{
		"i314q159/lsp-info",
		opts = {},
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-mini/mini.icons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		opts = {},
	},
	{
		"nvzone/showkeys",
		cmd = "ShowkeysToggle",
		opts = {
			maxkeys = 5,
		},
	},
	{
		"toppair/reach.nvim",
		cmd = { "ReachOpen" },
		opts = {},
		keys = {
			{ "<leader>b", "<cmd>ReachOpen buffers<cr>", desc = "ReachOpen Buffers" },
		},
	},
	{
		"axieax/urlview.nvim",
		lazy = false,
		keys = {
			{ "<leader>u", "<cmd>UrlView buffer<cr>", desc = "Urlview Buffer" },
		},
		opts = {},
	},
	{
		"xlboy/vscode-opener.nvim",
		keys = {
			{ "<leader>c", "<cmd>lua require('vscode-opener').open()<cr>", desc = "Open VSCode Opener Menu" },
		},
	},
}

local folkes = {
	{
		"folke/which-key.nvim",
		opts = {
			auto_show = false,
		},
		keys = {
			{ "<leader>k", "<cmd>WhichKey<cr>", desc = "WhichKey" },
		},
		lazy = false,
	},
	{
		"folke/todo-comments.nvim",
		lazy = false,
		opts = {},
	},
	{
		"folke/trouble.nvim",
		opts = {
			position = "bottom",
			icons = true,
			auto_close = true,
		},
		lazy = false,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "moon",
			transparent = false,
		},
	},
	{
		"folke/lazydev.nvim",
		opts = {},
	},
	{
		"folke/snacks.nvim",
		opts = {},
	},
}

local icons = {
	{
		"nvim-tree/nvim-web-devicons",
		opts = {},
	},
}

local fmts = {
	{
		"sbdchd/neoformat",
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = fmt_setttings,
			format_on_save = {
				lsp_format = "fallback",
			},
		},
	},
}

local cmps = {
	{
		"saghen/blink.cmp",
		version = "1.*",
		opts = {
			keymap = {
				preset = "super-tab",
			},
		},
	},
}

local colorschemes = {
	{
		"AlexvZyl/nordic.nvim",
	},
	{
		"vyfor/cord.nvim",
	},
}

local mds = {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
}

local file_explorers = {
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		keys = {
			{ "<leader>e", "<cmd>Oil .<cr>", desc = "Oil root directory" },
		},
	},
}
local imes = {
	{
		"StellarDeca/lazyime.nvim",
		lazy = true,
		opts = {},
		event = {
			"VeryLazy",
		},
	},
}

local gits = {
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
		keys = {
			{ "<leader>h", "<cmd>Gitsigns preview_hunk<cr>", desc = "Gitsigns Preview Hunk" },
			{ "<leader>n", "<cmd>Gitsigns next_hunk<cr><cr>", desc = "Gitsigns Next Hunk" },
		},
		lazy = false,
	},
	{
		"f-person/git-blame.nvim",
		opts = {},
		lazy = false,
	},
}

local others = {
	{
		"nguyenvukhang/nvim-toggler",
		keys = {
			{ "<leader>i", "require('nvim-toggler').toggle", desc = "Toggle Word" },
		},
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			toggler = { line = "<C-\\>" },
		},
	},
	{
		"windwp/nvim-autopairs",
		opts = {},
	},
	{
		"ethanholz/nvim-lastplace",
		opts = {},
	},
	{
		"elentok/scriptify.nvim",
		keys = {
			{ "<leader>s", "<cmd>Scriptify<cr>", desc = "Scriptify" },
		},
		opts = {},
		cmd = { "Scriptify" },
	},
	{
		"roobert/f-string-toggle.nvim",
		opts = {
			key_binding = "fs",
		},
	},
	{
		"sQVe/sort.nvim",
		opts = {},
	},
	{
		"okuuva/auto-save.nvim",
		version = "^1.0.0",
		event = {
			"InsertLeave",
			"TextChanged",
		},
	},
	{
		"cappyzawa/trim.nvim",
		opts = {},
	},
		{
		"VidocqH/lsp-lens.nvim",
		opts = {},
	},
		{
		"vidocqh/auto-indent.nvim",
		opts = {},
	},
		{
		"sontungexpt/stcursorword",
		event = "VeryLazy",
		config = true,
	},
	{
		"m-demare/hlargs.nvim",
		opts = {},
	},
		{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				mode = "virtualtext",
			},
		},
	},
	{
		"chentoast/marks.nvim",
		opts = {},
	},
	{
		"kevinhwang91/nvim-hlslens",
		opts = {},
	},
	{
		"nacro90/numb.nvim",
		opts = {},
	},

	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"chrisgrieser/nvim-puppeteer",
		lazy = false,
	},
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "<leader>o", "<cmd>Outline<cr>", desc = "Toggle Outline" },
		},
		opts = {
			outline_window = {
				width = 40,
				relative_width = true,
				auto_close = true,
				auto_jump = true,
				show_numbers = true,
				show_relative_numbers = false,
				wrap = true,
			},
		},
	},
	{
		"echasnovski/mini.diff",
		version = "*",
		opts = {},
	},
}

local plugins = {
	cmps,
	colorschemes,
	file_explorers,
	fmts,
	folkes,
	gits,
	icons,
	imes,
	lsps,
	mds,
	others,
	treesitters,
	uis,
}

require("lazy").setup(plugins, opts)
vim.cmd("colorscheme tokyonight-moon")
vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>Lazy<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>m", "<cmd>Mason<cr>", { noremap = true, silent = true })

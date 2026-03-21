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

-- statusline
vim.opt.statusline = ""
vim.opt.statusline:append("%{toupper(mode())}")
vim.opt.statusline:append(" %f")
vim.opt.statusline:append(" %m")

vim.opt.statusline:append("%=")

vim.opt.statusline:append(" %{strftime('%Y-%m-%d')}")
vim.opt.statusline:append(" %p%%")
vim.opt.statusline:append(" %l:%L")
vim.opt.statusline:append(" %{&filetype}")

-- folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local mirror = ""

if not vim.uv.fs_stat(lazypath) then
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
	"black",
	"pylsp",
	"jq",
}

local fmt_setttings = {
	lua = {
		"stylua",
	},
	sh = {
		"shfmt",
	},
	python = {
		"black",
	},
	json = {
		"jq",
	},
}

local tag_lsp = {
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
		"VidocqH/lsp-lens.nvim",
		opts = {},
	},
	{
		"hedyhli/outline.nvim",
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
		"j-hui/fidget.nvim",
		opts = {},
	},
}

local tag_syntax = {
	{
		"nvim-treesitter/nvim-treesitter",
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
	{
		"m-demare/hlargs.nvim",
		opts = {},
	},
}

local uis = {
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
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
}

local folkes = {
	{
		"folke/which-key.nvim",
		opts = {
			preset = "modern",
			triggers = {
				"<leader>",
			},
		},
		keys = {
			{ "<leader>k", "<cmd>WhichKey<cr>", desc = "WhichKey" },
		},
	},
	{
		"folke/todo-comments.nvim",
		opts = {},
	},
	{
		"folke/trouble.nvim",
		opts = {
			position = "bottom",
			icons = true,
			auto_close = true,
		},
	},
	{
		"folke/lazydev.nvim",
		opts = {},
	},
}

local tag_formatting = {
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
	{
		"vidocqh/auto-indent.nvim",
		opts = {},
	},
}

local tag_completion = {
	{
		"saghen/blink.cmp",
		version = "1.*",
		opts = {
			keymap = {
				preset = "enter",
			},
			completion = {
				documentation = {
					auto_show = true,
				},
			},
			signature = {
				enabled = true,
			},
			cmdline = {
				completion = {
					menu = {
						auto_show = true,
					},
				},
			},
		},
	},
}

local tag_colorscheme = {
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
	},
}

local tag_file_explorer = {
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>e", "<cmd>Oil .<cr>", desc = "Oil root directory" },
		},
	},
}

local tag_git = {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = false,
			preview_hunk_inline = true,
		},
		keys = {
			{ "<leader>h", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Gitsigns Preview Hunk Inline" },
			{ "<leader>n", "<cmd>Gitsigns next_hunk<cr>", desc = "Gitsigns Next Hunk" },
		},
	},
}

local tag_editing_support = {
	{
		"windwp/nvim-autopairs",
		opts = {},
	},
	{
		"qwavies/smart-backspace.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			map_bs = false,
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			toggler = { line = "<C-\\>" },
		},
	},
	{
		"nguyenvukhang/nvim-toggler",
		keys = {
			{ "<leader>i", "require('nvim-toggler').toggle", desc = "Toggle Word" },
		},
		opts = {},
	},
	{
		"ethanholz/nvim-lastplace",
		opts = {},
	},
	{
		"sQVe/sort.nvim",
		opts = {},
	},
	{
		"okuuva/auto-save.nvim",
		version = "^1.0.0",
		event = { "InsertLeave", "TextChanged" },
	},
	{
		"cappyzawa/trim.nvim",
		opts = {},
	},
	{
		"nacro90/numb.nvim",
		opts = {},
	},
	{
		"chrisgrieser/nvim-puppeteer",
	},
	{
		"roobert/f-string-toggle.nvim",
		opts = {
			key_binding = "fs",
		},
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
		"gbprod/yanky.nvim",
		opts = {},
	},
	{
		"nemanjamalesija/smart-paste.nvim",
		config = true,
	},
	{
		"mcauley-penney/visual-whitespace.nvim",
	},
}

local tag_color = {
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				mode = "virtualtext",
			},
		},
	},
}

local tag_search = {
	{
		"kevinhwang91/nvim-hlslens",
		opts = {},
	},
}

local others = {
	{
		"sontungexpt/stcursorword",
		config = true,
	},
	{
		"chentoast/marks.nvim",
		opts = {},
	},

	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{
		"echasnovski/mini.diff",
		version = "*",
		opts = {},
	},
}

-- https://neovimcraft.com/
local plugins = {
	folkes,
	others,
	tag_color,
	tag_colorscheme,
	tag_completion,
	tag_editing_support,
	tag_file_explorer,
	tag_formatting,
	tag_git,
	tag_lsp,
	tag_search,
	tag_syntax,
	uis,
}

require("lazy").setup(plugins, opts)
vim.cmd("colorscheme carbonfox")
vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>Lazy<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>m", "<cmd>Mason<cr>", { noremap = true, silent = true })

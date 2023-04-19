vim.g.mapleader = " "

vim.cmd [[packadd packer.nvim]]
require("packer").startup(function(use)
	use { "wbthomason/packer.nvim" }
	use { "folke/tokyonight.nvim" }
	use { "numToStr/Comment.nvim" }
	use {
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true }
	}
	use { "nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" } }
	use {
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		requires = { { "nvim-lua/plenary.nvim" } }
	}
	use { "f-person/git-blame.nvim" }
	use { "sainnhe/edge" }
	use { "fatih/vim-go", { run = ":GoUpdateBinaries" } }
	use {
		"VonHeikemen/lsp-zero.nvim",
		branch = 'v2.x',
		requires = {
			{ 'neovim/nvim-lspconfig' },
			{
				'williamboman/mason.nvim',
				run = ":MasonUpdate"
			},
			{ 'williamboman/mason-lspconfig.nvim' },

			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'L3MON4D3/LuaSnip' },
		}
	}
end)

vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.edge_style = "neon"
vim.g.edge_transparent_background = 1
vim.cmd("colorscheme edge")

require("lualine").setup({
	options = {
		theme = "edge"
	}
})

require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "vim", "go", "javascript", "typescript", "python", "css", "dockerfile", "html", "make", "sql", "hcl", "toml" },
	highlight = {
		enable = true,
	}
})

vim.g.go_fmt_command = "goimports"
local lsp = require("lsp-zero").preset({})
lsp.on_attach(function(_, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
	lsp.buffer_autoformat()
end)
require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			}
		}
	}
})
lsp.ensure_installed({
	"lua_ls",
})
lsp.setup()


vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.colorcolumn = "120"
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.o.hlsearch = true
vim.o.mouse = "a"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.timeout = true
vim.o.timeoutlen = 1000
vim.g.gitblame_enabled = 0

vim.keymap.set("i", "jj", "<ESC>")
vim.keymap.set("n", "<ESC>", ":noh<CR>")
require("Comment").setup({
	opleader = {
		line = "gc",
		block = "gb",
	}
})
vim.keymap.set("n", "<leader>v", ":vsplit<CR><C-w>l", { noremap = true, desc = "Split window vertically" })
vim.keymap.set("n", "<leader>h", ":wincmd h<CR>", { noremap = true, desc = "Move cursor to right buffer" })
vim.keymap.set("n", "<leader>l", ":wincmd l<CR>", { noremap = true, desc = "Move cursor to left buffer" })
vim.keymap.set("n", "<leader>j", ":wincmd j<CR>", { noremap = true, desc = "Move cursor to bottom buffer" })
vim.keymap.set("n", "<leader>k", ":wincmd k<CR>", { noremap = true, desc = "Move cursor to top buffer" })
vim.keymap.set("n", "<leader>e", ":Vex!<CR>", { desc = "Split window and explore" })

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>?", telescope.oldfiles, { desc = "Recently opened files" })
vim.keymap.set("n", "/", function()
	telescope.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "Current buffer fuzzy" })
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Search by filename" })
vim.keymap.set("n", "<leader>fs", telescope.live_grep, { desc = "Search root directory" })
vim.keymap.set("n", "<leader>fcw", telescope.grep_string, { desc = "Search by cursor word" })
vim.keymap.set("n", "<leader>gb", telescope.git_branches, { desc = "Show git branches, <CR> to checkout" })
vim.keymap.set("n", "<leader>gs", telescope.git_status, { desc = "Show git status, <Tab> to stage/un-stage" })
vim.keymap.set("n", "<leader>hk", telescope.keymaps, { desc = "Show defined keymaps" })
vim.keymap.set("n", "<leader>gd", telescope.lsp_definitions)
vim.keymap.set("n", "<leader>gr", telescope.lsp_references)
vim.keymap.set("n", "<leader>gi", telescope.lsp_implementations)

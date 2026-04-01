-- Show line numbers (recommended for developers)
-- Note: Change the value to `false` if you prefer a cleaner interface without line numbers, especially if you are new to Vim or prefer a minimalist setup.
vim.opt.number = true

-- Disable mouse support for a more traditional terminal experience
-- Note: Recommended to enable mouse support if you are using Neovim in a Android terminal emulator like Termux, as it can enhance navigation and usability on touch devices. You can enable mouse support by setting `vim.opt.mouse = 'a'` instead of `''`.
vim.opt.mouse = ''

-- Set the leader key to space for easier access to custom keybindings
vim.g.mapleader = ' '

-- Set up lazy.nvim for plugin management
local lazypath = vim.fn.stdpath('data')..'/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugin management using lazy.nvim
require('lazy').setup({
	-- Color Scheme (cranberry-clockworks/coal.nvim)
	{
		'cranberry-clockworks/coal.nvim',
		config = function()
			require('coal').setup({
				colors = {smoky_black = '#000000'}
			})
			vim.cmd.colorscheme('coal')
			-- Set the background of the editor to transparent (optional, but recommended for a tilling window manager setup)
			-- Uncomment to enable
			-- Note: This is recommended if you are using a tilling window manager like i3 or Sway, as it allows the terminal background to show through, creating a more cohesive and visually appealing environment. If you prefer a solid background color, you can remove these lines.
			-- vim.cmd('highlight Normal guibg=NONE')
			-- vim.cmd('highlight NormalNC guibg=NONE')
			-- vim.cmd('highlight TelescopeBorder guibg=NONE')
			-- vim.cmd('highlight TelescopeNormal guibg=NONE')
			-- vim.cmd('highlight NvimTreeNormal guibg=NONE')
			-- vim.cmd('highlight NvimTreeNormalNC guibg=NONE')
		end,
	},
	-- Treesitter (nvim-treesitter/nvim-treesitter)
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		branch = 'master',
		lazy = false,
		config = function()
			require('nvim-treesitter.configs').setup({
				parser_install_dir = vim.fn.stdpath('data')..'site/parser',
				ensure_installed = {
					'bash', 'python', 'c', 'cpp', 'lua',
					'markdown', 'markdown_inline'
				},
				auto_install = false,
				highlight = {
					enable = true,
				},
			})
		end,
	},
	-- Dashboard (goolord/alpha-nvim)
	{
		'goolord/alpha-nvim',
		dependencies = {'nvim-tree/nvim-web-devicons'},
		config = function()
			local alpha = require('alpha')
			local dashboard = require('alpha.themes.dashboard')

			dashboard.section.header.val = {
				" ",
				" ██████╗  █████╗ ██████╗ ██╗  ██╗██╗   ██╗██╗███╗   ███╗",
				" ██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██║   ██║██║████╗ ████║",
				" ██║  ██║███████║██████╔╝█████╔╝ ██║   ██║██║██╔████╔██║",
				" ██║  ██║██╔══██║██╔══██╗██╔═██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║",
				" ██████╔╝██║  ██║██║  ██║██║  ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║",
				" ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
				" ",
			}

			dashboard.section.buttons.val = {
				dashboard.button("n", "  New file", ":enew<CR>"),
				dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
				dashboard.button("c", "  Config", ":e ~/.config/nvim/init.lua<CR>"),
				dashboard.button("h", "󰮥  Help", ":help<CR>"),
				dashboard.button("q", "󰈆  Quit", ":qa<CR>"),
			}
			alpha.setup(dashboard.config)
		end,
	},
	-- Finder (nvim-telescope/telescope.nvim)
	{
		'nvim-telescope/telescope-project.nvim',
		dependencies = {'nvim-telescope/telescope.nvim'},
		config = function()
			require('telescope').load_extension('project')
		end,
	},
	-- GitHub Copilot Auto-Suggestion (github/copilot.nvim)
	-- Note: Recommended to remove this plugin if you are using an old device or have limited resources, as it can be resource-intensive. Not recommended enable this plugin if you are using Neovim via Termux on Android, as it may cause performance issues.
	{
		'github/copilot.vim',
		lazy = false,
	},
	-- LSP Setup:
	-- Mason (williamboman/mason.nvim) for managing LSP servers
	-- Mason LSPConfig (williamboman/mason-lspconfig.nvim) for integrating Mason with Neovim's built-in LSP client
	-- nvim-lspconfig (neovim/nvim-lspconfig) for configuring LSP servers
	-- nvim-cmp (hrsh7th/nvim-cmp) for autocompletion, along with its dependencies for LSP source, buffer source, path source, and LuaSnip integration
	-- Note: The LSP setup is configured to automatically install and manage LSP servers for Lua, Python, C/C++, Bash, and Markdown. It also sets up keybindings for common LSP actions like go to definition, hover, rename, code actions, references, and diagnostics navigation.
	{
		'williamboman/mason.nvim',
		build = ':MasonUpdate',
		config = function()
			require('mason').setup()
		end,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = {'williamboman/mason.nvim'},
		config = function()
			local on_attach = function(client, bufnr)
				local bufopts = {noremap=true, silent=true, buffer=bufnr}
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
				vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
				vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
				vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
			end

			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			require('mason-lspconfig').setup({
				ensure_installed = {'lua_ls', 'pyright', 'clangd', 'bashls', 'marksman'},
				automatic_installation = true,
				handlers = {
					function(server_name)
						require('lspconfig')[server_name].setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,
				},
			})
		end,
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {'williamboman/mason-lspconfig.nvim'},
		config = function()
		end,
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
		},
		config = function()
			local cmp = require('cmp')
			local luasnip = require('luasnip')

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, {'i', 's'}),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, {'i', 's'}),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				}, {
					{ name = 'buffer' },
					{ name = 'path' },
				}),
			})
		end,
	},
	-- File Explorer (nvim-tree/nvim-tree.lua)
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = {'nvim-tree/nvim-web-devicons'},
		config = function()
			require('nvim-tree').setup({
				renderer = {
					icons = {
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
						},
					},
				},
				on_attach = function(bufnr)
					local api = require('nvim-tree.api')
					local function opts(desc)
						return {desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true}
					end
					vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
					vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
					vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
					vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
					vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
					vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
					vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
					vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
					vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
				end,
			})
		end,
	},
	-- Terminal (akinsho/toggleterm.nvim)
	{
		'akinsho/toggleterm.nvim',
		version = '*',
		config = function()
			require('toggleterm').setup({
				size = 10,
				open_mapping = [[<C-t>]],
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				persist_size = true,
				direction = 'horizontal',
				close_on_exit = true,
				shell = vim.o.shell,
			})
		end,
	},
})
-- Keybinding to toggle the file explorer
vim.keymap.set('n', '<C-e>', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })

-- Ensure the runtime path includes the site directory for plugins
vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/site/')

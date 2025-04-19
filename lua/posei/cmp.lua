local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = {
  Text = "󰉿",          -- nf-md-text
  Method = "󰆧",        -- nf-md-function_variant
  Function = "󰊕",      -- nf-md-function
  Constructor = "",   -- nf-oct-tools
  Field = "󰜢",         -- nf-md-view_column
  Variable = "󰀫",      -- nf-md-variable
  Class = "󰠱",         -- nf-md-school
  Interface = "",     -- nf-fa-sitemap
  Module = "󰏗",        -- nf-md-package_variant
  Property = "󰜢",      -- nf-md-view_column
  Unit = "",          -- nf-dev-dotnet
  Value = "󰎠",         -- nf-md-tune
  Enum = "",          -- nf-fa-list_ol
  Keyword = "󰌋",       -- nf-md-key
  Color = "󰸌",         -- nf-md-palette
  File = "󰈔",          -- nf-md-file_document
  Reference = "󰈇",     -- nf-md-file_link
  Folder = "󰉋",        -- nf-md-folder
  EnumMember = "",     -- nf-fa-list_ol
  Constant = "󰏿",      -- nf-md-alpha_c
  Struct = "󰙅",        -- nf-md-layers
  Event = "",         -- nf-fa-bolt
  Operator = "󰆕",      -- nf-md-code_braces
  TypeParameter = "󰊄", -- nf-md-format_wrap_inline
}

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = kind_icons[vim_item.kind]
			vim_item.menu = ({
				nvim_lsp = "",
				nvim_lua = "",
				luasnip = "",
				buffer = "",
				path = "",
				emoji = "",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	experimental = {
    ghost_text = true,
	},
})

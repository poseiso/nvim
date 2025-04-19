local status_ok, mason = pcall(require, "mason")
if not status_ok then return end

local mason_lsp_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lsp_status_ok then return end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then return end

local servers = {
  "lua_ls",
  "bashls",
  "jsonls",
  "yamlls",
  "dockerls",
  "gopls",
  "gdscript",
  "dartls",
}

mason.setup()
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

for _, server in ipairs(servers) do
  local opts = {
    on_attach = require("posei.lsp.handlers").on_attach,
    capabilities = require("posei.lsp.handlers").capabilities,
  }

  if server == "lua_ls" then
    local lua_opts = require("posei.lsp.settings.lua_ls")
    opts = vim.tbl_deep_extend("force", lua_opts, opts)
  end

  if server == "dartls" then
    require("flutter-tools").setup {
      widget_guides = { enabled = true },
      fvm = true,
      lsp = opts,
    }
  else
    lspconfig[server].setup(opts)
  end
end

local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "sumneko_lua",
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "rust_analyzer",
  "gdscript",
  "dartls",
  "clangd",
  "tailwindcss"
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("posei.lsp.handlers").on_attach,
    capabilities = require("posei.lsp.handlers").capabilities,
  }

  if server == "rust_analyzer" then
    local sumneko_opts = require "posei.lsp.settings.rust_analyzer"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "sumneko_lua" then
    local sumneko_opts = require "posei.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "posei.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  lspconfig[server].setup(opts)
end

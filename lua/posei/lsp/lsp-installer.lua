local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "lua_ls",
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "dockerls",
  "gopls",
  "rust_analyzer",
  "gdscript",
  "dartls",
  "clangd",
  "tailwindcss",
  "jdtls"
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
    local rust_opts = require "posei.lsp.settings.rust_analyzer"
    opts = vim.tbl_deep_extend("force", rust_opts, opts)
  end

  if server == "tsserver" then
    local ts_opts = require "posei.lsp.settings.tsserver"
    opts = vim.tbl_deep_extend("force", ts_opts, opts)
  end

  if server == "lua_ls" then
    local sumneko_opts = require "posei.lsp.settings.lua_ls"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "posei.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "dartls" then
    require("flutter-tools").setup{
      widget_guides = {
        enabled = true,
      },
      fvm = true, 
      lsp = {
        on_attach = require("posei.lsp.handlers").on_attach,
        capabilities = require("posei.lsp.handlers").capabilities,
      }
    }
  else
    lspconfig[server].setup(opts)
  end
end

local status_ok, mason = pcall(require, "mason")
if not status_ok then return end

local mason_lsp_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lsp_status_ok then return end

-- Using vim.lsp.config instead of require("lspconfig")

local servers = {
  "lua_ls",
  "bashls",
  "jsonls",
  "yamlls",
  "dockerls",
  "gopls",
  "ts_ls",
  "clangd",
  "gdscript"
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
  elseif server == "jsonls" then
    opts.settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    }
  elseif server == "yamlls" then
    opts.settings = {
      yaml = {
        schemas = require("schemastore").yaml.schemas(),
      },
    }
  end

  vim.lsp.config[server] = opts
end

-- Enable all configured LSP servers
vim.lsp.enable(servers)

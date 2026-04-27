local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return M
end

M.capabilities = cmp_nvim_lsp.default_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn",  text = "" },
    { name = "DiagnosticSignHint",  text = "" },
    { name = "DiagnosticSignInfo",  text = "" },
  }

  vim.diagnostic.config({
    virtual_lines = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = signs[1].text,
        [vim.diagnostic.severity.WARN]  = signs[2].text,
        [vim.diagnostic.severity.HINT]  = signs[3].text,
        [vim.diagnostic.severity.INFO]  = signs[4].text,
      },
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      header = "",
      prefix = "",
    },
  })
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, opts)
  vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>lj", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "gn", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, opts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  local ok, illuminate = pcall(require, "illuminate")
  if ok then illuminate.on_attach(client) end
end

return M

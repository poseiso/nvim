local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return M
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn",  text = "" },
    { name = "DiagnosticSignHint",  text = "" },
    { name = "DiagnosticSignInfo",  text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  vim.diagnostic.config({
    virtual_text = false,
    signs = { active = signs },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      source = "always",
      header = "",
      prefix = "",
    },
  })
end

local function lsp_keymaps(bufnr)
  print("✅ setting keymaps for buffer " .. bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
  keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<CR>", opts)
  keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  keymap(bufnr, "n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  keymap(bufnr, "n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
end

M.on_attach = function(client, bufnr)
  print("✅ on_attach fired for " .. client.name)
  lsp_keymaps(bufnr)
  local ok, illuminate = pcall(require, "illuminate")
  if ok then illuminate.on_attach(client) end
end

return M

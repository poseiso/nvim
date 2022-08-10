local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "posei.lsp.lsp-installer"
require("posei.lsp.handlers").setup()
require "posei.lsp.null-ls"

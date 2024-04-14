return {
    handlers = {
        ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
            if result.diagnostics ~= nil then
                local idx = 1
                while idx <= #result.diagnostics do
                    if result.diagnostics[idx].code == 80001 then
                        table.remove(result.diagnostics, idx)
                    else
                        idx = idx + 1
                    end
                end
            end
            vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
        end,
    }
}

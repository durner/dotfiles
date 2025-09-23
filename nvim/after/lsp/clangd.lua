local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.offsetEncoding = "utf-8"
capabilities.clang = {}
capabilities.clang.offsetEncoding = "utf-8"

return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders=1",
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true
    },
    capabilities = capabilities
}

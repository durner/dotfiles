local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.offsetEncoding = "utf-8"
capabilities.offset_encoding = "utf-8"
capabilities.clang = {}
capabilities.clang.offsetEncoding = "utf-8"
capabilities.clang.offset_encoding = "utf-8"

local util = require("lspconfig.util")
local server_config = {
    filetypes = {"c", "cpp", "objc", "objcpp", "opencl", "hpp", "h"},
    offset_encoding = "utf-8",
    root_dir = function(fname)
        return util.root_pattern("compile_commands.json", "compile_flags.txt",
                                 ".git")(fname) or util.find_git_ancestor(fname)
    end,
    init_options = {
        highlight = {lsRanges = true},
        clang = {extraArgs = {"-I./include", "-I./src", "-isystem"}},
        cache = {directory = "/tmp/.ccls-cache"}
    },
    capabilities = capabilities
}
require("ccls").setup({
    lsp = {
        lspconfig = server_config,
        server = server_config,
        codelens = {enable = true}
    }
})

require'lspconfig'.grammarly.setup({
    filetypes = {"markdown", "latex", "tex", "text"}
})

vim.cmd [[
"Large File Handling
autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif
]]

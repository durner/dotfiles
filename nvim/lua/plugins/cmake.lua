return {
    "Civitasv/cmake-tools.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("cmake-tools").setup {
            cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
            cmake_build_directory = function()
                return "build/${variant:buildType}"
            end,
            cmake_dap_configuration = {
                name = "cpp",
                type = "codelldb",
                request = "launch",
                stopOnEntry = false,
                runInTerminal = true,
                console = "integratedTerminal",
            },
            cmake_executor = {
                name = "quickfix",
            },
            cmake_virtual_text_support = false
        }
    end
}

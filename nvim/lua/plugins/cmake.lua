return {
    "Civitasv/cmake-tools.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("cmake-tools").setup {
            cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
            cmake_build_options = { "-j 16" },
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
                name = "toggleterm",
                opts = {
                    direction = "horizontal",
                    close_on_exit = true,
                    auto_scroll = true,
                    singleton = true
                }
            },
            cmake_runner = {
                name = "toggleterm",
                opts = {
                    direction = "horizontal",
                    close_on_exit = true,
                    auto_scroll = true,
                    singleton = true
                }
            },
            cmake_virtual_text_support = false
        }
    end
}

return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("fzf-lua").setup({ "telescope" })
        require("fzf-lua").register_ui_select({ "telescope" })
    end
}

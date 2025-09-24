return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {"<C-P>", "<leader>f", "<leader>q", "<leader>g"},
    cmd = {"FzfLua"},
    config = function()
        require("fzf-lua").setup({ "telescope" })
        require("fzf-lua").register_ui_select({ "telescope" })
    end
}

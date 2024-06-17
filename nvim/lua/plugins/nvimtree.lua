return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    cmd = "NvimTreeToggle",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup({ view = { adaptive_size = true } })
    end
}

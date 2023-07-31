local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
    {
        -- UI components
        "https://github.com/MunifTanjim/nui.nvim",
        lazy = true
    }, -- { UI Style
    {
        -- catppuccin Theme
        "https://github.com/catppuccin/nvim",
        config = function()
            require("catppuccin").setup({
                flavour = "latte",
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    barbar = true
                }
            })
            vim.cmd.colorscheme "catppuccin"
        end
    }, {
        -- Airline style
        "https://github.com/nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("lualine").setup({
                options = {
                    globalstatus = true,
                    icons_enabled = true,
                    theme = "catppuccin"
                },
                sections = {lualine_a = {{'filename', path = 1}}}
            })
        end
    }, {
        "romgrk/barbar.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        init = function() vim.g.barbar_auto_setup = true end,
        opts = {},
        version = "^1.0.0"
    }, {
        -- Better indention
        "https://github.com/lukas-reineke/indent-blankline.nvim",
        event = {"BufReadPost", "BufNewFile"},
        config = function()
            require("indent_blankline").setup({
                show_current_context = true,
                show_first_indent_level = false,
                show_trailing_blankline_indent = false
            })
        end
    }, {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    }, -- }
    -- { Search
    {
        -- FZF
        "ibhagwan/fzf-lua",
        config = function() require("fzf-lua").setup({}) end
    }, {
        -- NVIM Tree
        "https://github.com/nvim-tree/nvim-tree.lua",
        version = "*",
        cmd = "NvimTreeToggle",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require("nvim-tree").setup({view = {adaptive_size = true}})
        end
    }, -- }
    -- { Languages
    {
        --  CCLS
        "https://github.com/ranjithshegde/ccls.nvim",
        lazy = true
    }, {
        -- Switch between header and source
        "https://github.com/derekwyatt/vim-fswitch"
    }, {
        --  R
        "https://github.com/jalvesaq/Nvim-R"
    }, --
    -- { LSP
    {
        -- LSP and completion
        "https://github.com/williamboman/mason-lspconfig.nvim",
        event = {"BufReadPost", "BufNewFile"},
        dependencies = {
            "https://github.com/williamboman/mason.nvim",
            "https://github.com/neovim/nvim-lspconfig"
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {"bashls", "pyright", "texlab", "grammarly"}
            })
            require('mason-nvim-dap').setup({
                ensure_installed = {'python', 'cppdbg'},
                handlers = {}
            })

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = require("cmp_nvim_lsp").default_capabilities()
                    })
                end
            })
        end
    }, -- }
    -- { DAP
    {
        'https://github.com/jay-babu/mason-nvim-dap.nvim',
        dependencies = {
            'https://github.com/mfussenegger/nvim-dap',
            'https://github.com/rcarriga/nvim-dap-ui',
            'https://github.com/theHamsta/nvim-dap-virtual-text'
        },
        config = function()
            local dap = require 'dap'
            local dapui = require 'dapui'
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close({})
            end
        end
    }, -- { Completion
    {
        -- Auto completion
        "https://github.com/hrsh7th/nvim-cmp",
        dependencies = {
            "https://github.com/hrsh7th/cmp-buffer",
            "https://github.com/hrsh7th/cmp-nvim-lsp",
            "https://github.com/hrsh7th/cmp-path",
            "https://github.com/jalvesaq/cmp-nvim-r",
            "https://github.com/saadparwaiz1/cmp_luasnip", {
                "zbirenbaum/copilot-cmp",
                config = function()
                    require("copilot_cmp").setup()
                end
            }
        },
        event = "VeryLazy",
        config = function()
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                           vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
                               col, col):match("%s") == nil
            end

            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                completion = { autocomplete = false },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"] = cmp.mapping.confirm(),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, {"i", "s"}),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {"i", "s"})
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                sources = cmp.config.sources({
                    {name = "nvim_lsp", group_index = 2},
                    {name = "copilot", group_index = 2},
                    {name = "luasnip", group_index = 2},
                    {name = "buffer", group_index = 2},
                    {name = "cmp_nvim_r", group_index = 2},
                    {name = "path", group_index = 2}
                })
            })
        end
    }, {
        -- Snippets
        "https://github.com/L3MON4D3/LuaSnip",
        event = 'VeryLazy',
        dependencies = {"https://github.com/rafamadriz/friendly-snippets"},
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    }, {
        -- Copilot
        "https://github.com/zbirenbaum/copilot.lua",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({suggestion = {enable = true}, panel = {enable = false}})
            vim.cmd(":Copilot disable")
        end
    }, -- }
    -- }
    -- { Syntax highlighting
    {
        -- Treesitter
        "https://github.com/nvim-treesitter/nvim-treesitter",
        event = {"BufReadPost", "BufNewFile"},
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash", "gitcommit", "json", "lua", "python", "latex",
                    "cpp", "c"
                },
                sync_install = false,
                auto_install = true,
                highlight = {enable = true},
                indent = {enable = true}
            })
        end
    }, -- }
    -- { Formatting
    {
        -- Neoformat for clang-format
        "https://github.com/sbdchd/neoformat",
        cmd = "Neoformat",
        config = function()
            vim.g.neoformat_try_node_exe = true
            vim.g.neoformat_basic_format_align = 1
            vim.g.neoformat_basic_format_retab = 1
            vim.g.neoformat_basic_format_trim = 1
        end
    }, {
        -- Better brackets
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    }, {
        'johnfrankmorgan/whitespace.nvim',
        config = function() require('whitespace-nvim').setup({}) end
    }, -- }
    -- { Git
    {
        -- Git Signs
        "https://github.com/lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup({current_line_blame = true})
        end
    }, {
        -- Diff View
        "https://github.com/sindrets/diffview.nvim",
        cmd = {"DiffviewFileHistory"}
    }
    -- }
})

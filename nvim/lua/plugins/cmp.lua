return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "jalvesaq/cmp-nvim-r",
        "saadparwaiz1/cmp_luasnip",
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
        local kind_icons = require("config.icons").kind

        local formatting_style = {
            fields = { "kind", "abbr", "menu" },

            format = function(_, item)
                local icon = (kind_icons[item.kind]) or ""
                icon = " " .. icon .. " "
                item.menu = "   (" .. item.kind .. ")"
                item.kind = icon
                return item
            end,
        }

        cmp.setup({
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
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<Down>"] = cmp.mapping(function(fallback)
                    cmp.close()
                    fallback()
                end, { "i" }),
                ["<Up>"] = cmp.mapping(function(fallback)
                    cmp.close()
                    fallback()
                end, { "i" }),
            }),
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end
            },
            formatting = formatting_style,
            sources = cmp.config.sources({
                { name = "nvim_lsp",   group_index = 2 },
                { name = "copilot",    group_index = 2 },
                { name = "luasnip",    group_index = 2 },
                { name = "buffer",     group_index = 2 },
                { name = "cmp_nvim_r", group_index = 2 },
                { name = "path",       group_index = 2 }
            }),
            window = {
                documentation = {
                    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                },
                completion = {
                    border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                }
            },
        })
    end
}

return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                light_style = "day",
                transparent = true,
                terminal_colors = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = {},
                    variables = {},
                    sidebars = "dark",
                    floats = "dark",
                },
                sidebars = { "qf", "help" },
                day_brightness = 0.3,
                hide_inactive_statusline = false,
                dim_inactive = false,
                lualine_bold = false,
                on_colors = function(colors) end,
                on_highlights = function(hl, colors)
                    hl.LineNrAbove = {
                        fg = "#3285a3",
                    }

                    hl.LineNr = {
                        fg = colors.orange,
                        bold = true,
                    }

                    hl.LineNrBelow = {
                        fg = "#3285a3",
                    }
                end,
            })
            vim.cmd([[colorscheme tokyonight]])
            vim.cmd([[highlight! link TreesitterContext Normal]])
        end,
    },
    {
        "othree/html5.vim",
        event = "BufRead",
    },
}

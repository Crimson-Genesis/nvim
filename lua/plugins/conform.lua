return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>a<CR>",
            function()
                require("conform").format({
                    async = true,
                    lsp_format = "fallback",
                })
            end,
            mode = "",
            desc = "[F]ormat buffer",
        },
    },
    config = function()
        require("conform").setup({
            -- format_on_save = {
            --     lsp_format = "fallback",
            --     timeout_ms = 500,
            -- },
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                rust = { "rustfmt", lsp_format = "fallback" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                json = { "prettier" },
                css = { "prettier" },
                html = { "htmlbeautifier" },
                htmldjango = { "htmlbeautifier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
            },
            formatters = {
                stylua = {
                    command = "stylua", -- Path to the Stylua binary
                    args = {
                        "--indent-type",
                        "Spaces", -- Set indent type to spaces
                        "--indent-width",
                        "4", -- Set indent width to 4 spaces
                        "--column-width",
                        "200", -- Set maximum column width
                        "--stdin-filepath",
                        "$FILENAME", -- For proper file path resolution
                        "--", -- Marks the end of Stylua options
                        "-", -- Read from stdin
                    },
                    stdin = true, -- Stylua works with stdin
                },
            },
        })
    end,
}

return {
    -- Autoformat
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
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = { c = true, cpp = true }
            local lsp_format_opt
            if disable_filetypes[vim.bo[bufnr].filetype] then
                lsp_format_opt = "never"
            else
                lsp_format_opt = "fallback"
            end
            return {
                timeout_ms = 500,
                lsp_format = lsp_format_opt,
            }
        end,
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "black" },
            rust = { "rustfmt", lsp_format = "fallback" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            json = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
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
    },
}

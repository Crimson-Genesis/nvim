return {
    --------------------------------------------------------------------------------
    -- Mason (install tools only)
    --------------------------------------------------------------------------------
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = true,
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            vim.keymap.set("n", "<leader>pm", ":Mason<CR>", { noremap = true, silent = true })
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- LSP servers
                    "lua-language-server",
                    "pyright",
                    "clangd",
                    "rust-analyzer",
                    "gopls",
                    "r-languageserver",
                    "vim-language-server",
                    "bash-language-server",
                    "ltex-ls",

                    -- Formatters / tools
                    "stylua",
                    "black",
                    "isort",
                    "prettier",
                    "clang-format",
                },
                auto_update = true,
                run_on_start = true,
            })
        end,
    },

    --------------------------------------------------------------------------------
    -- Blink.cmp (completion)
    --------------------------------------------------------------------------------
    {
        "saghen/blink.cmp",
        version = "1.*",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "archie-judd/blink-cmp-words",
            "erooke/blink-cmp-latex",
        },
        opts = {
            keymap = {
                preset = "default",
                -- Explicit overrides (optional)
                ["<CR>"] = { "accept", "fallback" },
                ["<M-j>"] = { "select_next", "snippet_forward", "fallback" },
                ["<M-k>"] = { "select_prev", "snippet_backward", "fallback" },

                ["<S-k>"] = { "scroll_documentation_up", "fallback" },
                ["<S-j>"] = { "scroll_documentation_down", "fallback" },

                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
            },
            completion = {
                keyword = { range = "full" },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 100,
                },
                ghost_text = { enabled = true },
                list = {
                    max_items = 200,
                    selection = {
                        preselect = true,
                        auto_insert = false,
                    },
                    cycle = {
                        from_bottom = true,
                        from_top = true,
                    },
                },
            },
            snippets = {
                preset = "luasnip",
                expand = function(snippet)
                    require("luasnip").lsp_expand(snippet)
                end,
                active = function(filter)
                    if filter and filter.direction then
                        return require("luasnip").jumpable(filter.direction)
                    end
                    return require("luasnip").in_snippet()
                end,
                jump = function(direction)
                    require("luasnip").jump(direction)
                end,
            },
            sources = {
                default = {
                    "lsp",
                    "snippets",
                    "path",
                    "dictionary",
                    "buffer",
                    "cmdline",
                    "omni",
                    "latex",
                },
                providers = {
                    lsp = {
                        name = "lsp",
                        enabled = true,
                        module = "blink.cmp.sources.lsp",
                        score_offset = 1000,
                    },
                    thesaurus = {
                        name = "blink-cmp-words",
                        module = "blink-cmp-words.thesaurus",
                        opts = {
                            score_offset = 20,
                            definition_pointers = { "!", "&", "^" },
                            similarity_pointers = { "&", "^" },
                            similarity_depth = 2,
                        },
                    },
                    dictionary = {
                        name = "blink-cmp-words-dic",
                        module = "blink-cmp-words.dictionary",
                        opts = {
                            dictionary_search_threshold = 3,
                            score_offset = 0,
                            definition_pointers = { "!", "&", "^" },
                        },
                    },
                    latex = {
                        name = "Latex",
                        module = "blink-cmp-latex",
                        score_offset = 40,
                        opts = {
                            -- set to true to insert the latex command instead of the symbol
                            insert_command = false,
                        },
                    },
                },
            },
            per_filetype = {
                text = { "dictionary" },
                markdown = { "dictionary", "buffer", "snippets" },
            },
            fuzzy = {
                implementation = "lua",
            },
        },
    },

    --------------------------------------------------------------------------------
    -- LSP (new API only)
    --------------------------------------------------------------------------------
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "saghen/blink.cmp", {
            "j-hui/fidget.nvim",
            opts = {},
            tag = "legacy",
        } },

        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                    map("<leader>dws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
                end,
            })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "json", "python", "c", "cpp", "lua", "html", "css" },
                callback = function()
                    vim.bo.tabstop = 4
                    vim.bo.shiftwidth = 4
                    vim.bo.softtabstop = 4
                    vim.bo.expandtab = true
                end,
            })

            ------------------------------------------------------------------------
            -- Capabilities (Blink → LSP)
            ------------------------------------------------------------------------
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            ------------------------------------------------------------------------
            -- Common on_attach
            ------------------------------------------------------------------------
            local on_attach = function(_, bufnr)
                local map = function(lhs, rhs, desc)
                    vim.keymap.set("n", lhs, rhs, {
                        buffer = bufnr,
                        desc = "LSP: " .. desc,
                    })
                end

                map("gd", vim.lsp.buf.definition, "Goto Definition")
                map("gI", vim.lsp.buf.implementation, "Goto Implementation")
                map("K", vim.lsp.buf.hover, "Hover")
                map("<leader>rn", vim.lsp.buf.rename, "Rename")
                map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
            end

            ------------------------------------------------------------------------
            -- Servers (minimal set + asm)
            ------------------------------------------------------------------------
            local servers = {

                lua_ls = {
                    settings = {
                        Lua = {
                            completion = { callSnippet = "Replace" },
                        },
                    },
                },

                pyright = {},
                clangd = {},
                rust_analyzer = {},
                gopls = {},

                ["asm-lsp"] = {
                    cmd = { "asm-lsp" },
                    filetypes = { "asm", "s", "S" },
                    settings = {
                        asm = {
                            assembler = "nasm",
                            instruction_set = { "x86/x86-64" },
                        },
                    },
                },
            }

            ------------------------------------------------------------------------
            -- Register + enable servers
            ------------------------------------------------------------------------
            for name, cfg in pairs(servers) do
                cfg.capabilities = capabilities
                cfg.on_attach = on_attach

                vim.lsp.config(name, cfg)
                vim.lsp.enable(name)
            end
        end,
    },
}

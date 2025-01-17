return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            {
                "williamboman/mason.nvim",
                config = true,
            },

            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            {
                "j-hui/fidget.nvim",
                opts = {},
                tag = "legacy",
            },
            "hrsh7th/cmp-nvim-lsp",
        },
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

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            local servers = {
                pyright = {
                    on_attach = function(client, bufnr)
                        client.server_capabilities.document_formatting = false
                        client.server_capabilities.document_range_formatting = false
                    end,
                    settings = {
                        python = {
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                },
                lua_ls = {
                    on_attach = function(client, bufnr)
                        client.server_capabilities.document_formatting = false
                        client.server_capabilities.document_range_formatting = false
                    end,
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                },
                emmet_ls = {
                    on_attach = function(client, bufnr)
                        client.server_capabilities.document_formatting = false
                        client.server_capabilities.document_range_formatting = false
                    end,
                },
            }
            require("mason").setup()
            vim.keymap.set("n", "<leader>pm", ":Mason<CR>", { noremap = true, silent = true })
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                "bash-language-server",
                "vim-language-server",
                "stylua",
                "black",
                "lua_ls",
                "pyright",
                "isort",
                "rust_analyzer",
                "prettier",
                "clangd",
                "clang-format",
                "django-template-lsp",
                "html-lsp",
                "json-lsp",
                "css-lsp",
                "jinja-lsp",
                "emmet-language-server",
                "htmlbeautifier",
            })
            require("mason-tool-installer").setup({
                ensure_installed = ensure_installed,
                auto_update = true,
                run_on_start = true,
                integrations = {
                    ["mason-lspconfig"] = true,
                    ["mason-null-ls"] = true,
                    ["mason-nvim-dap"] = true,
                },
            })
            require("mason-lspconfig").setup({
                ensure_installed = {},
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "VeryLazy",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                        return
                    end
                    return "make install_jsregexp"
                end)(),
                dependencies = {
                    "rafamadriz/friendly-snippets",
                    "honza/vim-snippets",
                },
            },
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            luasnip.config.setup({})

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                preselect = "None",
                completion = { completeopt = "menu,menuone,noinsert,noselect" },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<C-Space>"] = cmp.mapping.complete({}),
                    ["<C-l>"] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { "i", "s" }),
                    ["<C-h>"] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { "i", "s" }),
                }),
                sources = {
                    {
                        name = "lazydev",
                        group_index = 0,
                    },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                },
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                    { name = "cmdline" },
                }),
            })
        end,
    },
}

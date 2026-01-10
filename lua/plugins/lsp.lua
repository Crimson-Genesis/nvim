-- return {
--     {
--         "neovim/nvim-lspconfig",
--         event = "BufReadPre",
--         dependencies = {
--             {
--                 "williamboman/mason.nvim",
--                 config = true,
--             },
--             "saghen/blink.cmp",
--             "WhoIsSethDaniel/mason-tool-installer.nvim",
--             {
--                 "j-hui/fidget.nvim",
--                 opts = {},
--                 tag = "legacy",
--             },
--         },
--         opts = {
--             servers = {
--                 lua_ls = {},
--             },
--         },
--         config = function(_, opts)
--             -- Auto commands
--             vim.api.nvim_create_autocmd("LspAttach", {
--                 group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
--                 callback = function(event)
--                     local map = function(keys, func, desc, mode)
--                         mode = mode or "n"
--                         vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
--                     end
--
--                     map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
--                     map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
--                     map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
--                     map("<leader>dws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
--                 end,
--             })
--             vim.api.nvim_create_autocmd("FileType", {
--                 pattern = { "json", "python", "c", "cpp", "lua", "html", "css" },
--                 callback = function()
--                     vim.bo.tabstop = 4
--                     vim.bo.shiftwidth = 4
--                     vim.bo.softtabstop = 4
--                     vim.bo.expandtab = true
--                 end,
--             })
--
--             -- Mason configurations
--             require("mason").setup()
--             vim.keymap.set("n", "<leader>pm", ":Mason<CR>", { noremap = true, silent = true })
--             local ensure_installed = {
--                 "bash-language-server",
--                 "vim-language-server",
--                 "stylua",
--                 "black",
--                 "lua_ls",
--                 "pyright",
--                 "isort",
--                 "rust_analyzer",
--                 "prettier",
--                 "clangd",
--                 "clang-format",
--                 "django-template-lsp",
--                 "html-lsp",
--                 "css-lsp",
--                 "jinja-lsp",
--                 "emmet-language-server",
--                 "htmlbeautifier",
--                 "gopls",
--                 "gitlab-ci-ls",
--                 "actionlint",
--                 "jdtls",
--                 "denols",
--                 "eslint-lsp",
--                 "checkmake",
--                 "r-languageserver",
--                 "ltex-ls",
--             }
--             require("mason-tool-installer").setup({
--                 ensure_installed = ensure_installed,
--                 auto_update = true,
--                 run_on_start = true,
--             })
--
--             -- Custom config starts here................................................................
--             vim.lsp.enable("asm-lsp")
--             vim.lsp.config("asm-lsp", {
--                 cmd = { "asm-lsp" },
--                 filetypes = { "asm", "S", "s" },
--                 root_dir = require("lspconfig").util.root_pattern("*.asm", "Makefile"),
--                 settings = {
--                     asm = {
--                         assembler = "nasm",
--                         instruction_se = { "x86/x86-64" },
--                     },
--                 },
--             })
--
--             -- vim.lsp.config("asm_lsp", {
--             --     cmd = { "asm-lsp" },
--             --     filetypes = { "asm", "s", "S" },
--             --     -- Some LS implementations read settings via `settings`, others via init_options.
--             --     -- We provide both to be robust.
--             --     settings = {
--             --         asm = {
--             --             assembler = "nasm",
--             --             instruction_set = { "x86/x86-64" }, -- correct key name
--             --         },
--             --     },
--             -- })
--
--             vim.lsp.config("pyright", {
--                 on_attach = function(client, bufnr)
--                     client.server_capabilities.document_formatting = false
--                     client.server_capabilities.document_range_formatting = false
--                 end,
--                 settings = {
--                     python = {
--                         completion = {
--                             callSnippet = "Replace",
--                         },
--                     },
--                 },
--             })
--
--             -- Custom config ends here................................................................
--             local capabilities = require("blink.cmp").get_lsp_capabilities()
--
--             vim.lsp.config("lua_ls", {
--                 capabilities = capabilities,
--                 on_attach = function(client)
--                     client.server_capabilities.documentFormattingProvider = false
--                     client.server_capabilities.documentRangeFormattingProvider = false
--                 end,
--                 settings = {
--                     Lua = {
--                         completion = {
--                             callSnippet = "Replace",
--                         },
--                     },
--                 },
--             })
--             vim.lsp.enable("lua_ls")
--
--             vim.lsp.config("emmet_ls", {
--                 on_attach = function(client, bufnr)
--                     client.server_capabilities.document_formatting = false
--                     client.server_capabilities.document_range_formatting = false
--                 end,
--             })
--
--         end,
--     },
--     --     {
--     --         "hrsh7th/nvim-cmp",
--     --         event = "VeryLazy",
--     --         dependencies = {
--     --             {
--     --                 "L3MON4D3/LuaSnip",
--     --                 build = (function()
--     --                     if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
--     --                         return
--     --                     end
--     --                     return "make install_jsregexp"
--     --                 end)(),
--     --                 dependencies = {
--     --                     "rafamadriz/friendly-snippets",
--     --                     "honza/vim-snippets",
--     --                 },
--     --             },
--     --             "saadparwaiz1/cmp_luasnip",
--     --             "hrsh7th/cmp-nvim-lsp",
--     --             "hrsh7th/cmp-path",
--     --             "hrsh7th/cmp-buffer",
--     --             "hrsh7th/cmp-cmdline",
--     --         },
--     --         config = function()
--     --             local cmp = require("cmp")
--     --             local luasnip = require("luasnip")
--     --             luasnip.config.setup({})
--     --
--     --             cmp.setup({
--     --                 snippet = {
--     --                     expand = function(args)
--     --                         luasnip.lsp_expand(args.body)
--     --                     end,
--     --                 },
--     --                 preselect = "None",
--     --                 completion = { completeopt = "menu,menuone,noinsert,noselect" },
--     --                 mapping = cmp.mapping.preset.insert({
--     --                     ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--     --                     ["<C-f>"] = cmp.mapping.scroll_docs(4),
--     --                     ["<C-y>"] = cmp.mapping.confirm({ select = true }),
--     --                     ["<CR>"] = cmp.mapping.confirm({ select = true }),
--     --                     ["<Tab>"] = cmp.mapping.select_next_item(),
--     --                     ["<S-Tab>"] = cmp.mapping.select_prev_item(),
--     --                     ["<C-Space>"] = cmp.mapping.complete({}),
--     --                     ["<C-l>"] = cmp.mapping(function()
--     --                         if luasnip.expand_or_locally_jumpable() then
--     --                             luasnip.expand_or_jump()
--     --                         end
--     --                     end, { "i", "s" }),
--     --                     ["<C-h>"] = cmp.mapping(function()
--     --                         if luasnip.locally_jumpable(-1) then
--     --                             luasnip.jump(-1)
--     --                         end
--     --                     end, { "i", "s" }),
--     --                 }),
--     --                 sources = {
--     --                     {
--     --                         name = "lazydev",
--     --                         group_index = 0,
--     --                     },
--     --                     { name = "nvim_lsp" },
--     --                     { name = "luasnip" },
--     --                     { name = "path" },
--     --                     { name = "buffer" },
--     --                 },
--     --             })
--     --
--     --             cmp.setup.cmdline({ "/", "?" }, {
--     --                 mapping = cmp.mapping.preset.cmdline(),
--     --                 sources = {
--     --                     { name = "buffer" },
--     --                 },
--     --             })
--     --
--     --             cmp.setup.cmdline(":", {
--     --                 mapping = cmp.mapping.preset.cmdline(),
--     --                 sources = cmp.config.sources({
--     --                     { name = "path" },
--     --                     { name = "cmdline" },
--     --                 }),
--     --             })
--     --         end,
--     --     },
--     {
--         "saghen/blink.cmp",
--         -- optional: provides snippets for the snippet source
--         dependencies = {
--             "rafamadriz/friendly-snippets",
--             "archie-judd/blink-cmp-words",
--             {
--                 "L3MON4D3/LuaSnip",
--                 build = (function()
--                     if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
--                         return
--                     end
--                     return "make install_jsregexp"
--                 end)(),
--                 dependencies = {
--                     "rafamadriz/friendly-snippets",
--                     "honza/vim-snippets",
--                 },
--             },
--         },
--     },
--
--     -- use a release tag to download pre-built binaries
--     version = "1.*",
--     -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
--     -- build = 'cargo build --release',
--     -- If you use nix, you can build from source using latest nightly rust with:
--     -- build = 'nix run .#build-plugin',
--
--     ---@module 'blink.cmp'
--     ---@type blink.cmp.Config
--     opts = {
--         -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
--         -- 'super-tab' for mappings similar to vscode (tab to accept)
--         -- 'enter' for enter to accept
--         -- 'none' for no mappings
--         --
--         -- All presets have the following mappings:
--         -- C-space: Open menu or open docs if already open
--         -- C-n/C-p or Up/Down: Select next/previous item
--         -- C-e: Hide menu
--         -- C-k: Toggle signature help (if signature.enabled = true)
--         --
--         -- See :h blink-cmp-config-keymap for defining your own keymap
--         keymap = { preset = "default" },
--
--         appearance = {
--             -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
--             -- Adjusts spacing to ensure icons are aligned
--             nerd_font_variant = "mono",
--         },
--
--         -- (Default) Only show the documentation popup when manually triggered
--         completion = { documentation = { auto_show = true } },
--
--         -- Default list of enabled providers defined so that you can extend it
--         -- elsewhere in your config, without redefining it, due to `opts_extend`
--         sources = {
--             default = { "lsp", "path", "snippets", "buffer" },
--             providers = {
--
--                 -- Use the thesaurus source
--                 thesaurus = {
--                     name = "blink-cmp-words",
--                     module = "blink-cmp-words.thesaurus",
--                     -- All available options
--                     opts = {
--                         -- A score offset applied to returned items.
--                         -- By default the highest score is 0 (item 1 has a score of -1, item 2 of -2 etc..).
--                         score_offset = 0,
--
--                         -- Default pointers define the lexical relations listed under each definition,
--                         -- see Pointer Symbols below.
--                         -- Default is as below ("antonyms", "similar to" and "also see").
--                         definition_pointers = { "!", "&", "^" },
--
--                         -- The pointers that are considered similar words when using the thesaurus,
--                         -- see Pointer Symbols below.
--                         -- Default is as below ("similar to", "also see" }
--                         similarity_pointers = { "&", "^" },
--
--                         -- The depth of similar words to recurse when collecting synonyms. 1 is similar words,
--                         -- 2 is similar words of similar words, etc. Increasing this may slow results.
--                         similarity_depth = 2,
--                     },
--                 },
--
--                 -- Use the dictionary source
--                 dictionary = {
--                     name = "blink-cmp-words",
--                     module = "blink-cmp-words.dictionary",
--                     -- All available options
--                     opts = {
--                         -- The number of characters required to trigger completion.
--                         -- Set this higher if completion is slow, 3 is default.
--                         dictionary_search_threshold = 3,
--
--                         -- See above
--                         score_offset = 0,
--
--                         -- See above
--                         definition_pointers = { "!", "&", "^" },
--                     },
--                 },
--             },
--         },
--         -- Setup completion by filetype
--         per_filetype = {
--             text = { "dictionary" },
--             markdown = { "thesaurus" },
--         },
--         -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
--         -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
--         -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
--         --
--         -- See the fuzzy documentation for more information
--         fuzzy = { implementation = "prefer_rust_with_warning" },
--     },
--     opts_extend = { "sources.default" },
-- }

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
                    "asm-lsp",

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
        },
        opts = {
            keymap = {
                preset = "default",
                -- Explicit overrides (optional)
                ["<CR>"] = { "accept", "fallback" },
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },

                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
            },

            completion = {
                documentation = { auto_show = true },
            },
            sources = {
                default = {
                    "lsp",
                    "snippets",
                    "path",
                    "buffer",
                    "cmdline",
                    "omni",
                },
                providers = {
                    lsp = {
                        name = "lsp",
                        enabled = true,
                        module = "blink.cmp.sources.lsp",
                        kind = "LSP",
                        score_offset = 1000,
                    },
                },
                thesaurus = {
                    name = "blink-cmp-words",
                    module = "blink-cmp-words.thesaurus",
                    -- All available options
                    opts = {
                        -- A score offset applied to returned items.
                        -- By default the highest score is 0 (item 1 has a score of -1, item 2 of -2 etc..).
                        score_offset = 0,

                        -- Default pointers define the lexical relations listed under each definition,
                        -- see Pointer Symbols below.
                        -- Default is as below ("antonyms", "similar to" and "also see").
                        definition_pointers = { "!", "&", "^" },

                        -- The pointers that are considered similar words when using the thesaurus,
                        -- see Pointer Symbols below.
                        -- Default is as below ("similar to", "also see" }
                        similarity_pointers = { "&", "^" },

                        -- The depth of similar words to recurse when collecting synonyms. 1 is similar words,
                        -- 2 is similar words of similar words, etc. Increasing this may slow results.
                        similarity_depth = 2,
                    },
                },
                -- Use the dictionary source
                dictionary = {
                    name = "blink-cmp-words-dic",
                    module = "blink-cmp-words.dictionary",
                    -- All available options
                    opts = {
                        -- The number of characters required to trigger completion.
                        -- Set this higher if completion is slow, 3 is default.
                        dictionary_search_threshold = 3,

                        -- See above
                        score_offset = 0,

                        -- See above
                        definition_pointers = { "!", "&", "^" },
                    },
                },
            },
            per_filetype = {
                text = {"dictionary"},
                markdown = { "thesaurus","buffer", "snippets", },
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

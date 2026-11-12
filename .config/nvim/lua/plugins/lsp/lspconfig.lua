return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim",                   opts = {} },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true }

                opts.desc = "Show LSP references"
                vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

                opts.desc = "Go to declaration"
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

                opts.desc = "Show LSP type definitions"
                vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Smart rename"
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Show line diagnostics"
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Go to previous diagnostic"
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

                opts.desc = "Go to next diagnostic"
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

                opts.desc = "Show documentation for what is under cursor"
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
            end,
        })

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        mason_lspconfig.setup({
            -- default handler for installed servers
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,

            ["lua_ls"] = function()
                -- configure lua server (with special settings)
                lspconfig["lua_ls"].setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            -- make the language server recognize "vim" global
                            diagnostics = {
                                globals = { "vim" },
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                            format = {
                                enable = true,
                                defaultConfig = {
                                    indent_style = "space",
                                    indent_size = "2",
                                }
                            }
                        },
                    },
                })
            end,

            ["tinymist"] = function()
                lspconfig["tinymist"].setup({
                    capabilities = capabilities,
                    single_file_support = true,
                    root_dir = function()
                        return vim.fn.getcwd()
                    end,
                    offset_encoding = "utf-8",
                })
            end,

            ["yamlls"] = function()
                lspconfig["yamlls"].setup({
                    capabilities = capabilities,
                    settings = {
                        yaml = {
                            validate = true,
                            completion = true,
                            hover = true,
                            format = {
                                enable = false,
                            },
                            -- SchemaStore auto-matches schemas for common YAML filenames.
                            schemaStore = {
                                enable = false,
                                url = "https://www.schemastore.org/api/json/catalog.json",
                            },
                            -- Add explicit schema-to-file matches here:
                            schemas = {
                                ['jsonschemas/appendix.json'] = 'config/appendix.yml',
                                ['jsonschemas/certificate.json'] = 'config/certificate.yml',
                                ['jsonschemas/cleanup.json'] = 'results/cleanup.yml',
                                ['jsonschemas/document_layouts.json'] = 'templates/layouts/*.yml',
                                ['jsonschemas/excel_objective_lists_config.json'] =
                                'templates/risk-register/excel_objective_lists_config.yml',
                                ['jsonschemas/excel_risiko_matrix_config.json'] =
                                'templates/risk-register/excel_risiko_matrix_config.yml',
                                ['jsonschemas/excel_risk_register_config.json'] =
                                'templates/risk-register/excel_risk_register_config.yml',
                                ['jsonschemas/excel_system_overview_config.json'] =
                                'templates/risk-register/excel_system_overview_config.yml',
                                ['jsonschemas/excel_title_page_config.json'] =
                                'templates/risk-register/excel_title_page_config.yml',
                                ['jsonschemas/finding.json'] = {
                                    'findings/**/*.yml',
                                    'findings/*.yml',
                                    'templates/findings/**/*.yml',
                                },
                                ['jsonschemas/glossary.json'] = 'templates/report/glossary.yml',
                                ['jsonschemas/groups.json'] = 'config/groups.yml',
                                ['jsonschemas/presentation.json'] = 'config/presentation.yml',
                                ['jsonschemas/project.json'] = 'config/project.yml',
                                ['jsonschemas/reconnaissance.json'] = 'results/reconnaissance.yml',
                                ['jsonschemas/report.json'] = 'config/report.yml',
                                ['jsonschemas/scenario.json'] = {
                                    'scenarios/*/scenario.yml',
                                    'templates/scenarios/*/scenario.yml',
                                },
                                ['jsonschemas/attack_path.json'] = {
                                    'scenarios/*/paths/*.yml',
                                    'templates/scenarios/*/paths/*.yml',
                                },
                                ['jsonschemas/sitemap.json'] = 'results/sitemap.yml',
                                ['jsonschemas/system_overview.json'] = 'results/system_overview.yml',
                            },
                        },
                    },
                })
            end,
        })
    end,
}

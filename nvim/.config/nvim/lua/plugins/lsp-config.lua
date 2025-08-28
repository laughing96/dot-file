return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        },
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        lazy = false,
    },
    {
        "simrat39/rust-tools.nvim",
        config = function()
            require("rust-tools").setup({
                server = {
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = { allFeatures = true },
                            checkOnSave = true,
                            ["checkOnSave.command"] = "clippy",
                            procMacro = { enable = true },
                        },
                    },
                },
            })
            -- local bufnr = vim.api.nvim_get_current_buf()
            --
            -- -- Code actions
            -- vim.keymap.set("n", "<leader>ra", vim.cmd.RustLsp_codeAction, { buffer = bufnr, silent = true })
            --
            -- Hover with Rust tools
            --     vim.keymap.set("n", "K", function()
            --         vim.cmd.RustLsp_hover_actions()
            --     end, { buffer = bufnr, silent = true })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.solargraph.setup({
                capabilities = capabilities,
            })
            lspconfig.html.setup({
                capabilities = capabilities,
            })
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}

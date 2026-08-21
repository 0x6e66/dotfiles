return {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.10.0",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        local treesitter = require("nvim-treesitter")

        treesitter.setup({
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
            ensure_installed = {
                "bash",
                "json",
                "lua",
                "markdown",
                "python",
                "rust",
                "typst",
                "yaml",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    end,
}

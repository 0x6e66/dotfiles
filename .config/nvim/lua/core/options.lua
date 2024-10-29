-- visuals
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.background = "dark"
vim.opt.wrap = false
vim.opt.showmode = true


-- indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true


-- search
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive


-- splits
vim.opt.laststatus = 2
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom


-- undo
vim.opt.undolevels = 1000
vim.opt.undodir = vim.fs.joinpath(vim.fn.stdpath("data"), "undo")
vim.opt.undofile = true
vim.opt.swapfile = false


-- spell checking
vim.opt.spell = true
vim.opt.spelllang = { "en", "de" }
vim.api.nvim_create_autocmd("TermOpen", { pattern = "term://*", command = "setlocal nospell" })


-- lsp
vim.lsp.inlay_hint.enable(true, {})


-- clipboard
vim.opt.clipboard = "unnamedplus"

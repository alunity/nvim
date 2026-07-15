-- opts

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.clipboard = "unnamedplus"
vim.cmd.colorscheme "catppuccin"
vim.opt.directory = vim.fn.stdpath('data') .. '/swap//'
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.exrc = true
vim.g.direnv_silent_load = 1

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic float' })
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { desc = 'Trigger native autocomplete' })
vim.keymap.set('n', '<leader>x', '<cmd>source %<CR>', { desc = 'Source current file' })
vim.keymap.set('n', '<leader>pv', '<cmd>Oil<CR>', { desc = 'file explorer' })

vim.keymap.set('i', '<Tab>', function()
    if vim.fn.pumvisible() == 1 then
        return '<C-n>'
    else
        return '<Tab>'
    end
end, { expr = true, desc = 'Next completion item or Tab' })

vim.keymap.set('i', '<S-Tab>', function()
    if vim.fn.pumvisible() == 1 then
        return '<C-p>'
    else
        return '<S-Tab>'
    end
end, { expr = true, desc = 'Previous completion item or Shift-Tab' })

vim.keymap.set('i', '<CR>', function()
    if vim.fn.pumvisible() == 1 then
        return '<C-y>'
    else
        return '<CR>'
    end
end, { expr = true, desc = 'Accept completion item or Enter' })

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.pack.add({
    'https://github.com/nvim-mini/mini.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/folke/lazydev.nvim',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/catppuccin/nvim',
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/cbochs/grapple.nvim',
    'https://github.com/direnv/direnv.vim'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lua', 'python', 'javascript', 'typescript', 'rust', 'go', 'c' }, -- Add your filetypes here
    callback = function()
        -- Enable syntax highlighting
        vim.treesitter.start()

        -- Enable treesitter-based folding
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'

        -- Enable treesitter-based indentation (experimental)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.opt.foldenable = false -- Keep folds open by default
    end,
})

require("oil").setup()

require('grapple').setup({
    scope = "git",
    icons = false,
})

local grapple = require("grapple")
vim.keymap.set("n", "<leader>a", grapple.toggle, { desc = "Grapple toggle tag" })
vim.keymap.set("n", "<leader>m", grapple.toggle_tags, { desc = "Grapple open tags menu" })
vim.keymap.set("n", "<c-h>", function() grapple.select({ index = 1 }) end, { desc = "Grapple jump 1" })
vim.keymap.set("n", "<c-j>", function() grapple.select({ index = 2 }) end, { desc = "Grapple jump 2" })
vim.keymap.set("n", "<c-k>", function() grapple.select({ index = 3 }) end, { desc = "Grapple jump 3" })
vim.keymap.set("n", "<c-l>", function() grapple.select({ index = 4 }) end, { desc = "Grapple jump 4" })

-- mini

require('mini.ai').setup()
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.statusline').setup()
require('mini.starter').setup()
require('mini.basics').setup()
require('mini.comment').setup()
require('mini.cmdline').setup()
require('mini.diff').setup()
require('mini.notify').setup()
require('mini.git').setup()
require('mini.cursorword').setup()
require('mini.hipatterns').setup()
require('mini.indentscope').setup()
require('mini.tabline').setup()
require('mini.trailspace').setup()
require('mini.completion').setup({
    -- Delay in milliseconds before the menu pops up (lower is faster)
    delay = { completion = 50, info = 100, signature = 50 },

    -- Configure what gets scraped
    lsp_completion = {
        -- Use Neovim's native omnifunc for LSP results
        source_func = 'omnifunc',
        -- Automatically fall back to buffer words if LSP has no results
        auto_setup = true,
    },
})


vim.diagnostic.config({
    -- Show the error message at the end of the line (Virtual Text)
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    -- Make the floating window look a bit nicer
    float = {
        border = 'rounded',
        source = true, -- Shows which LSP sent the error
    },
})

-- fzf

local fzf = require('fzf-lua')
vim.keymap.set('n', '<leader>pf', fzf.files, { desc = 'Fuzzy find files' })
vim.keymap.set('n', '<C-P>', fzf.git_files, { desc = 'Fuzzy find git files' })
vim.keymap.set('n', '<leader>ps', fzf.live_grep, { desc = 'Grep text in project' })
vim.keymap.set('n', '<leader>pb', fzf.buffers, { desc = 'Search active buffers' })

-- lsp

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(args)
        local _ = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        -- Buffer-local LSP keymaps
        local opts = { buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

        vim.keymap.set('n', '<leader>so', '<cmd>FzfLua lsp_document_symbols<CR>',
            { desc = 'Fuzzy find document symbols' })
        vim.keymap.set('n', '<leader>sO', '<cmd>FzfLua lsp_live_workspace_symbols<CR>',
            { desc = 'Fuzzy find workspace symbols' })

        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})

require('lazydev').setup({
    library = {
        -- This explicitly adds Neovim's built-in vim.uv (libuv) types
        { path = "luvit-meta/library", words = { "vim%.uv" } },
    },
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        }
    }
})

vim.lsp.enable('lua_ls')

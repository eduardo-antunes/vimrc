-- Loading external modules:

require 'plugins'
require 'lsp'

local ed = require 'utils'

-- Colorscheme and settings:

ed.set_theme 'tokyonight'

local stdpath = vim.fn.stdpath

ed.set_options {
    mouse          = 'a',
    signcolumn     = 'yes',
    undodir        = stdpath('cache') .. '/undodir',
    scrolloff      = 8,
    tabstop        = 4,
    softtabstop    = 4,
    shiftwidth     = 4,
    exrc           = true,
    hidden         = true,
    errorbells     = false,
    wrap           = false,
    showcmd        = false,
    cursorline     = true,
    number         = true,
    relativenumber = true,
    wildmenu       = true,
    hlsearch       = false,
    expandtab      = true,
    swapfile       = false,
    backup         = false,
    undofile       = true,
    incsearch      = true,
    smartcase      = true,
    ignorecase     = false,
    completeopt    = { 'menu', 'menuone', 'noselect' },
    wildmode       = { 'longest', 'list', 'full'     },
}

-- Key bindings:

ed.set_leader ' '
ed.set_localleader ','

ed.leader_map {
    ['<leader>'] = '<cmd>Telescope file_browser<cr>',
    ['.']        = '<cmd>Telescope find_files<cr>',
    [':']        = '<cmd>Telescope commands<cr>',
    ['b']        = '<cmd>Telescope buffers<cr>',
    ['g']        = '<cmd>Git<cr>',
    ['w']        = '<C-w>',
    ['s']        = ':%s//gc<Left><Left><Left>',
    ['oc']       = '<cmd>vsplit $MYVIMRC<cr>',
    ['ev']       = '<cmd>source %<cr>',
}


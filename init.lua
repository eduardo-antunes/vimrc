-- Loading external modules:

require 'plugins'
require 'lsp'

local ed = require 'utils'

-- Colorscheme and settings:

ed.set_theme 'tokyonight'

local undodir = vim.fn.stdpath('cache') .. '/undodir'

ed.set_options {
    mouse          = 'a',
    signcolumn     = 'yes',
    undodir        = undodir,
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

local cmd = ed.vim_cmd
local pr  = ed.vim_prompt

local tb = require 'telescope.builtin'

ed.leader_map {
    ['<leader>'] = tb.file_browser,
    ['.']        = tb.find_files,
    [':']        = tb.commands,
    ['b']        = tb.buffers,
    ['g']        = cmd 'Git',
    ['of']       = cmd 'CHADopen',
    ['oc']       = cmd 'vsplit $MYVIMRC',
    ['ev']       = cmd 'source %',
    ['G']        = pr 'Git ',
    ['s']        = pr '%s/',
    ['w']        = '<C-w>',
}

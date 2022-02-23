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

local telescope = require 'telescope.builtin'
local file_browser =  
    require 'telescope'.extensions
                       .file_browser
                       .file_browser
local neogit = require 'neogit'

ed.leader_map {
    ['<leader>'] = file_browser,
    ['.']        = telescope.find_files,
    [':']        = telescope.commands,
    ['b']        = telescope.buffers,
    ['ng']       = neogit.open,
    ['g']        = cmd 'Git',
    ['ot']       = cmd 'Ttoggle',
    ['oc']       = cmd 'vsplit $MYVIMRC',
    ['ev']       = cmd 'source %',
    ['q']        = cmd 'lopen',
    ['j']        = cmd 'lnext',
    ['k']        = cmd 'lprev',
    ['G']        = pr 'Git ',
    ['s']        = pr '%s/',
    ['w']        = '<C-w>',
}

ed.bind('n', '<C-q>', cmd 'copen')
ed.bind('n', '<C-j>', cmd 'copen')
ed.bind('n', '<C-k>', cmd 'cprev')


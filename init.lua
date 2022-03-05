-- Loading external modules:

require 'plugins'
require 'lsp'

local ed = require 'utils'

-- Colorscheme and settings:

ed.set_theme 'onedark'

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

local cmd, ex = ed.cmd, ed.ex

local tb = require 'telescope.builtin'
local file_browser = require('telescope')
                        .extensions
                        .file_browser
                        .file_browser

ed.leader_map {
    -- Telescope
    ['<leader>'] = file_browser,
    ['.']        = tb.find_files,
    [':']        = tb.commands,
    ['b']        = tb.buffers,

    -- Terminal
    ['t']        = cmd 'Ttoggle',

    -- Harpoon
    ['H']        = require('harpoon.mark').add_file,
    ['h']        = require('harpoon.ui').toggle_quick_menu,
    ['th']       = require('telescope').extensions.harpoon.marks,

    -- Git
    ['G']        = ex 'Git ',
    ['g']        = cmd 'Git',
    ['ng']       = require('neogit').open,

    -- Configuration
    ['oc']       = cmd 'tabedit $MYVIMRC',
    ['ev']       = cmd 'source %',

    -- Local quickfix list
    ['q']        = cmd 'lopen',
    ['j']        = cmd 'lnext',
    ['k']        = cmd 'lprev',

    -- Others
    ['s']        = ex '%s/',
    ['w']        = '<C-w>',
    ['p']        = '"+p',
}

-- Global quickfix list
ed.bind('n', '<C-q>', cmd 'copen')
ed.bind('n', '<C-j>', cmd 'copen')
ed.bind('n', '<C-k>', cmd 'cprev')


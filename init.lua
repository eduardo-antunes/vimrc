-- Loading external modules:

require 'plugins'
require 'lsp'

local ed = require 'utils'

-- Colorscheme and settings:

vim.g.gruvbox_material_palette = 'original'

ed.set_theme 'github_dark'

local undodir = vim.fn.stdpath 'cache' .. '/undodir'

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
    showmode       = false,
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

local bind, cmd, ex = ed.bind, ed.cmd, ed.ex

local t = require 'telescope.builtin'
local file_browser = require('telescope')
                        .extensions
                        .file_browser
                        .file_browser

local function open_term()
    require('harpoon.term').gotoTerminal(1)
end

ed.leader_map {
    -- Telescope
    ['<leader>'] = file_browser,
    ['.']        = t.find_files,
    [':']        = t.commands,
    ['K']        = t.help_tags,
    ['b']        = t.buffers,

    -- Terminal
    ['ot']        = open_term,

    -- Harpoon
    ['H']        = require('harpoon.mark').add_file,
    ['h']        = require('harpoon.ui').toggle_quick_menu,
    ['th']       = require('telescope').extensions.harpoon.marks,

    -- Git
    ['g']        = ex 'Git ',
    ['ng']       = require('neogit').open,

    -- LSP
    ['ca']       = vim.lsp.buf.code_action,
    ['cd']       = vim.lsp.buf.definition,
    ['cr']       = vim.lsp.buf.rename,

    -- Configuration
    ['oc']       = cmd 'tabedit $MYVIMRC',
    ['ev']       = cmd 'source %',

    -- Local quickfix list
    ['q']        = cmd 'lopen',
    ['j']        = cmd 'lnext',
    ['k']        = cmd 'lprev',

    -- Others
    ['w']        = '<C-w>',
    ['p']        = '"+p',
    ['s']        = ex '%s/',
}

-- Global quickfix list
bind('n', '<C-q>', cmd 'copen')
bind('n', '<C-j>', cmd 'cnext')
bind('n', '<C-k>', cmd 'cprev')

bind('n', 'gd', cmd 'lua vim.lsp.buf.definition')

bind('t', '<esc>', '<C-\\><C-n>')

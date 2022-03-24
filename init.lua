-- Loading external modules:

require 'plugins'
require 'lsp'

local ed = require 'utils'

-- Colorscheme and settings:

vim.g.gruvbox_material_palette = 'original'

ed.set_theme 'onedark'

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
    title          = false,
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

local exec, pr = ed.exec, ed.pr

local t  = require 'telescope.builtin'
local tf = require 'telescope'.extensions.file_browser

ed.leader_map {
    -- Telescope
    ['<leader>'] = tf.file_browser,
    ['.']        = t.find_files,
    [':']        = t.commands,
    ['K']        = t.help_tags,
    ['M']        = t.man_pages,
    ['b']        = t.buffers,

    -- Terminal
    ['ot']        = function() require('harpoon.term').gotoTerminal(1) end,

    -- Harpoon
    ['H']        = require('harpoon.mark').add_file,
    ['h']        = require('harpoon.ui').toggle_quick_menu,
    ['th']       = require('telescope').extensions.harpoon.marks,
    ['1']        = function() require('harpoon.ui').nav_file(1) end,
    ['2']        = function() require('harpoon.ui').nav_file(2) end,
    ['3']        = function() require('harpoon.ui').nav_file(3) end,
    ['4']        = function() require('harpoon.ui').nav_file(4) end,

    -- Git
    ['g']        = pr   'Git ',
    ['G']        = exec 'Git ',
    ['lg']       = exec 'Gclog',
    ['ng']       = require('neogit').open,

    -- LSP
    ['ca']       = vim.lsp.buf.code_action,
    ['cd']       = vim.lsp.buf.definition,
    ['cr']       = vim.lsp.buf.rename,

    -- Configuration
    ['oc']       = exec 'tabedit $MYVIMRC',
    ['ev']       = exec 'source %',

    -- Local quickfix list
    ['q']        = exec 'lopen',
    ['j']        = exec 'lnext',
    ['k']        = exec 'lprev',

    -- Others
    ['w']        = '<C-w>',
    ['p']        = '"+p',
    ['s']        = pr '%s/',
}

ed.normal_map {
    ['gd']    = vim.lsp.buf.definition,
    ['<C-q>'] = exec 'copen',
    ['<C-j>'] = exec 'cnext',
    ['<C-k>'] = exec 'cprev',
}

ed.bind('t', '<esc>', '<C-\\><C-n>')
ed.bind('i', '<tab>', function() require('luasnip').jump(1) end)

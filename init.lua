-- Loading external modules:

require 'plugins'
require 'lsp'

local ed = require 'utils'

-- Colorscheme and settings:

vim.g.gruvbox_material_palette = 'mix'
vim.g.gruvbox_material_statusline_style = 'original'

ed.set_colors 'onedark'

require('statusline').setup()

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

local t = require 'telescope.builtin'

ed.leader_map {

    -- EUNUCH --
    ['ff'] = pr 'Move ',
    ['fr'] = pr 'Rename ',
    ['fD'] = pr 'Mkdir!',
    ['fd'] = exec 'Mkdir!',

    -- TELESCOPE --
    ['.']  = t.find_files,
    [':']  = t.commands,
    ['K']  = t.help_tags,
    ['M']  = t.man_pages,
    ['C']  = t.colorschemes,
    ['b']  = t.buffers,

    -- HARPOON --
    ['H']  = require('harpoon.mark').add_file,
    ['h']  = require('harpoon.ui').toggle_quick_menu,
    ['1']  = function() require('harpoon.ui').nav_file(1) end,
    ['2']  = function() require('harpoon.ui').nav_file(2) end,
    ['3']  = function() require('harpoon.ui').nav_file(3) end,
    ['4']  = function() require('harpoon.ui').nav_file(4) end,
    ['T']  = function() require('harpoon.term').gotoTerminal(1) end,

    -- GIT --
    ['g']  = pr   'Git ',
    ['G']  = exec 'Gclog',
    ['ng'] = require('neogit').open,

    -- LSP --
    ['ca'] = vim.lsp.buf.code_action,
    ['cd'] = vim.lsp.buf.definition,
    ['cr'] = vim.lsp.buf.rename,

    -- VIM --
    ['oc'] = exec 'tabedit $MYVIMRC',
    ['ev'] = exec 'source %',

    -- LOCAL QUICKFIX --
    ['q']  = exec 'lopen',
    ['j']  = exec 'lnext',
    ['k']  = exec 'lprev',

    -- OTHERS --
    ['w']  = '<C-w>',
    ['p']  = '"+p',
    ['s']  = pr '%s/',
}

ed.normal_map {
    ['gd']    = vim.lsp.buf.definition,
    ['<C-q>'] = exec 'copen',
    ['<C-j>'] = exec 'cnext',
    ['<C-k>'] = exec 'cprev',
}

ed.bind('t', '<esc>', '<C-\\><C-n>')
ed.bind('i', '<tab>', function() require('luasnip').jump(1) end)

-- Autocommands

local term = vim.api.nvim_create_augroup('Terminal', { clear = true })
vim.api.nvim_create_autocmd('TermOpen', {
        group = term,
        command = 'setlocal nonumber norelativenumber',
    })

local asm = vim.api.nvim_create_augroup('Assembly', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
        group = asm,
        pattern = '*.asm',
        command = 'set ft=nasm',
    })

local rust = vim.api.nvim_create_augroup('Rust', { clear = true})
vim.api.nvim_create_autocmd('FileType', {
        group = rust,
        pattern = 'rust',
        callback = function ()
            ed.localleader_map {
                ['r'] = exec 'term cargo run',
                ['b'] = exec 'term cargo build',
            }
        end,
    })

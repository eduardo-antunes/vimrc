-- I dedicate any and all copyright interest in this software to the
-- public domain. I make this dedication for the benefit of the public at
-- large and to the detriment of my heirs and successors. I intend this
-- dedication to be an overt act of relinquishment in perpetuity of all
-- present and future rights to this software under copyright law.

-- Loading external modules:

require 'plugins'
require 'lsp'

local ed = require 'utils'

-- Visuals and settings:

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
    hidden         = true,
    exrc           = true,
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

local exec, term, pr = ed.exec, ed.term, ed.pr

local t = require 'telescope.builtin'

ed.leader_map {

    -- General:
    ['e']  = pr 'e %:h/',
    ['r']  = pr 'Rename ',
    ['ff'] = pr 'Move ',
    ['fd'] = pr 'Mkdir ',

    -- Telescope:
    ['.']  = t.find_files,
    [':']  = t.commands,
    ['-']  = t.colorscheme,
    ['K']  = t.help_tags,
    ['M']  = t.man_pages,
    ['b']  = t.buffers,

    -- Harpoon:
    ['H']  = require('harpoon.mark').add_file,
    ['h']  = require('harpoon.ui').toggle_quick_menu,
    ['1']  = function() require('harpoon.ui').nav_file(1) end,
    ['2']  = function() require('harpoon.ui').nav_file(2) end,
    ['3']  = function() require('harpoon.ui').nav_file(3) end,
    ['4']  = function() require('harpoon.ui').nav_file(4) end,
    ['5']  = function() require('harpoon.ui').nav_file(5) end,
    ['T']  = function() require('harpoon.term').gotoTerminal(1) end,
    ['t']  = pr 'term ',

    -- Git:
    ['g']  = pr   'Git ',
    ['G']  = exec 'Gclog',
    ['ng'] = require('neogit').open,

    -- Lsp:
    ['cc'] = vim.diagnostic.open_float,
    ['ca'] = vim.lsp.buf.code_action,
    ['cd'] = vim.lsp.buf.definition,
    ['cr'] = vim.lsp.buf.rename,

    -- Configuration:
    ['oc'] = exec 'tabedit $MYVIMRC',
    ['x']  = exec 'source %',

    -- Local quickfix:
    ['q']  = exec 'lopen',
    ['j']  = exec 'lnext',
    ['k']  = exec 'lprev',

    -- Others:
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

vim.keymap.set('t', '<esc>', '<C-\\><C-n>')
vim.keymap.set('i', '<tab>', function() require('luasnip').jump(1) end)

-- Autocommands

-- I'm not sure why I have to ask for this behavior explicitly
local text = vim.api.nvim_create_augroup('Text', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
        group = text,
        pattern = { '*.txt', 'LICENSE', 'UNLICENSE', 'COPYING' },
        command = 'set ft=text',
    })

local terminal = vim.api.nvim_create_augroup('Terminal', { clear = true })
vim.api.nvim_create_autocmd('TermOpen', {
        group = terminal,
        command = 'setlocal nonumber norelativenumber',
    })

local asm = vim.api.nvim_create_augroup('Assembly', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
        group = asm,
        pattern = '*.asm',
        command = 'set ft=nasm',
    })

local c = vim.api.nvim_create_augroup('C', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
        group = c,
        pattern = 'c',
        callback = function ()
            ed.localleader_map {
                ['b'] = exec 'make',
                ['n'] = term 'ninja -C build',
            }
        end,
    })

local rust = vim.api.nvim_create_augroup('Rust', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
        group = rust,
        pattern = 'rust',
        callback = function ()
            ed.localleader_map {
                ['r'] = pr 'term cargo run ',
                ['c'] = term 'cargo check',
                ['b'] = term 'cargo build',
                ['d'] = term 'cargo doc --open',
                ['t'] = term 'cargo test',
            }
        end,
    })

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
    title          = true,
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

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local exec, term = ed.exec, ed.term

local t = require 'telescope.builtin'

ed.leader_map {

    ['e']  = ':e %:h/',
    [' ']  = t.buffers,
    ['.']  = t.find_files,
    [':']  = t.commands,
    ['K']  = t.help_tags,

    -- Git:
    ['G'] = ':Git ',
    ['g'] = require('neogit').open,

    -- Lsp:
    ['cc'] = vim.diagnostic.open_float,
    ['cd'] = vim.lsp.buf.definition,
    ['cr'] = vim.lsp.buf.rename,
    ['ca'] = t.lsp_code_actions,
    ['cm'] = t.lsp_references,

    -- Local quickfix:
    ['q']  = exec 'lopen',
    ['j']  = exec 'lnext',
    ['k']  = exec 'lprev',

    -- Others:
    ['w']  = '<C-w>',
    ['v']  = '<C-d>',
    ['u']  = '<C-u>',
    ['p']  = '"+p',
    ['s']  = ':%s/',
}

ed.normal_map {
    ['gd']    = vim.lsp.buf.definition,
    ['<C-q>'] = exec 'copen',
    ['<C-j>'] = exec 'cnext',
    ['<C-k>'] = exec 'cprev',
}

vim.keymap.set('t', '<esc>', '<C-\\><C-n>')
vim.keymap.set('i', '<C-n>', function() require('luasnip').jump(1) end)

-- Autocommands

-- I'm not sure why I have to ask for this behavior explicitly
local text = vim.api.nvim_create_augroup('Text', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
        group = text,
        pattern = { '*.txt', 'LICENSE', 'UNLICENSE', 'COPYING' },
        command = 'set ft=text',
    })

local latex = vim.api.nvim_create_augroup('LaTeX', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
        group = latex,
        pattern = '*.tex',
        command = 'set ft=latex'
    })

local asm = vim.api.nvim_create_augroup('Assembly', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
        group = asm,
        pattern = '*.asm',
        command = 'set ft=nasm',
    })

local rust = vim.api.nvim_create_augroup('Rust', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
        group = rust,
        pattern = 'rust',
        callback = function ()
            ed.localleader_map {
                ['r'] = ':term cargo run ',
                ['c'] = term 'cargo check',
                ['b'] = term 'cargo build',
                ['d'] = term 'cargo doc --open',
                ['t'] = term 'cargo test',
            }
        end,
    })

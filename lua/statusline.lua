-- Based on the awesome articles at:
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
-- https://elianiva.my.id/post/neovim-lua-statusline

local this = {}

local fn  = vim.fn
local api = vim.api
local fmt = string.format

-- Tables for later

local mode_symbol = {
  ["n"]  = "NORMAL",
  ["no"] = "NORMAL",
  ["v"]  = "VISUAL",
  ["V"]  = "V-LINE",
  [""] = "V-BLOCK",
  ["s"]  = "SELECT",
  ["S"]  = "S-LINE",
  [""] = "S-BLOCK",
  ["i"]  = "INSERT",
  ["ic"] = "INSERT",
  ["R"]  = "REPLACE",
  ["Rv"] = "V-REPLACE",
  ["c"]  = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"]  = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"]  = "SHELL",
  ["t"]  = "TERMINAL",
}

local lsp_symbol = {
  errors   = '  ',
  warnings = '  ',
  hints    = '  ',
  info     = '  ',
}

-- The statusline can be thought of as being composed of a
-- sequence of modules, where each module displays a
-- particular information. Here, each module is represented
-- by a function that returns a string.

-- The modules I have defined so far are:

-- mode: shows the current mode
-- git: shows git information
-- filepath: shows the filepath
-- file_status: shows the "modifiedness"
-- lsp: shows lsp information
-- filetype: shows the filetype
-- position: self-explanatory

-- There's also a spacing "module" for spacing.

-- The order in which their definitions is presented is of 
-- increasing complexity. The simpler the module, the closer
-- to the top.

local spacing = '%=%#StatusLineExtra#'

local function filetype()
  return fmt(' %s ', vim.bo.filetype:upper())
end

local function mode()
  local current_mode = api.nvim_get_mode().mode
  return fmt(' %s ', mode_symbol[current_mode])
end

local function position()
  if vim.bo.filetype == 'alpha' then
    return ''
  end
  return ' %P  %l:%c '
end

local function file_status()
  if not vim.bo.modifiable or vim.bo.readonly then
    return ' [-] '
  end
  if vim.bo.modified then
    return ' [+] '
  end
  return ''
end

local function filepath()
  local dir = fn.fnamemodify(fn.expand '%', ':~:.:h')
  local name = fn.expand '%:t'

  if dir == '.' then
    return fmt(' %s', name)
  end
  if name == '' then
    return ' '
  end

  return fmt(' %%<%s/%s ', dir, name)
end

-- HERE BE DRAGONS --

-- This one requires gitsigns
local function git()
  local info = vim.b.gitsigns_status_dict

  if not info or info.head == '' then
    return ''
  end

  local added   = info.added   and fmt(' +%s ', info.added)   or ''
  local changed = info.changed and fmt('~%s ' , info.changed) or ''
  local removed = info.removed and fmt('-%s ' , info.removed) or ''

  if info.added   == 0 then added   = '' end
  if info.changed == 0 then changed = '' end
  if info.removed == 0 then removed = '' end

  return table.concat {
    added,
    changed,
    removed,
    '  ',
    info.head,
    ' |'
  }
end

local function lsp()
  local count  = {}
  local levels = { 
    errors   = 'Error', 
    warnings = 'Warn', 
    hints    = 'Hint',
    info     = 'Info', 
  }

  for k, level in pairs(levels) do
    local diagnostics = vim.diagnostic.get(0, { severity = level })
    count[k] = vim.tbl_count(diagnostics)
  end

  local output = ''
  if count.errors ~= 0 then
    output = output .. lsp_sym.errors .. count.errors
  end
  if count.warnings ~= 0 then
    output = output .. lsp_sym.warnings .. count.warnings
  end
  if count.hints ~= 0 then
    output = output .. lsp_sym.hints .. count.hints
  end
  if count.info ~= 0 then
    output = output .. lsp_sym.info .. count.info
  end

  return output
end

-- The statusline can be in one of two states: active or
-- inactive. Each one of them is represented by a function
-- that simply concatenates the outputs of the desired
-- modules.

function this.active()
  return table.concat {
    mode(),
    git(),
    filepath(),
    file_status(),
    lsp(),
    spacing,
    filetype(),
    position(),
  }
end

function this.inactive()
  return table.concat {
    filepath(),
    file_status(),
  }
end

function this.setup()
  vim.cmd [[
    augroup Statusline
    au!
    au WinEnter,BufEnter * setlocal statusline=%!v:lua.require'statusline'.active()
    au WinLeave,BufLeave * setlocal statusline=%!v:lua.require'statusline'.inactive()
    augroup END
  ]]
end

return this

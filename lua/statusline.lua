-- I dedicate any and all copyright interest in this software to the
-- public domain. I make this dedication for the benefit of the public at
-- large and to the detriment of my heirs and successors. I intend this
-- dedication to be an overt act of relinquishment in perpetuity of all
-- present and future rights to this software under copyright law.

-- Based on the awesome article at:
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html

local this = {}

local fmt = string.format

-- Tables for later

local mode_sym = {
  ['n']  = 'NORMAL',
  ['no'] = 'NORMAL',
  ['nt'] = 'NORMAL',
  ['v']  = 'VISUAL',
  ['V']  = 'V-LINE',
  [''] = 'V-BLOCK',
  ['s']  = 'SELECT',
  ['S']  = 'S-LINE',
  [''] = 'S-BLOCK',
  ['i']  = 'INSERT',
  ['ic'] = 'INSERT',
  ['R']  = 'REPLACE',
  ['Rv'] = 'V-REPLACE',
  ['c']  = 'COMMAND',
  ['cv'] = 'VIM EX',
  ['ce'] = 'EX',
  ['r']  = 'PROMPT',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!']  = 'SHELL',
  ['t']  = 'TERMINAL',
}

local lsp_sym = {
  errors   = ' E',
  warnings = ' W',
  hints    = ' H',
  info     = ' I',
}

-- The statusline can be thought of as being composed of a
-- sequence of modules, where each module displays a
-- particular information. Here, each module is represented
-- by a function that returns a string.

-- The modules I have defined so far are:

-- mode: shows the current mode
-- git: shows git information
-- filepath: shows the filepath
-- file_status: shows the buffer's status
-- lsp: shows lsp information
-- filetype: shows the filetype
-- position: self-explanatory

-- The order in which their definitions is presented is of 
-- increasing complexity. The simpler the module, the closer
-- to the top.

local spacer = '%=%#StatusLineExtra#'

local function filetype()
  return fmt(' %s ', vim.bo.filetype)
end

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return fmt(' %s |', mode_sym[current_mode])
end

local function git()
  local branch = vim.fn.system { 'git', 'symbolic-ref', '--short', 'HEAD' }
  if branch:find('^fatal: not a git repository') then return '' end
  return fmt(' git: %s |', branch:gsub('%s+', ''))
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
  local dir = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.:h')
  local name = vim.fn.expand '%:t'

  if dir == '.' then
    return fmt(' %s', name)
  end
  if name == '' then
    return ' '
  end

  return fmt(' %%<%s/%s ', dir, name)
end

-- HERE BE DRAGONS --

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
    spacer,
    filetype(),
    position(),
  }
end

function this.inactive()
  return ' %F'
end

function this.setup()
  local augroup = vim.api.nvim_create_augroup('StatusLine', { clear = true })
  vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
      group = augroup,
      command = "setlocal statusline=%!v:lua.require'statusline'.active()",
    })
  vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
      group = augroup,
      command = "setlocal statusline=%!v:lua.require'statusline'.inactive()",
    })

end

return this

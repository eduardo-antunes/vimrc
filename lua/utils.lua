local this = {}

-- Setting options:

function this.set_options(options)
  for option, value in pairs(options) do
    vim.opt[option] = value
  end
end

-- Visuals:

function this.set_theme(theme)
  vim.opt.termguicolors = true
  vim.cmd('colors ' .. theme)
end

-- Key binding:

this.bound_functions = {}
this.bound_count = 1

function this.bind(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  if type(rhs) == 'string' then
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  else
    this.bound_functions[this.bound_count] = rhs
    local func_rhs = 
    '<cmd>lua require("utils").bound_functions[' 
    .. this.bound_count .. 
    ']()<cr>'
    this.bound_count = this.bound_count + 1
    vim.api.nvim_set_keymap(mode, lhs, func_rhs, options)
  end
end

function this.map(mode, bindings, prefix)
  for lhs, rhs in pairs(bindings) do
    this.bind(mode, prefix .. lhs, rhs)
  end
end

-- Convenience and readability:

function this.set_leader(leader)
  vim.g.mapleader = leader
end

function this.set_localleader(localleader)
  vim.g.maplocalleader = localleader
end

function this.normal_map(bindings)
  this.map('n', bindings, '')
end

function this.leader_map(bindings)
  this.map('n', bindings, '<leader>')
end

function this.exec(string)
  return '<cmd>' .. string .. '<cr>'
end

function this.pr(string)
  return ':' .. string
end
      
return this

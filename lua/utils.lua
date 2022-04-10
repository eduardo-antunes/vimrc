local this = {}

-- This module is basically where I dump all of my ugly
-- code so that I don't have to see it in the main
-- config files.

-- Setting options:

function this.set_options(options)
  for option, value in pairs(options) do
    vim.opt[option] = value
  end
end

-- Visuals:

function this.set_colors(scheme)
  vim.opt.termguicolors = true
  vim.cmd('colors ' .. scheme)
end

-- Package management

function this.packer_bootstrap()
  local prefix = vim.fn.stdpath('data')
  local path = '/site/pack/packer/start/packer.nvim'
  local url = 'https://github.com/wbthomason/packer.nvim'

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    local result = vim.fn.system {
      'git', 'clone', '--depth', '1', url, prefix .. path
    }
  end
  return result
end

-- Key binding:

this.bound_functions = {}
this.bound_count = 1

function this.bind(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  if type(rhs) == 'string' then
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  else
    this.bound_functions[this.bound_count] = rhs
    local func_rhs = string.format(
      '<cmd>lua require("utils").bound_functions[%s]()<cr>',
      this.bound_count
      )
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

function this.localleader_map(bindings)
  this.map('n', bindings, '<localleader>')
end

function this.exec(str)
  return string.format('<cmd>%s<cr>', str)
end

function this.term(str)
  return string.format('<cmd>vertical term %s<cr>', str)
end

function this.pr(str)
  return string.format(':%s', str)
end
      
return this

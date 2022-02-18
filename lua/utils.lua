local this = {}

-- Option setting:

function this.set_options(options)
  for option, value in pairs(options) do
    vim.opt[option] = value
  end
end

-- Visual configuring:

function this.set_theme(theme)
  vim.opt.termguicolors = true
  vim.cmd('colors ' .. theme)
  require('lualine').setup {
    options = {
      theme = theme,
    },
    sections = {
      lualine_x = {'filetype'},
    },
  }
end

-- Key binding:

this.bound_functions = {}
this.bound_count = 1

function this.set_leader(leader)
  vim.g.mapleader = leader
end

function this.set_localleader(localleader)
  vim.g.maplocalleader = localleader
end

function this.bind(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function this.leader_map(bindings)
  for lhs, rhs in pairs(bindings) do
    if type(rhs) == 'string' then
      this.bind('n', '<leader>' .. lhs, rhs)
    else
      this.bound_functions[this.bound_count] = rhs
      local func_rhs = 
        '<cmd>lua require("utils").bound_functions[' 
        .. this.bound_count .. 
        ']()<cr>'
      this.bound_count = this.bound_count + 1
      this.bind('n', '<leader>' .. lhs, func_rhs)
    end
  end
end

-- Convenience and readability:

function this.vim_cmd(string)
  return '<cmd>' .. string .. '<cr>'
end

function this.vim_prompt(string)
  return ':' .. string
end
      
return this

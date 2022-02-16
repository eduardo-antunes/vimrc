local this = {}

-- Option setting:

function this.set_options(options)
  for option, value in pairs(options) do
    vim.opt[option] = value
  end
end

-- Theme setting:

function this.set_theme(theme)
  vim.opt.termguicolors = true
  vim.cmd('colors ' .. theme)
  require('lualine').setup {
    options = {
      theme = theme,
    }
  }
end

-- Key binding:

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
    this.bind('n', vim.g.mapleader .. lhs, rhs)
  end
end
      
return this


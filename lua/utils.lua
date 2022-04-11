-- I dedicate any and all copyright interest in this software to the
-- public domain. I make this dedication for the benefit of the public at
-- large and to the detriment of my heirs and successors. I intend this
-- dedication to be an overt act of relinquishment in perpetuity of all
-- present and future rights to this software under copyright law.

local this = {}

-- Setting options:

function this.set_options(options)
  for option, value in pairs(options) do
    vim.opt[option] = value
  end
end

-- Bindings keys:

function this.map(mode, bindings, prefix)
  for lhs, rhs in pairs(bindings) do
    vim.keymap.set(mode, prefix .. lhs, rhs)
  end
end

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

-- Readability:

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

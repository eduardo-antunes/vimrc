-- I dedicate any and all copyright interest in this software to the
-- public domain. I make this dedication for the benefit of the public at
-- large and to the detriment of my heirs and successors. I intend this
-- dedication to be an overt act of relinquishment in perpetuity of all
-- present and future rights to this software under copyright law.

-- Autocomplete + lsp setup:

local cmp = require 'cmp'

cmp.setup {
  mapping = {
    ['<Tab>']     = cmp.mapping(cmp.mapping.select_next_item()),
    ['<S-Tab>']   = cmp.mapping(cmp.mapping.select_prev_item()),
    ['<C-b>']     = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>']     = cmp.mapping(cmp.mapping.scroll_docs(4),  { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(),      { 'i', 'c' }),
    ['<C-y>']     = cmp.config.disable,
    ['<C-e>']     = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ['<cr>'] = cmp.mapping.confirm { select = false },
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'buffer'   },
    { name = 'luasnip'  },
  },
}

local defaults = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').update_capabilities(defaults)

-- Actual lsp setup:

local lspconf = require 'lspconfig'

local my_servers = { 'clangd', 'rust_analyzer', 'pyright' }

for _, server in pairs(my_servers) do
  lspconf[server].setup {
    capabilities = capabilities,
  }
end

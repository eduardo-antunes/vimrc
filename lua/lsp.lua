-- Autocompletion + lsp setup:

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
    ['<cr>'] = cmp.mapping.confirm({ select = false }),
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'buffer'   },
  },
}

local defaults = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').update_capabilities(defaults)

-- Actual lsp setup:

local lspconf = require 'lspconfig'

local my_servers = { 'clangd', 'pyright' }

for _, server in pairs(my_servers) do
  lspconf[server].setup {
    capabilities = capabilities,
  }
end

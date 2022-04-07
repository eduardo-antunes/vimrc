vim.cmd 'packadd packer.nvim'

-- Plugin declaration:

require('packer').startup(function ()

  -- Meta:

  use 'wbthomason/packer.nvim'

  -- General:

  use 'windwp/nvim-autopairs' -- electric pairs for neovim

  use 'tpope/vim-surround' -- cool surround motions

  use 'tpope/vim-eunuch' -- simple, but effective file management

  use 'ThePrimeagen/harpoon' -- fast file switching

  -- fuzzy finding
  use { 
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- fuzzy finding meets native speed
  use { 
    'nvim-telescope/telescope-fzf-native.nvim', 
    requires = 'nvim-telescope/telescope.nvim',
    run = 'make',
  }

  -- Colorschemes:

  use 'navarasu/onedark.nvim'

  use 'tanvirtin/monokai.nvim'

  use 'sainnhe/gruvbox-material'

  use 'projekt0n/github-nvim-theme'

  -- Git:

  use 'lewis6991/gitsigns.nvim' -- git integration for buffers

  use 'tpope/vim-fugitive' -- simple, but effective git

  -- magit for neovim
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- Programming support:

  use 'sheerun/vim-polyglot' -- better language support

  use 'tpope/vim-commentary' -- comment and uncomment fast

  use 'neovim/nvim-lspconfig' -- configure neovim's native lsp easily

  use 'sakhnik/nvim-gdb' -- debugger integration

  use 'hrsh7th/nvim-cmp' -- autocomplete system

  use 'L3MON4D3/LuaSnip' -- snippet system

  use 'saadparwaiz1/cmp_luasnip' -- snippets meet autcompletion

  -- autocomplete sources
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  use 'rafamadriz/friendly-snippets' -- snippet source

  -- fuzzy finder + lsp integration
  use {
    'gbrlsnchs/telescope-lsp-handlers.nvim',
    requires = 'nvim-telescope/telescope.nvim',
  }

  -- crispier syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }

end)

-- Plugin configuration:

require('nvim-autopairs').setup()
require('gitsigns').setup()

local t = require 'telescope'
t.load_extension  'lsp_handlers'
t.load_extension  'fzf'

require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = { enable = true },
}

require('luasnip.loaders.from_vscode').lazy_load()

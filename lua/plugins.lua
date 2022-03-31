vim.cmd 'packadd packer.nvim'

-- Plugin declaration:

require('packer').startup(function ()

  -- packer can take care of itself
  use 'wbthomason/packer.nvim'

  -- vim polyglot for better language support
  use 'sheerun/vim-polyglot'

  -- eletric-pairs for neovim
  use 'windwp/nvim-autopairs'

  -- one dark theme
  use 'navarasu/onedark.nvim'

  -- lualine
  use 'nvim-lualine/lualine.nvim'

  -- pretty icons
  use 'kyazdani42/nvim-web-devicons'

  -- comment and uncomment fast
  use 'tpope/vim-commentary'

  -- surround motions for convenience
  use 'tpope/vim-surround'

  -- git integration for buffers
  use 'lewis6991/gitsigns.nvim'

  -- a git wrapper so awesome it should be illegal
  use 'tpope/vim-fugitive'

  -- neogit for quick git operations
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- harpoon > marks
  use 'ThePrimeagen/harpoon'

  -- telescope for fuzzy finding
  use { 
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- file browser built on telescope
  use {
    'nvim-telescope/telescope-file-browser.nvim',
    requires = 'nvim-telescope/telescope.nvim',
  }

  -- grants telescope the gift of native speed
  use { 
    'nvim-telescope/telescope-fzf-native.nvim', 
    requires = 'nvim-telescope/telescope.nvim',
    run = 'make',
  }

  -- improves upon telescopes's lsp integration
  use {
    'gbrlsnchs/telescope-lsp-handlers.nvim',
    requires = 'nvim-telescope/telescope.nvim',
  }

  -- tree-sitter configuration
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }

  -- lsp configuration
  use 'neovim/nvim-lspconfig'

  -- debugging stuff
  use 'sakhnik/nvim-gdb'

  -- autocomplete system
  use 'hrsh7th/nvim-cmp'

  -- autocomplete sources
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- snippet engine
  use 'L3MON4D3/LuaSnip'

  -- snippets meet autocomplete
  use 'saadparwaiz1/cmp_luasnip'

  -- collection of pre-made snippets
  use 'rafamadriz/friendly-snippets'

end)

-- Plugin configuration:

require('nvim-autopairs').setup()
require('gitsigns').setup()

local t = require 'telescope'
t.load_extension  'file_browser'
t.load_extension  'fzf'
t.load_extension  'lsp_handlers'

require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = { enable = true },
}

require('luasnip.loaders.from_vscode').lazy_load()

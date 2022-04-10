local bootstrap = require('utils').packer_bootstrap()

return require('packer').startup(function()

  -- Meta:

  use 'wbthomason/packer.nvim'

  -- General:

  use 'tpope/vim-surround' -- cool surround motions

  use 'tpope/vim-eunuch' -- simple, but effective file management

  use 'ThePrimeagen/harpoon' -- fast file switching

  -- electric pairs for neovim
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  }

  -- fuzzy finding
  use { 
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- fuzzy finding meets native speed
  use { 
    'nvim-telescope/telescope-fzf-native.nvim', 
    requires = 'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').load_extension 'fzf'
    end,
    run = 'make',
  }

  -- Colorschemes:

  use 'navarasu/onedark.nvim'

  use 'sainnhe/gruvbox-material'

  use 'drewtempelmeyer/palenight.vim'

  -- Git:

  use 'tpope/vim-fugitive' -- simple, but effective git

  -- git integration for buffers
  use { 
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  }

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

  -- snippet system
  use { 
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  }

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
    config = function()
      require('telescope').load_extension 'lsp_handlers'
    end,
  }

  -- crispier syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = 'maintained',
        highlight = { enable = true },
      }
    end,
  }

  if bootstrap then
    require('packer').sync()
  end
end)

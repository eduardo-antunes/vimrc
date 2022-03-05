vim.cmd 'packadd packer.nvim'

-- Plugin declarations:

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

  -- tpope
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'

  -- neogit for quick git operations
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- wrapper for the builtin terminal
  use 'kassio/neoterm'

  -- harpoon > marks
  use 'ThePrimeagen/harpoon'

  -- telescope for fuzzy finding
  use { 
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- file browser built on telescope
  use 'nvim-telescope/telescope-file-browser.nvim'

  -- grants telescope the gift of native speed
  use { 
    'nvim-telescope/telescope-fzf-native.nvim', 
    run = 'make',
  }

  -- tree-sitter configuration
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }

  -- lsp configuration
  use 'neovim/nvim-lspconfig'

  -- autocomplete system
  use 'hrsh7th/nvim-cmp'

  -- autocomplete sources
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

end)

-- Plugin configuration:

vim.g.neoterm_size = '10'
vim.g.neoterm_default_mod = 'botright'

require('nvim-autopairs').setup()

local t = require 'telescope'
t.load_extension 'file_browser'
t.load_extension 'harpoon'
t.load_extension 'fzf'

require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = { enable = true },
  indent    = { enable = true },
}

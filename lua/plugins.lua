vim.cmd 'packadd packer.nvim'

-- Plugin declarations:

require('packer').startup(function ()

  -- packer can take care of itself
  use 'wbthomason/packer.nvim'

  -- vim polyglot for better language support
  use 'sheerun/vim-polyglot'

  -- eletric-pairs for neovim
  use 'windwp/nvim-autopairs'

  -- tokyonight theme
  use 'folke/tokyonight.nvim'

  -- dracula theme
  use 'Mofiqul/dracula.nvim'

  -- onenord theme
  use 'rmehri01/onenord.nvim'

  -- lualine
  use 'nvim-lualine/lualine.nvim'

  -- tpope
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'

  -- pretty icons
  use 'kyazdani42/nvim-web-devicons'

  -- Telescope fuzzy finder
  use { 
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- Telescope extensions
  use 'nvim-telescope/telescope-file-browser.nvim'

  use { 
    'nvim-telescope/telescope-fzf-native.nvim', 
    run = 'make',
  }

  -- File manager
  use {
    'ms-jpq/chadtree',
    branch = 'chad',
    run = ':CHADdeps',
  }

  -- lsp configuration
  use 'neovim/nvim-lspconfig'

  -- autocomplete system
  use 'hrsh7th/nvim-cmp'

  -- autocomplete sources
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- tree-sitter configuration
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
    }

end)

-- Plugin configurations:

require('nvim-autopairs').setup()

require('telescope').setup()
require('telescope').load_extension 'file_browser'
require('telescope').load_extension 'fzf'

require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
  }
}

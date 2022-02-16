vim.cmd "packadd packer.nvim"

require("packer").startup(function ()
  -- packer can take care of itself
  use "wbthomason/packer.nvim"

  -- vim polyglot for better language support
  use "sheerun/vim-polyglot"

  -- eletric-pairs for neovim
  use "windwp/nvim-autopairs"

  -- everforest theme
  use "sainnhe/everforest"

  -- nord theme
  use "arcticicestudio/nord-vim"

  -- dracula theme
  use "dracula/vim"

  -- tokyonight theme
  use "folke/tokyonight.nvim"

  -- lualine
  use "nvim-lualine/lualine.nvim"

  -- tpope
  use "tpope/vim-commentary"
  use "tpope/vim-fugitive"
  use "tpope/vim-surround"

  -- pretty icons
  use "kyazdani42/nvim-web-devicons"

  -- Telescope fuzzy finder
  use { 
    "nvim-telescope/telescope.nvim",
    requires = "nvim-lua/plenary.nvim",
  }

  use "nvim-telescope/telescope-file-browser.nvim"

  -- lsp configuration
  use "neovim/nvim-lspconfig"

  -- autocomplete system
  use "hrsh7th/nvim-cmp"

  -- autocomplete sources
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"

  -- tree-sitter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }

end)

require("nvim-autopairs").setup()

require("telescope").load_extension "file_browser"


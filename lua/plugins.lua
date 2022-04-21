-- I dedicate any and all copyright interest in this software to the
-- public domain. I make this dedication for the benefit of the public at
-- large and to the detriment of my heirs and successors. I intend this
-- dedication to be an overt act of relinquishment in perpetuity of all
-- present and future rights to this software under copyright law.

local bootstrap = require('utils').ensure_packer()

return require('packer').startup(function ()

  -- Meta:

  use 'wbthomason/packer.nvim'

  -- General:

  use 'tpope/vim-surround' -- cool surround motions

  use 'tpope/vim-eunuch' -- simple, but effective file management

  use 'ThePrimeagen/harpoon' -- fast file switching

  -- pretty colors
  use { 
    'navarasu/onedark.nvim',
    config = function ()
      require('onedark').setup {
        style = 'darker',
        toggle_style_key = '<leader>Ts',
      }
      require('onedark').load()
    end,
  }

  -- electric pairs for neovim
  use {
    'windwp/nvim-autopairs',
    config = function ()
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
    config = function ()
      require('telescope').load_extension 'fzf'
    end,
    run = 'make',
  }

  -- Git:

  use 'tpope/vim-fugitive'

  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
  }

  -- Programming support:

  use 'sheerun/vim-polyglot' -- better language support

  use 'b3nj5m1n/kommentary' -- comment and uncomment fast

  use 'neovim/nvim-lspconfig' -- configure neovim's native lsp easily

  use 'sakhnik/nvim-gdb' -- debugger integration

  -- crispier syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function ()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 
          'lua', 'c', 'cpp', 'make', 'python', 'bash', 
          'latex', 'markdown', 'rust', 'toml', 'vim',
          'html',
        },
        highlight = { enable = true },
      }
    end,
  }

  -- autocomplete and snippets
  use { 
    'hrsh7th/nvim-cmp',
    requires = {
      -- autocomplete sources
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      -- snippet system and source
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      -- autocomplete source for snippets
      'saadparwaiz1/cmp_luasnip',
    },
    config = function ()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  }

  if bootstrap then
    require('packer').sync()
  end
end)

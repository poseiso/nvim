-- Check for err
local ok, packer = pcall(require, "packer")
if not ok then
  print("Packer broke :kusapeko:")
  return
end


return packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use "nvim-lua/plenary.nvim"

  -- QoL
  use "windwp/nvim-autopairs"
  use "numToStr/Comment.nvim"
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use 'psliwka/vim-smoothie'

  -- Lang
  use 'simrat39/rust-tools.nvim'

  use 'habamax/vim-godot'
  use 'clktmr/vim-gdscript3'

  use 'akinsho/flutter-tools.nvim'
  use 'dart-lang/dart-vim-plugin'

  -- Colorschemes
  use "sainnhe/everforest"

  -- cmp 
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use "jose-elias-alvarez/null-ls.nvim"
  use "RRethy/vim-illuminate"

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use "nvim-treesitter/nvim-treesitter"
end)

-- Check for err
local ok, packer = pcall(require, "packer")
if not ok then
  print("Packer broke :kusapeko:")
  return
end


return packer.startup(function(use)
  use "wbthomason/packer.nvim"

  -- Some sort of script extender
  -- Used a lot by other plugins
  use "nvim-lua/plenary.nvim"

  -- QoL
  use "windwp/nvim-autopairs"
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use 'psliwka/vim-smoothie'
  use 'skywind3000/asyncrun.vim'

  -- Lang
  use 'habamax/vim-godot'
  use 'clktmr/vim-gdscript3'

  use 'akinsho/flutter-tools.nvim'
  use 'dart-lang/dart-vim-plugin'

  -- Colorschemes
  use "sainnhe/everforest"

  -- cmp 
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lua"


  -- snippets
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "rafamadriz/friendly-snippets"

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "RRethy/vim-illuminate"

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use "nvim-treesitter/nvim-treesitter"

  -- wakatime
  use 'wakatime/vim-wakatime'

  -- Diff
  use "sindrets/diffview.nvim"


  -- Dad Plugin
  use "ThePrimeagen/harpoon"
end)


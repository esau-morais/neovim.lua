local status, packer = pcall(require, 'packer')
if (not status) then
  print('Packer is not installed')
  return
end

packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- useins manager

  use { 'catppuccin/nvim', as = 'catppuccin' }
  use 'mrshmllow/document-color.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'sheerun/vim-polyglot'
  use 'nvim-tree/nvim-web-devicons' -- icons
  use 'nvim-lua/plenary.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'kdheepak/lazygit.nvim'

  use 'nvim-lualine/lualine.nvim' -- Statusline
  use {
    'akinsho/bufferline.nvim',
    requires = 'nvim-tree/nvim-web-devicons'
  }

  use 'numToStr/Comment.nvim'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'

  -- file explorer
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    },
    tag = 'nightly'
  }
  use 'akinsho/toggleterm.nvim'

  -- lsp
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use 'onsails/lspkind-nvim'
  use 'glepnir/lspsaga.nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  -- auto completion
  use 'rafamadriz/friendly-snippets'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use({
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
  })
  use 'folke/zen-mode.nvim'
  use 'pantharshit00/vim-prisma'
  use 'ThePrimeagen/vim-be-good'
  use 'mfussenegger/nvim-dap'

  -- automatically sync packages
  if packer_bootstrap then
    packer.sync()
  end
end)

vim.api.nvim_exec(
  [[
  augroup packer_ide_config
  autocmd!
  autocmd BufWritePost useins.lua source <afile> | PackerSync
  augroup end
]] ,
  false
)

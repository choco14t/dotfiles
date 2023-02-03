local ok, packer = pcall(require, "packer")
if not ok then
  print("Packer is not installed")
  return
end

vim.cmd.packadd("packer.nvim")

require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  local colorscheme = "nightfox.nvim"
  use({
	  "EdenEast/nightfox.nvim",
	  config = function()
      vim.cmd.colorscheme("nightfox")
	  end,
  })

  use {
	  "nvim-telescope/telescope.nvim", tag = "0.1.1",
	  after = { colorscheme },
	  requires = { {"nvim-lua/plenary.nvim"} }
  }

  use({
	  "nvim-treesitter/nvim-treesitter",
	  after = { colorscheme },
	  run = ":TSUpdate",
  })

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    }
  }

  use("folke/zen-mode.nvim")
  use("mbbill/undotree")
  use("nvim-tree/nvim-web-devicons")

end)


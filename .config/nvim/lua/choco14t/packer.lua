local ok, packer = pcall(require, "packer")
if not ok then
	print("Packer is not installed")
	return
end

vim.cmd.packadd("packer.nvim")

packer.startup(function(use)
  use "wbthomason/packer.nvim"

  local colorscheme = "nightfox.nvim"
  use({
	  "EdenEast/nightfox.nvim",
	  event = { "VimEnter", "ColorSchemePre" },
	  config = function()
		  require("after/plugin/nightfox")
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

  use "folke/zen-mode.nvim"

end)

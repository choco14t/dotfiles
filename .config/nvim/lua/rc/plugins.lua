local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) == 1 then
  vim.api.nvim_command('silent !git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[packadd packer.nvim]]
vim.cmd [[autocmd BufWritePost .config/nvim/lua/rc/plugins.lua,.config/nvim/rc/config/*.lua PackerCompile]]

return require('packer').startup(function()
  use({ 'wbthomason/packer.nvim', opt = true })

  use({ 'nvim-lua/plenary.nvim' })

  -- color scheme
  local colorscheme = 'nightfox.nvim'
  use({
    'EdenEast/nightfox.nvim',
    event = { 'VimEnter', 'ColorSchemePre' },
    config = function()
      require('rc/config/nightfox')
    end,
  })

  -- icon
  if not os.getenv('DISABLE_DEVICONS') or os.getenv('DISABLE_DEVICONS') == 'false' then
    use({ 'kyazdani42/nvim-web-devicons', after = colorscheme })
  end

  use({
    'nvim-telescope/telescope.nvim',
    after = { colorscheme },
    config = function()
      require('rc/config/telescope')
    end,
  })

  use({
    'nvim-treesitter/nvim-treesitter',
    after = { colorscheme },
    run = ':TSUpdate',
  })

  use 'nvim-telescope/telescope-file-browser.nvim'
end)

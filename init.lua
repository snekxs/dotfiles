-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.number = true
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
})


-- Setup lazy.nvim
require("lazy").setup({
  spec = {
   {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
},{'vyfor/cord.nvim'},{"baliestri/aura-theme",config = function(plugin)
    vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
    vim.cmd([[colorscheme aura-dark]])
  end},{"webhooked/kanso.nvim"},{"mason-org/mason.nvim"},{"saghen/blink.cmp",version="*"},{"mason-org/mason-lspconfig.nvim"},{
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
},{"neovim/nvim-lspconfig"},
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = {  },
  -- automatically check for plugin updates
  checker = { enabled = true },
  }})

require('lualine').setup{options = { theme = 'iceberg_dark'}}
vim.cmd[[colorscheme aura-dark]]
require('cord').setup {{enabled=true},display={theme='catppuccin',flavor='accent'}}
require("mason").setup()
require("mason-lspconfig").setup()
require("blink.cmp").setup({
  keymap = { preset = "enter" }, -- Tab to cycle, Enter to confirm like VS Code
})

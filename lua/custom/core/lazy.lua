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

-- Setup lazy.nvim
require("lazy").setup({
  spec = require("custom.plugins").plugins,
  install = { colorscheme = { "tokyonight" } },
  checker = {
    enabled = function()
      local now = os.date("*t")
      local minutes = now.hour * 60 + now.min
      return minutes >= 1 and minutes <= (7 * 60 + 59)
    end,
    notify = false,
  },
  git = {
    throttle = {
      enabled = true,
    },
  },
  rocks = { enabled = false },
  change_detection = {
    enabled = true,
    notify = false,
  },
})

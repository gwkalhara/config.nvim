local options = {
  backup = false, -- creates a backup file
  -- INFO: special behaviour will be implemented when using  `obsidian.nvim`
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  spelllang = "en_us",
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  smartcase = true, -- smart case
  mouse = "", -- disable mouse
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  scrolloff = 8, -- is one of my fav
  sidescrolloff = 8,
  guifont = "CaskaydiaCove NF:h17", -- the font used in graphical neovim applications
  winbar = "%t %m {%L} | %F",
  foldmethod = "expr",
  foldexpr = "v:lua.vim.treesitter.foldexpr()",
  foldlevel = 99,
}

-- INFO: Config shown in helpdocs to use Powershell as terminal shell
vim.cmd([[let &shell = executable('pwsh') ? 'pwsh' : 'powershell']])
vim.cmd(
  [[let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;']]
)
vim.cmd([[let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode']])
vim.cmd([[let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode']])
vim.cmd([[set shellquote= shellxquote=]])

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- white spaces display
-- works together with the `CcmdToggleWhitespace` command
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"

vim.g.python3_host_prog = "C:/Users/Hp/.venvs/nvim/Scripts/python.exe"
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]])

-- INFO: custom commands
vim.api.nvim_create_user_command("CCmdFormatBuffer", function()
  require("conform").format()
end, { desc = "Format buffer with conform" })

vim.api.nvim_create_user_command("CcmdToggleWhitespace", function()
  ---@diagnostic disable-next-line: undefined-field
  vim.opt.list = not vim.opt.list:get()
end, {})

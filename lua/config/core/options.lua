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
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
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
}

-- INFO: Config shown in helpdocs to use Powershell as terminal shell
vim.cmd([[let &shell = executable('pwsh') ? 'pwsh' : 'powershell']])
vim.cmd(
  [[let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;']]
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

-- BUG: the view works, but the behavior is abnormal
vim.cmd("let g:netrw_liststyle = 3") -- set netrw to tree view

vim.g.python3_host_prog = "C:/Users/Hp/miniconda3/python.exe"
vim.g.loaded_perl_provider = 0

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]])

vim.fn.setreg("g", [[s/\(\u\w\+\)\s\+\(\w\+\)/\1 \2 `json:"\l\1"`]])

-- INFO: custom commands
vim.api.nvim_create_user_command("CCmdFormatBuffer", function()
  require("conform").format()
end, { desc = "Format buffer with conform" })

vim.api.nvim_create_user_command("CCmdWingetFormat", function()
  -- delete unwanted app entries first
  vim.cmd([[g/libreoffice/d _]])
  vim.cmd([[g/teamviewer/d _]])
  vim.cmd([[g/java/d _]])
  vim.cmd([[g/edge/d _]])
  vim.cmd([[g/Miniconda3/d _]])
  vim.cmd([[g/app installer/d _]])
  vim.cmd([[g/sql/d _]])
  vim.cmd([[g/bonjour/d _]])

  -- perform the formatting with globals and substitutions
  vim.cmd("/---")
  vim.cmd("normal! dgg")
  vim.cmd("normal G")
  vim.cmd("normal! dk")
  vim.cmd("%s/…/ /g")
  vim.cmd([[/\w\+\ \w\+\ \ \ ]])
  vim.cmd("normal WW")
  vim.cmd("normal Gh")
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-v>", true, false, true), "n", true)

  -- Delay moving the cursor to ensure visual mode is active
  vim.defer_fn(function()
    vim.api.nvim_win_set_cursor(0, { 1, 0 }) -- Move to the first line, first column
    vim.cmd("normal! d")
    vim.cmd([[%s/\(\S\+\).*/winget upgrade --id "\1"]])
    vim.notify("Formatted Winget entries")
  end, 20) -- Delay in milliseconds
end, { desc = "Format Winget entries" })

vim.api.nvim_create_user_command("CcmdToggleWhitespace", function()
  ---@diagnostic disable-next-line: undefined-field
  vim.opt.list = not vim.opt.list:get()
end, {})

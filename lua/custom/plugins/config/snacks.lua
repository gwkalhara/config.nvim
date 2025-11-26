local Snks = {}

Snks.opts = {
  bigfile = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 1000,
    style = "fancy",
    top_down = false,
  },
  statuscolumn = {
    enabled = true,
    folds = { open = true },
    git = {
      patterns = { "MiniDiffSign", "GitSign" },
    },
  },
  git = { enabled = true },
}
Snks.keys = {
  -- stylua: ignore start
  { "<leader>F", function() Snacks.picker() end, desc = "Smart Find" },
  -- find
  { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
  { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
  { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
  { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
  { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },

  -- git
  -- { "<leader>g", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
  { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
  { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
  { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
  { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
  { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
  { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
  { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
  -- gh
  { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
  { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
  { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
  { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
  -- Grep
  { "<leader>sb", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
  { "<leader>ss", function() Snacks.picker.grep() end, desc = "Grep" },
  -- search
  { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
  { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
  { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
  { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },

  -- LSP
  -- { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
  -- { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
  -- { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
  -- { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
  -- { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
  -- { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
  -- { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
  -- { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
  -- { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

  -- Other
  { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
  { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
  { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
  { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
  { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
}
-- stylua: ignore end

return Snks

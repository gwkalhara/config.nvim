require("snacks").setup({
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
    right = { "git", "fold" },
    git = {
      patterns = { "MiniDiffSign", "GitSign" },
    },
  },
  git = { enabled = true },
})

-- stylua: ignore start
vim.keymap.set("n", "<leader>F", function() Snacks.picker() end, { desc = "Smart Find" })
-- find
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, {desc = "Buffers"} )
vim.keymap.set("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, {desc = "Find Config File"} )
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, {desc = "Find Files"} )
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.git_files() end, {desc = "Find Git Files"} )
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, {desc = "Recent"} )

-- git
-- { "<leader>g", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_branches() end, {desc = "Git Branches"} )
vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end, {desc = "Git Log"} )
vim.keymap.set("n", "<leader>gL", function() Snacks.picker.git_log_line() end, {desc = "Git Log Line"} )
vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, {desc = "Git Status"} )
vim.keymap.set("n", "<leader>gS", function() Snacks.picker.git_stash() end, {desc = "Git Stash"} )
vim.keymap.set("n", "<leader>gd", function() Snacks.picker.git_diff() end, {desc = "Git Diff (Hunks)"} )
vim.keymap.set("n", "<leader>gf", function() Snacks.picker.git_log_file() end, {desc = "Git Log File"} )
-- gh
vim.keymap.set("n", "<leader>gi", function() Snacks.picker.gh_issue() end, {desc = "GitHub Issues (open)"} )
vim.keymap.set("n", "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, {desc = "GitHub Issues (all)"} )
vim.keymap.set("n", "<leader>gp", function() Snacks.picker.gh_pr() end, {desc = "GitHub Pull Requests (open)"} )
vim.keymap.set("n", "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, {desc = "GitHub Pull Requests (all)"} )
-- Grep
vim.keymap.set("n", "<leader>sb", function() Snacks.picker.grep_buffers() end, {desc = "Grep Open Buffers"} )
vim.keymap.set("n", "<leader>ss", function() Snacks.picker.grep() end, {desc = "Grep"} )
-- search
vim.keymap.set("n", "<leader>sc", function() Snacks.picker.commands() end, {desc = "Commands"} )
vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, {desc = "Help Pages"} )
vim.keymap.set("n", "<leader>sm", function() Snacks.picker.marks() end, {desc = "Marks"} )
vim.keymap.set("n", "<leader>sq", function() Snacks.picker.qflist() end, {desc = "Quickfix List"} )

vim.keymap.set("n", "<leader>n", function() Snacks.notifier.show_history() end, { desc = "Notification history" })

-- stylua: ignore end

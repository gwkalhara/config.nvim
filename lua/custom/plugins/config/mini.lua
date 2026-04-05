---@diagnostic disable: undefined-global
require("mini.ai").setup()
require("mini.pairs").setup()
require("mini.comment").setup()
require("mini.surround").setup()
require("mini.git").setup()
require("mini.diff").setup()
require("mini.icons").setup()
require("mini.files").setup()
require("mini.statusline").setup()
require("mini.trailspace").setup()
require("mini.bracketed").setup({
  file = { suffix = "", options = {} },
  yank = { suffix = "", options = {} },
  jump = { suffix = "", options = {} },
  oldfile = { suffix = "", options = {} },
  undo = { suffix = "", options = {} },
  indent = { suffix = "", options = {} },
  buffer = { suffix = "", options = {} },
})

vim.keymap.set("n", "<leader>\\", function()
  if not MiniFiles.close() then
    MiniFiles.open()
  end
end, { desc = "Toggle mini.files" })


local miniclue = require("mini.clue")
miniclue.setup({
  triggers = {
    { mode = { "n", "x" }, keys = "<leader>" },
    { mode = "n", keys = "<C-w>" },
    { mode = { "n", "x" }, keys = "z" },
    -- `g` key
    { mode = { "n", "x" }, keys = "g" },

    -- Marks
    { mode = { "n", "x" }, keys = "'" },
    { mode = { "n", "x" }, keys = "`" },

    -- Registers
    { mode = { "n", "x" }, keys = '"' },
    { mode = { "i", "c" }, keys = "<C-r>" },
  },
  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})

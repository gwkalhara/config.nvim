local Mini = {}

Mini.config = function()
  require("mini.ai").setup()
  require("mini.pairs").setup()
  require("mini.comment").setup()
  require("mini.surround").setup()
  require("mini.git").setup()
  require("mini.diff").setup()
  require("mini.icons").setup()
  require("mini.files").setup()
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
end

return Mini

return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.ai").setup()
    require("mini.pairs").setup()
    require("mini.comment").setup()
    require("mini.surround").setup()
    require("mini.git").setup()
    require("mini.diff").setup()
    require("mini.icons").setup()
    require("mini.files").setup()

    vim.keymap.set("n", "<leader>\\", function()
      if not MiniFiles.close() then
        MiniFiles.open()
      end
    end, { desc = "Toggle mini.files" })
  end,
}

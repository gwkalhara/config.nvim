return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.ai").setup()
    require("mini.pairs").setup()
    require("mini.cursorword").setup()
    require("mini.comment").setup()
    require("mini.surround").setup()
    require("mini.indentscope").setup()
    require("mini.git").setup()
  end,
}

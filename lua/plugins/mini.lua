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
  end,
}

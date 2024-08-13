return {
  "declancm/maximize.nvim",
  event = "BufWinEnter",
  config = function ()
    require("maximize").setup()
    vim.keymap.set("n", "<leader>bM", function() require("maximize").toggle() end, {desc = "Toggle maximized window"})
  end,
}

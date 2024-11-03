return {
  "barrett-ruth/live-server.nvim",
  build = "npm add -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
  ft = {"html", "css", "javascript"},
  config = function()
    require("live-server").setup({
      args = {
        "--browser=zen",
      }
    })
  end
}

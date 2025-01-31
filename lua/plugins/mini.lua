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
    require("mini.bracketed").setup({})

    local disabled_mappings = {
      { "n", "[f" },
      { "n", "[F" },
      { "n", "]f" },
      { "n", "]F" },
    }

    for _, maps in ipairs(disabled_mappings) do
      vim.keymap.del(maps[1], maps[2])
    end

    vim.keymap.set("n", "<leader>\\", function()
      if not MiniFiles.close() then
        MiniFiles.open()
      end
    end, { desc = "Toggle mini.files" })
  end,
}

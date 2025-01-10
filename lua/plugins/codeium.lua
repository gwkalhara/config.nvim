return {
  -- INFO: Original repo
  -- "monkoose/neocodeium",
  "gamithaKalharaW/neocodeium.clone",
  event = "VeryLazy",
  -- lazy = true,
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup({
      enabled = true,
      manual = true,
      silent = true,
    })
    -- neocodeium.setup()

    vim.keymap.set(
      "i",
      "<c-]>",
      neocodeium.accept,
      { desc = "Accept codeium prompt" }
    )
    vim.keymap.set(
      "i",
      "<A-w>",
      neocodeium.accept_word,
      { desc = "Accept codeium word" }
    )
    vim.keymap.set(
      "i",
      "<A-a>",
      neocodeium.accept_line,
      { desc = "Accept codeium line" }
    )
    vim.keymap.set(
      "i",
      "<A-e>",
      neocodeium.cycle_or_complete,
      { desc = "Cycle prompt up" }
    )
    vim.keymap.set("i", "<A-r>", function()
      neocodeium.cycle_or_complete(-1)
    end, { desc = "Cycle prompt down" })
    vim.keymap.set("i", "<A-BS>", neocodeium.clear, { desc = "Clear codeium" })
  end,
}

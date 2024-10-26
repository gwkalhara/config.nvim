return {
  -- "monkoose/neocodeium",
  "gamithaKalharaW/neocodeium.clone",
  event = "VeryLazy",
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup({})

    local wk = require("which-key")
    wk.add({
      {"<C-]>", function() neocodeium.accept() end, desc="Accept codeium prompt", mode="i"},
      {"<A-w>", function() neocodeium.accept_word() end, desc="Accept codeium word" , mode="i"},
      {"<A-a>", function() neocodeium.accept_line() end, desc="Accept codeium line" , mode="i"},
      {"<A-e>", function() neocodeium.cycle_or_complete() end, desc="Cycle prompt up" , mode="i"},
      {"<A-r>", function() neocodeium.cycle_or_complete(-1) end, desc="Cycle prompt down" , mode="i"},
      {"<A-BS>", function() neocodeium.clear() end, desc="Clear codeium" , mode="i"},
    })
  end,
}

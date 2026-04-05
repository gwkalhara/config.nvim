local harpoon = require("harpoon")

harpoon:setup({
  menu = {
    width = vim.api.nvim_win_get_width(0) - 4
  },
  settings = {
    save_on_toggle = true,
  },
})


vim.keymap.set("n", "<leader>H", function() harpoon:list():add() end, {desc = "Harpoon File"})
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "Harpoon Quick Menu"})
vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end, {desc = "Harpoon Prev file"})
vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end, {desc = "Harpoon Next file"})

vim.keymap.set("n", "<M-1>", function() harpoon:list():select(1) end, {desc = "Harpoon to file 1"})
vim.keymap.set("n", "<M-2>", function() harpoon:list():select(2) end, {desc = "Harpoon to file 2"})
vim.keymap.set("n", "<M-3>", function() harpoon:list():select(3) end, {desc = "Harpoon to file 3"})
vim.keymap.set("n", "<M-4>", function() harpoon:list():select(4) end, {desc = "Harpoon to file 4"})

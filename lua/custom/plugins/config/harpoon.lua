local Harpoon = {}

Harpoon.keys = function()
  local harpoon = require("harpoon")
  local keys = {
    {
      "<leader>H",
      function()
        harpoon:list():add()
      end,
      desc = "Harpoon File",
    },
    {
      "<leader>h",
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon Quick Menu",
    },
    {
      "<C-p>",
      function()
        harpoon:list():prev()
      end,
      desc = "Harpoon Prev file",
    },
    {
      "<C-n>",
      function()
        harpoon:list():next()
      end,
      desc = "Harpoon Next file",
    },
  }

  for i = 1, 4 do
    table.insert(keys, {
      -- "<leader>" .. i,
      "<M-"
        .. i
        .. ">",
      function()
        require("harpoon"):list():select(i)
      end,
      desc = "Harpoon to File " .. i,
    })
  end
  return keys
end

return Harpoon

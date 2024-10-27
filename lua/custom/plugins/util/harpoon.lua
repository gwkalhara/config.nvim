return {
  'ThePrimeagen/harpoon',
  branch = "harpoon2",
  dependencies = {
    'nvim-lua/plenary.nvim',
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local harpoon = require("harpoon")
    local wk = require("which-key")

    harpoon.setup()

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    wk.add({

      {"<leader>h", group = "Harpoon"},
      {"<leader>ha", function() harpoon:list():add() end , desc = "Add file to harpoon" },
      {"<leader>hr", function() harpoon:list():remove() end , desc = "Remove file from harpoon" },

      {"<leader>h1", function() harpoon:list():select(1) end },
      {"<leader>h2", function() harpoon:list():select(2) end },
      {"<leader>h3", function() harpoon:list():select(3) end },
      {"<leader>h4", function() harpoon:list():select(4) end },

      -- Toggle previous & next buffers stored within Harpoon list
      {"<leader>hp", function() harpoon:list():prev() end, desc = "Previous harpoon buffer" },
      {"<leader>hn", function() harpoon:list():next() end, desc = "Next harpoon buffer" },
      {"<leader>hh", function() toggle_telescope(harpoon:list()) end, desc = "Open harpoon window" }
    })
  end
}

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  keys = {
    { "<leader>hh" },
    { "<leader>fh" },
    { "<C-n>" },
    { "<C-p>" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local harpoon = require "harpoon"
    local wk = require "which-key"

    harpoon.setup {}

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      local harpoon_window_opts = require("telescope.themes").get_ivy {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table {
          results = file_paths,
        },
        previewer = conf.file_previewer {},
        sorter = conf.generic_sorter {},
      }

      require("telescope.pickers").new({}, harpoon_window_opts):find()
    end

    vim.api.nvim_create_user_command("HarpoonAdd", function()
      harpoon:list():add()
    end, { desc = "Add file to harpoon list" })

    local nmap = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { desc = desc })
    end

    vim.keymap.set("n", "<C-n>", function()
      harpoon:list():next()
    end, { desc = "Harpoon next" })
    vim.keymap.set("n", "<C-p>", function()
      harpoon:list():prev()
    end, { desc = "Harpoon previous" })

    nmap("<leader>ha", function()
      harpoon:list():add()
    end, "Add file to harpoon")
    nmap("<leader>hr", function()
      harpoon:list():remove()
    end, "Remove file from harpoon")

    nmap("<m-1>", function()
      harpoon:list():select(1)
    end, "")
    nmap("<m-2>", function()
      harpoon:list():select(2)
    end, "")
    nmap("<m-3>", function()
      harpoon:list():select(3)
    end, "")
    nmap("<m-4>", function()
      harpoon:list():select(4)
    end, "")

    -- stylua: ignore
    wk.add {

      { "<leader>h", group = "Harpoon" },
      -- { "<leader>ha", function() harpoon:list():add() end, desc = "Add file to harpoon", },
      -- { "<leader>hr", function() harpoon:list():remove() end, desc = "Remove file from harpoon", },

      -- { "<m-1>", function() harpoon:list():select(1) end, },
      -- { "<m-2>", function() harpoon:list():select(2) end, },
      -- { "<m-3>", function() harpoon:list():select(3) end, },
      -- { "<m-4>", function() harpoon:list():select(4) end, },
      --
      -- Toggle previous & next buffers stored within Harpoon list
      { "<leader>hp", function() harpoon:list():prev() end, desc = "Previous harpoon buffer", },
      { "<leader>hn", function() harpoon:list():next() end, desc = "Next harpoon buffer", },
      { "<leader>fh", function() toggle_telescope(harpoon:list()) end, desc = "Search harpoon files", },
      { "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Open harpoon window", },
    }
  end,
}

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  keys = {
    { "<leader>h", desc = "[H]arpoon" },
    { "<leader>hh", desc = "[H]arpoon window" },
    { "<leader>fh", desc = "[F]ind [H]arpoon files" },
    { "<C-n>" },
    { "<C-p>" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local harpoon = require("harpoon")
    -- TODO: Remove which-key mapping codeblocks
    -- local wk = require("which-key")

    harpoon.setup({})

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      local harpoon_window_opts = require("telescope.themes").get_ivy({
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      })

      require("telescope.pickers").new({}, harpoon_window_opts):find()
    end

    vim.api.nvim_create_user_command("HarpoonAdd", function()
      harpoon:list():add()
    end, { desc = "Add file to harpoon list" })

    local nmap = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { desc = desc })
    end

    nmap("<C-n>", function()
      harpoon:list():next()
    end, "Harpoon next")
    nmap("<C-p>", function()
      harpoon:list():prev()
    end, "Harpoon previous")

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
    nmap("<leader>fh", function()
      toggle_telescope(harpoon:list())
    end, "[F]ind [H]arpoon files")
    nmap("<leader>hh", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, "Open harpoon window")
  end,
}

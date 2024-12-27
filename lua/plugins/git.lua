return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup {
        on_attach = function(bufnr)
          local gitsigns = require "gitsigns"

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]g", function()
            if vim.wo.diff then
              vim.cmd.normal { "]c", bang = true }
            else
              gitsigns.nav_hunk "next"
            end
          end, { desc = "Next git hunk" })

          map("n", "[g", function()
            if vim.wo.diff then
              vim.cmd.normal { "[c", bang = true }
            else
              gitsigns.nav_hunk "prev"
            end
          end, { desc = "Previous git hunk" })
        end,
      }

      local gitsigns = require "gitsigns"
      require("which-key").add { "<leader>gs", group = "Git stage" }

      vim.keymap.set("n", "<leader>gsb", gitsigns.stage_buffer, { desc = "Stage buffer" })
      vim.keymap.set("n", "<leader>gsh", gitsigns.stage_hunk, { desc = "Stage hunk" })
      vim.keymap.set("n", "<leader>gsu", gitsigns.undo_stage_hunk, { desc = "Undo hunk stage" })
      vim.keymap.set("n", "<leader>gT", function()
        gitsigns.toggle_deleted()
        gitsigns.toggle_current_line_blame()
      end, { desc = "Toggle UI elements" })
    end,
  },
  {
    "wintermute-cell/gitignore.nvim",
    cmd = { "Gitignore" },
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {},
  },
}

return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        signcoloumn = false, -- signcoloumn is handled by `Snacks.nvim` & `mini.diff`
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        --- Simplified map function
        ---@param mode string|string[]: mode (default 'n')
        ---@param l string: lhs
        ---@param r string|function: rhs
        ---@param opts any: options
        local map = function(mode, l, r, opts)
          opts = opts or {}
          mode = mode or "n"
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map(
          "n",
          "<leader>gsb",
          gitsigns.stage_buffer,
          { desc = "[S]tage [B]uffer" }
        )
        map(
          "n",
          "<leader>gsh",
          gitsigns.stage_hunk,
          { desc = "[S]tage [H]unk" }
        )
        map(
          "n",
          "<leader>gsu",
          gitsigns.undo_stage_hunk,
          { desc = "[U]ndo hunk stage" }
        )
        map(
          "n",
          "<leader>grh",
          gitsigns.undo_stage_hunk,
          { desc = "[U]ndo hunk stage" }
        )
        map("n", "<leader>hs", gitsigns.stage_hunk)
        map("n", "<leader>hr", gitsigns.reset_hunk)
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        map("n", "<leader>gT", function()
          gitsigns.toggle_deleted()
          gitsigns.toggle_current_line_blame()
        end, { desc = "[T]oggle UI elements" })
      end,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
      require("which-key").add({
        { "<leader>gs", group = "[G]it [S]tage" },
        { "<leader>gr", group = "[G]it [R]eset" },
      })
    end,
  },
  {
    "wintermute-cell/gitignore.nvim",
    cmd = { "Gitignore" },
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {},
  },
}

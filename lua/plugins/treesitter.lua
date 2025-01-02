return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- a list of parser names, or "all" (the five listed parsers should always be installed)
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "python",
        "go",
        "toml",
        "javascript",
        "typescript",
        "markdown",
        "markdown_inline",
        "html",
        "css",
        "yaml",
        "json",
      },

      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      playground = { enable = true },
      incremental_selection = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- TODO: Look into more about `nvim-treesitter-textobjects`
            -- you can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["aC"] = "@class.outer",
            ["iC"] = "@class.inner",
            ["il"] = "@loop.inner",
            ["al"] = "@loop.outer",
            ["ac"] = "@comment.outer",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
    })
    vim.keymap.set({ "n", "t" }, "]]", function()
      Snacks.words.jump(vim.v.count1)
    end, { desc = "Next Reference" })
    vim.keymap.set({ "n", "t" }, "[[", function()
      Snacks.words.jump(-vim.v.count1)
    end, { desc = "Prev Reference" })
  end,
}

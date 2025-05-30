return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  -- WARN: the master branch is `stuck` and won't recieve updates
  -- have to move to the new `main` branch which is a rewrite
  -- https://github.com/nvim-treesitter/nvim-treesitter/commit/42fc28ba918343ebfd5565147a42a26580579482
  branch = "master",
  build = ":TSUpdate",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- a list of parser names, or "all" (the five listed parsers should always be installed)

      ensure_installed = { -- {{{
        -- mandatory parsers
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",

        -- my parsers
        "python",
        "go",
        "toml",
        "javascript",
        "typescript",
        "html",
        "css",
        "yaml",
        "json",
      },
      -- }}}

      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        disable = { "latex" },
        additional_vim_regex_highlighting = false,
      },
      playground = { enable = true },
      incremental_selection = { enable = false },
      indent = { enable = true },

      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["iS"] = "@statement.inner",
            ["aS"] = "@statement.outer",
            ["if"] = "@function.inner",
            ["af"] = "@function.outer",
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
        move = {
          enable = true,
          goto_next_start = {
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
        },
      },
    })
  end,
}

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- a list of parser names, or "all" (the five listed parsers should always be installed)
      ensure_installed = {
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
    })
  end,
}

return {
  "lervag/vimtex",
  version = "*",
  init = function()
    -- vim.g.vimtex_view_method = "general"
    vim.g.vimtex_compiler_method = "latexmk"

    -- init
    vim.g.vimtex_view_general_viewer = "SumatraPDF"
    vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"

    vim.g.vimtex_compiler_progname = "nvr" -- Neovim remote support
    vim.g.vimtex_compiler_latexmk = {
      build_dir = "build",
      aux_dir = ".texfiles",
      callback = 1,
      continuous = 1,
      executable = "latexmk",
      options = {
        "-pdf",
        "-shell-escape",
        "-interaction=nonstopmode",
        "-synctex=1",
      },
    }
  end,
}

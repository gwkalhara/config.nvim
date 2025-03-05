local Snippets = {}

local ls = require("luasnip") -- Load luasnip
local s = ls.snippet -- Snippet shorthand
local t = ls.text_node -- Text node shorthand
local i = ls.insert_node -- Text insert position
local fmt = require("luasnip.extras.fmt").fmt

Snippets._all = function()
  -- `todo-comments` snippets
  -- List of styles
  local styles = { "INFO", "TEST", "BUG", "WARN", "TODO", "PERF", "HACK", "FIX", "ERROR" } -- Iterate through styles and add snippets
  for _, style in ipairs(styles) do
    ls.add_snippets("all", {
      s(style:lower(), {
        t(style .. ": "),
        i(0, "comment"),
      }),
    })
  end
end

Snippets._makefile = function()
  ls.add_snippets("make", {
    s(
      "phony",
      fmt(
        [[
.PHONY: {job}
{job}:
\t{final}
]],
        { job = i(1, "job"), final = i(0) },
        { repeat_duplicates = true, indent_string = [[\t]] }
      )
    ),
  })
end

Snippets._python = function()
  ls.add_snippets("python", {
    s({ trig = "args kwargs", name = "Func parameters" }, {
      t("*args, **kwargs"),
    }),
  })
end

Snippets._latex = function()
  ls.add_snippets("tex", {
    s({ trig = "!doc", name = "LaTeX Document" }, {
      t({
        "\\documentclass{article}",
        "\\usepackage{amsmath, amssymb}",
        "\\usepackage{graphicx}",
        "\\usepackage{hyperref}",
        "",
        "\\begin{document}",
        "\t",
        "\\end{document}",
      }),
    }),
  })
end

Snippets.load_custom_snippets = function()
  Snippets._all()
  Snippets._python()
  Snippets._latex()
  Snippets._makefile()
end

return Snippets

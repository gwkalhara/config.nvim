local Snippets = {}

local ls = require("luasnip") -- Load luasnip
local s = ls.snippet -- Snippet shorthand
local t = ls.text_node -- Text node shorthand
local i = ls.insert_node -- Text insert position

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

Snippets._python = function()
  ls.add_snippets("python", {
    s({ trig = "args kwargs", name = "Func parameters" }, {
      t("*args, **kwargs"),
    }),
  })
end

Snippets.load_custom_snippets = function()
  Snippets._all()
  Snippets._python()
end

return Snippets

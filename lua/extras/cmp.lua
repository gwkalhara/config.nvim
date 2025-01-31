-- custom cmp source
-- TODO: The following command should be usefull for creating a git commits completion source
-- git log --pretty="format:%h|%aN|%s"
-- The following works even better
-- git log --pretty="format:%h | %s" -n 20
local Job = require("plenary.job")

local source = {}

source.new = function()
  local self = setmetatable({ cache = {} }, { __index = source })
  return self
end

source.complete = function(self, _, callback)
  local bufnr = vim.api.nvim_get_current_buf()

  -- This just makes sure that we only hit the GH API once per session
  if not self.cache[bufnr] then
    Job:new({
      -- Uses `gh` executable
      "gh",
      "issue",
      "list",
      "--limit",
      "100", -- 100 issues
      "--json",
      "title,number,body",

      on_exit = function(job)
        local result = job:result()
        local ok, parsed = pcall(vim.json.decode, table.concat(result, ""))
        if not ok then
          vim.notify("Failed to parse gh result", vim.log.levels.WARN, {})
          return
        end

        local items = {}
        for _, gh_item in ipairs(parsed) do
          gh_item.body = string.gsub(gh_item.body or "", "\r", "")

          table.insert(items, {
            label = string.format("#%s", gh_item.number),
            documentation = {
              kind = "markdown",
              value = string.format("# %s\n\n%s", gh_item.title, gh_item.body),
            },
          })
        end

        callback({ items = items, isIncomplete = false })
        self.cache[bufnr] = items
      end,
    }):start()
  else
    callback({ items = self.cache[bufnr], isIncomplete = false })
  end
end

source.get_trigger_characters = function()
  return { "#" }
end

source.is_available = function()
  return vim.fn.executable("gh") == 1 and vim.bo.filetype == "gitcommit"
end

require("cmp").register_source("gh_issues", source.new())

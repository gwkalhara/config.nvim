local Lualine = {}

Lualine.init = function() -- adapted from https://www.lazyvim.org/plugins/ui#lualinenvim
  vim.g.lualine_laststatus = vim.o.laststatus
  if vim.fn.argc(-1) > 0 then
    -- set an empty statusline till lualine loads
    vim.o.statusline = " "
  else
    -- hide the statusline on the starter page
    vim.o.laststatus = 0
  end
end

Lualine.opts = {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 200,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      {
        "buffers",
        mode = 0,
        icons_enabled = true,
      },
    },
    lualine_x = {
      "g:obsidian",

      -- {
      --   require("noice").api.status.command.get,
      --   cond = require("noice").api.status.command.has,
      --   color = { fg = "#ff9e64" },
      -- },
      -- {
      --   require("noice").api.status.mode.get,
      --   cond = require("noice").api.status.mode.has,
      --   color = { fg = "#ff9e64" },
      -- },
      -- {
      --   require("noice").api.status.search.get,
      --   cond = require("noice").api.status.search.has,
      --   color = { fg = "#ff9e64" },
      -- },
    },
    lualine_y = {
      { "filetype", icon_only = true },
      "encoding",
    },
    lualine_z = {
      {
        require("lazy.status").updates,
        cond = require("lazy.status").has_updates,
        color = { fg = "#15161E" },
      },
      "copilot",
      "location",
      "progress",
    },
  },
  extensions = {
    "lazy",
    "mason",
    "trouble",
  },
}

return Lualine

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local theme = require("lualine.themes.auto")

      local original_c = vim.deepcopy(theme.normal.c)

      for _, mode in pairs(theme) do
        if type(mode) == "table" and mode.c then
          mode.c.bg = "NONE"
        end
      end

      opts.options = opts.options or {}
      opts.options.theme = theme
      opts.options.globalstatus = true
      opts.options.always_divide_middle = false

      -- bottom bar
      opts.sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            color = original_c,
          }
        },
        lualine_x = {
          {
            "fileformat",
            color = original_c,
          },
          {
            "filetype",
            color = original_c,
          },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      }

      -- top bar
      opts.winbar = {
        lualine_a = {},

        lualine_b = {},

        lualine_c = {
          {
            -- function()
            --   return os.date("%a %d %b %H:%M")
            -- end,
          },
        },

        lualine_x = {
          {
            "yt-player",
          }
        },
        lualine_y = {},
        lualine_z = {},
      }

      -- opts.inactive_winbar = {
      --   lualine_c = { "filename" }
      -- }

      return opts
    end,
  },

  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      wk.setup({})
    end,
  },
}
-- debug
-- :lua print(vim.inspect(require("lualine").get_config().sections))

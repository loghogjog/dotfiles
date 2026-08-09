return {
  {
    "goolord/alpha-nvim",
    dependencies = { "amansingh-afk/milli.nvim" },
    -- TODO: CREATE MY OWN CUSTOM GREETER
    config = function ()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local milli = require("milli")

      local splash = milli.load({ splash = "vibecattwo" })

      -- Header
      dashboard.section.header.val = splash.frames[1]

      -- Buttons
      -- dashboard.section.buttons.val = {
      --
      -- }

      alpha.setup(dashboard.config)

      -- Milli Animation
      milli.alpha({
        splash = "vibecattwo",
        loop = true,
      })

    end
  }
}

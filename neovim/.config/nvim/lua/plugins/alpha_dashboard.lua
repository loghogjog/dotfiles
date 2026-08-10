return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/persistence.nvim",
    "amansingh-afk/milli.nvim",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local builtin = require("telescope.builtin")
    local milli = require("milli")

    local function pad_right(text, width)
      local len = vim.fn.strdisplaywidth(text)
      if len >= width then
        return text
      end
      return text .. string.rep(" ", width - len)
    end

    local function grid_line(left, right)
      local l = pad_right(left, 22)
      local r = pad_right(right, 22)
      return " " .. l .. " | " .. r
    end

    local command_grid = {
      type = "group",
      val = {
        { type = "text", val = " ┌────────────────────────┬────────────────────────┐", opts = { position = "center", hl = "Comment" } },
        { type = "text", val = grid_line("[f] Find Files", "[r] Recent Files"), opts = { position = "center", hl = "Comment" } },
        { type = "text", val = grid_line("[g] Find Text", "[c] Config"), opts = { position = "center", hl = "Comment" } },
        { type = "text", val = grid_line("[s] Restore Session", "[e] LazyGit"), opts = { position = "center", hl = "Comment" } },
        { type = "text", val = grid_line("[l] Lazy", "[q] Quit"), opts = { position = "center", hl = "Comment" } },
        { type = "text", val = " └────────────────────────┴────────────────────────┘", opts = { position = "center", hl = "Comment" } },
      },
      opts = { spacing = 0 },
    }

    local function footer()
      local ok_lazy, lazy = pcall(require, "lazy")
      local stats = ok_lazy and type(lazy.stats) == "function" and lazy.stats() or {}
      local version = vim.version()
      return string.format(
        "%d plugins  •  %.2fms  •  v%d.%d.%d", -- %s  •  
        -- os.date("%d-%m-%Y  %H:%M"),
        stats.count or 0,
        tonumber(stats.startuptime) or 0,
        version.major,
        version.minor,
        version.patch
      )
    end

    local function has_alpha_window()
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_is_valid(win) then
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "alpha" then
            return true
          end
        end
      end
      return false
    end

    local function safe_alpha_redraw()
      if not has_alpha_window() then
        return
      end
      vim.schedule(function()
        if has_alpha_window() then
          pcall(vim.cmd.AlphaRedraw)
        end
      end)
    end

    local function clear_alpha_state(win, buf)
      local ok_alpha, alpha_mod = pcall(require, "alpha")
      if not ok_alpha or type(alpha_mod) ~= "table" then
        return
      end
      local state = alpha_mod.state
      if type(state) ~= "table" then
        return
      end

      if win and state.winid == win then
        state.winid = nil
      end
      if buf and (state.bufnr == buf or state.buffer == buf) then
        state.bufnr = nil
        state.buffer = nil
      end
    end

    local function refresh_footer(redraw)
      if vim.o.lines < 24 then
        return
      end
      dashboard.section.footer.val = footer()
      if redraw and vim.bo[vim.api.nvim_get_current_buf()].filetype == "alpha" then
        safe_alpha_redraw()
      end
    end

    -- Weighted Picker
    local function weighted_random(messages)
      local total = 0

      for _, message in ipairs(messages) do
        total = total + message.weight
      end

      local roll = math.random(total)
      local current = 0

      for _, message in ipairs(messages) do
        current = current + message.weight

        if roll <= current then
          return message.text
        end
      end
    end

    -- Motd
    local function red_panda_motd()
      local hour = tonumber(os.date("%H"))

      local messages = {
        { text = "Red panda has reviewed your code. Concerns remain.", weight = 3 },
        { text = "Red panda believes in you. Your implementation, less so.", weight = 4 },
        { text = "One bug at a time, you got this.", weight = 1 },
        { text = "Red panda says: commit before you get creative.", weight = 3 },
        { text = "Your implementation has been forwarded to the panda for review.", weight = 4 },
        { text = "The panda is choosing to trust your judgement", weight = 3 },
        { text = "Red panda belives in you. Git has backups.", weight = 2 },
        { text = "Red panda says: maybe read the error message this time.", weight = 2 },
        { text = "Your code is fine. Probably.", weight = 4 },
        { text = "Red panda approves of today's questionable decisions.", weight = 4 },
        { text = "Another plugin? Red panda is side-eying you.", weight = 2 },
        { text = "Somewhere in this config is a line you copied and have no idea what it does.", weight = 4 },
        { text = "Red panda says: deleting code is also programming.", weight = 1 },
        { text = "Red panda hints: try out the 'Playtime' command.", weight = 3 },
      }

      -- Morning
      if hour >= 5 and hour <= 12 then
        vim.list_extend(messages, {
          { text = "Good morning. Red panda suggests a nap before making bad decisions.", weight = 6 },
          { text = "Fresh buffer. Fresher mistakes.", weight = 4 },
          { text = "Red panda says: start small before your ambitions wake up.", weight = 1 },
          { text = "You have the whole day to make incresing complicated solutions.", weight = 1 },
          { text = "Morning-you has inherited yesterday-you's TODOs.", weight = 4 },
        })

      -- Afternoon
      elseif hour >= 12 and hour <= 18 then
        vim.list_extend(messages, {
          { text = "Red panda says: you've had enough time to find the bug by now.", weight = 4 },
          { text = "Half the day remains. Spend it wisely.", weight = 3 },
          { text = "Red panda recommends fishing one thing before starting four more.", weight = 3 },
          { text = "Lunch has passed. The bug remains.", weight = 3 },
          { text = "Productivity status: difficult to determine.", weight = 6 },
        })

      -- Evening
      elseif hour >= 18 and hour <= 23 then
        vim.list_extend(messages, {
          { text = "Red panda says: One clean commit before you disappear.", weight = 6 },
          { text = "It's evening. Perhaps don't redesign the entire config.", weight = 5 },
          { text = "Finish the thought, not the entire project.", weight = 3 },
          { text = "Red panda supports stopping at a reasonable point.", weight = 6 },
          { text = "Today's bugs can become tomorrow's bugs.", weight = 6 },
        })

      -- Ungodly hours
      else
        vim.list_extend(messages, {
          { text = "Red panda has noticed the clock.", weight = 6 },
          { text = "Red panda says: this problem will still exist tomorrow.", weight = 6 },
          { text = "Save. Commit. Sleep.", weight = 6 },
          { text = "Nothing good begins with a `quick refactor` at this hour.", weight = 3 },
          { text = "Red panda strongly questions this configuration decision.", weight = 6 },
          { text = "Tomorrow-you will still ahve questions.", weight = 4 },
          { text = "The panda is awake because you are.", weight = 6 },
          { text = "Your judgment is probably clouded right now.", weight = 3 },
          { text = "Red panda says: perhaps stop touching the dotfiles.", weight = 6 },
        })
      end

      return weighted_random(messages)
    end

    local screen_lines = vim.o.lines
    local show_message = screen_lines >= 20
    local show_footer = screen_lines >= 24

    -- Milli header
    local splash = milli.load({
      splash = "red-panda-jumping",
    })

    dashboard.section.header.val = splash.frames[1]
--     dashboard.section.header.val = {
-- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣵⢾⣟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
-- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢣⡟⣾⣿⡔⢮⡻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢛⣯⣮⣹⣿⣿⣿⣿⣿⣿",
-- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⡇⣿⡈⣿⣌⠻⣰⣝⠿⢿⡿⣿⣿⣿⡿⣋⣽⡖⣰⡿⢫⣿⣿⣿⣿⣿⣿⣿⣿",
-- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡸⣷⠸⣃⠸⣿⡆⣠⣾⣾⣷⣶⣮⣼⣭⠈⠾⢫⣾⣿⠃⡾⣿⢳⣿⣿⣿⣿⣿⣿",
-- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⣿⡇⢻⡧⢙⣵⣿⣿⣿⣿⣿⣿⣿⣿⣤⢰⣿⣿⠇⣄⢃⡟⣾⣿⣿⣿⣿⣿⣿",
-- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⢰⣿⣿⡷⣡⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣝⠋⡾⣃⣸⡿⢿⣿⣿⣿⣿⣿⣿",
-- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡧⣎⣛⡍⣿⣮⠻⠏⣨⣵⣶⣶⣎⢿⣿⣿⣿⡟⣋⣫⡛⠿⣿⣦⡺⣿⣿⠿⣸⣿⣿⣿⣿⣿⣿",
-- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣫⣿⣿⣿⠂⣼⡿⠋⠉⠻⣿⣸⣿⣿⣿⡘⣿⠿⠻⣿⣾⡻⣷⠝⣫⣿⣿⣿⣿⣿⣿⣿⣿",
-- "⣿⣿⣿⣿⣿⣿⣿⠿⢟⣛⣛⠿⢿⣿⣿⣿⠃⣸⣿⢷⠀⠀⠀⢛⣩⣭⣝⡻⠇⠀⠄⠀⡈⣿⣿⡽⣎⢸⣿⣿⣿⣿⣿⣿⣿⣿",
-- "⣿⣿⣿⣿⢟⣩⣶⣿⣿⣿⣿⣿⣶⣬⡻⣿⡀⣿⣿⠀⡀⠀⣰⣿⠛⠛⢿⣿⣦⠀⠀⠀⢀⣿⣿⡇⣿⡸⣿⣿⣿⣿⣿⣿⣿⣿",
-- "⣿⣿⢟⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⠶⠖⠀⢅⡌⢿⣧⣀⡀⢻⣿⠗⠲⣿⣿⣿⠀⠁⣠⣾⣿⢟⣵⡿⣡⣿⣿⣿⣿⣿⣿⣿⣿",
-- "⣿⢣⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣴⣾⣿⠆⣿⣷⡄⠊⠙⠻⣶⣍⠓⠚⢛⣿⣥⣜⣛⣛⡭⠵⠟⣫⡤⣩⣿⣻⢿⣿⣿⣿⣿⣿",
-- "⣏⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣸⣿⡿⠃⢀⣷⣷⣶⣤⣤⣤⣤⣤⣭⣭⣤⣤⣤⣄⢀⣻⣷⣝⣮⡻⣿⣿⣿⣿⣿⣿",
-- "⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣵⣿⣿⡇⢠⢺⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⢠⡻⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿",
-- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢰⣿⣿⣿⡇⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡧⢀⡈⣿⣜⢿⣿⣿⣿⣿⣿⣿⣿⣿",
-- "⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣌⢿⣿⣿⢇⣨⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⣡⣾⣇⢹⣿⣎⢿⣿⣿⣿⣿⣿⣿⣿",
-- "⡸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣭⡛⠸⣿⣿⣌⠫⣿⣿⣿⣿⣿⣿⣿⠋⣠⣾⣿⣿⣿⠀⣿⣿⣤⡻⣿⣿⣿⣿⣿⣿",
-- "⣧⠹⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣿⣿⣿⢟⣼⡇⢹⣿⣿⣷⣈⠙⣿⣿⠿⣏⣠⠞⢛⠛⠻⢿⡟⠸⣿⣿⣿⣿⡄⣮⣟⢿⣿⣿",
-- "⣿⣦⠘⣿⣿⣿⣿⣿⣿⢑⣠⡂⡤⣾⡎⣼⠟⢡⠀⠻⠋⣴⣶⡄⢈⡋⣼⣿⡇⣾⣿⣿⣿⣦⡉⢶⣦⣍⠻⣿⣿⡼⣿⣷⡜⣿",
-- "⣿⣿⣿⣝⠿⣿⣿⣿⣿⣿⣅⢒⣰⣟⠁⠋⠀⠈⠀⣴⣴⣿⣿⠄⢸⡇⣿⣿⣧⠘⣿⣿⣿⡏⢷⠈⣿⣿⣷⡀⠻⡇⣿⣿⡇⢸",
-- "⣿⣿⣿⣿⣷⣌⡿⢿⣿⣿⣓⡘⢙⣿⡌⠁⡐⠂⠀⣿⣿⣿⠏⢠⣿⠀⣿⣿⣿⣇⠘⣿⣿⣷⣬⣤⣿⣿⣿⣏⠀⣰⣿⣿⠁⣸",
-- "⣿⣿⣿⣿⣿⡿⠿⠿⠶⠖⠈⠀⠈⠙⠃⠀⢠⡶⢸⣿⣿⡏⢠⣾⡿⢰⣿⣿⣿⡟⠀⠘⢿⣿⣿⣿⣿⣿⠿⠃⠘⠛⢉⣁⣸⣿",
-- "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣶⣶⣤⣤⣬⣀⣙⣉⣀⣈⣁⣀⣀⣉⣉⣉⣀⣀⣀⣈⣉⣉⣀⣠⣤⣶⣶⣶⣶⣿⣿⣿⣿",
--     }
--
    dashboard.section.header.opts.hl = "Comment"
    dashboard.section.footer.val = ""
    dashboard.section.footer.opts.hl = "Comment"

    local date_message = {
      type = "text",
      val = os.date("%A, %d %B %H:%M"),
      opts = {
        hl = "Comment",
        position = "center",
      }
    }

    local panda_message = {
      type = "text",
      val = red_panda_motd(),
      opts = {
        hl = "Comment",
        position = "center",
      }
    }

    local layout = {
      { type = "padding", val = 0 },
      dashboard.section.header,
      { type = "padding", val = 0 },
    }
    if show_message then
      layout[#layout + 1] = { type = "padding", val = 2 }
      layout[#layout + 1] = date_message
      layout[#layout + 1] = { type = "padding", val = 1 }
      layout[#layout + 1] = panda_message
      layout[#layout + 1] = { type = "padding", val = 1 }
    end
    layout[#layout + 1] = command_grid
    if show_footer then
      layout[#layout + 1] = { type = "padding", val = 0 }
      layout[#layout + 1] = dashboard.section.footer
    end
    dashboard.config.layout = layout

    alpha.setup(dashboard.config)
    refresh_footer(false)

    milli.alpha({
      splash = "red-panda-jumping",
      loop = true,
    })
    safe_alpha_redraw()

    local function map_dashboard_keys(bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }
      vim.keymap.set("n", "f", builtin.find_files, opts)
      vim.keymap.set("n", "r", builtin.oldfiles, opts)
      vim.keymap.set("n", "g", builtin.live_grep, opts)
      vim.keymap.set("n", "c", "<cmd>cd ~/.config/nvim | e $MYVIMRC | NvimTreeRefresh<CR>", opts)
      vim.keymap.set(
        "n",
        "s",
        "<cmd>lua if _G.restore_session_with_plugins then _G.restore_session_with_plugins() else require('persistence').load() end<CR>",
        opts
      )
      vim.keymap.set("n", "e", "<cmd>LazyGit<CR>", opts)
      vim.keymap.set("n", "l", "<cmd>Lazy<CR>", opts)
      vim.keymap.set("n", "q", "<cmd>quit<CR>", opts)
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        vim.opt_local.fillchars = { eob = " " }
        refresh_footer(true)
        local bufnr = vim.api.nvim_get_current_buf()
        if vim.bo[bufnr].filetype == "alpha" then
          map_dashboard_keys(bufnr)
        end
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = { "LazyDone", "VeryLazy" },
      callback = function()
        -- Lazy's final startup timing is only known after its startup events.
        refresh_footer(true)
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function(event)
        vim.opt_local.foldenable = false
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        refresh_footer(true)
        map_dashboard_keys(event.buf)
      end,
    })

    -- If a real file opens (e.g. from NvimTree), close any visible Alpha window in this tab.
    local function is_real_file_buffer(bufnr)
      if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
        return false
      end
      local ft = vim.bo[bufnr].filetype
      local bt = vim.bo[bufnr].buftype
      local name = vim.api.nvim_buf_get_name(bufnr)
      if ft == "alpha" or ft == "NvimTree" or ft == "aerial" then
        return false
      end
      return bt == "" and name ~= "" and not name:match("^term://")
    end

    vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
      group = vim.api.nvim_create_augroup("AlphaCloseOnRealFile", { clear = true }),
      callback = function(args)
        if not is_real_file_buffer(args.buf) then
          return
        end
        local current_win = vim.api.nvim_get_current_win()
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          if win ~= current_win and vim.api.nvim_win_is_valid(win) then
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].filetype == "alpha" then
              clear_alpha_state(win, buf)
              pcall(vim.api.nvim_win_close, win, true)
            end
          end
        end
      end,
    })

    vim.api.nvim_create_autocmd("WinClosed", {
      group = vim.api.nvim_create_augroup("AlphaStateCleanup", { clear = true }),
      callback = function(event)
        local winid = tonumber(event.match)
        if not winid then
          return
        end
        local ok, buf = pcall(vim.api.nvim_win_get_buf, winid)
        if ok and vim.bo[buf].filetype == "alpha" then
          clear_alpha_state(winid, buf)
        end
      end,
    })

    if vim.bo.filetype == "alpha" then
      map_dashboard_keys(vim.api.nvim_get_current_buf())
    end
  end,
}

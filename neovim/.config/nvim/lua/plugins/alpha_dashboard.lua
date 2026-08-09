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

    local quotes = {
      "What we assembled with trembling hands, rose to question its maker.",
      "The interface is quiet. The ideas are not.",
      "Precision over noise. Focus over frenzy.",
      "Write less. Mean more.",
      "Tools fade. Craft remains.",
      "A sharp editor reveals dull thinking.",
      "Small feedback loops build large systems.",
      "Clean edges, ruthless intent.",
      "Every keystroke is a design decision.",
      "Speed is earned by clarity.",
    }
    math.randomseed(os.time() + (vim.loop and math.floor(vim.loop.hrtime() % 1000000) or 0))
    local quote = quotes[math.random(1, #quotes)]

    local message = {
      type = "text",
      val = quote,
      opts = { hl = "Comment", position = "center" },
    }

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
        { type = "text", val = grid_line("[s] Restore Session", "[n] New File"), opts = { position = "center", hl = "Comment" } },
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
        "%s  •  %d plugins  •  %.2fms  •  v%d.%d.%d",
        os.date("%d-%m-%Y  %H:%M"),
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

    local layout = {
      { type = "padding", val = 0 },
      dashboard.section.header,
      { type = "padding", val = 0 },
    }
    if show_message then
      layout[#layout + 1] = { type = "padding", val = 2 }
      layout[#layout + 1] = message
      layout[#layout + 1] = { type = "padding", val = 0 }
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
      vim.keymap.set("n", "n", "<cmd>ene <BAR> startinsert<CR>", opts)
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

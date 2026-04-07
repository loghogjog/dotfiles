return {
  {
    "pogyomo/winresize.nvim",
    config = function()
      local resize = function(win, amt, dir)
        return function()
          require("winresize").resize(win, amt, dir)
        end
    end

    vim.keymap.set("n", "<A-h>", resize(0, 2, "left"))
    vim.keymap.set("n", "<A-j>", resize(0, 1, "down"))
    vim.keymap.set("n", "<A-k>", resize(0, 1, "up"))
    vim.keymap.set("n", "<A-l>", resize(0, 2, "right"))

    vim.keymap.set("n", "<A-Left>", resize(0, 2, "left"))
    vim.keymap.set("n", "<A-Down>", resize(0, 1, "down"))
    vim.keymap.set("n", "<A-Up>", resize(0, 1, "up"))
    vim.keymap.set("n", "<A-Right>", resize(0, 2, "right"))
  end
  }
}


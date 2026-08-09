return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function ()
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = false
      vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:'

      local ufo = require("ufo")

      vim.keymap.set("n", "zR", ufo.openAllFolds, { desc =  "Open All Folds" })
      vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc =  "Close All Folds" })

      ufo.setup({
        provider_selector = function(bufnr, filetype, buftype)
          return {'lsp', 'indent'}
        end
      })
    end
  }
}

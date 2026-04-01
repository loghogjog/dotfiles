return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Setup servers (modern API)
      vim.lsp.config("lua_ls", {})
      vim.lsp.config("pyright", {})
      vim.lsp.config("ts_ls", {})

      -- Enable them
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("ts_ls")

      -- Keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local map = function(keys, func)
            vim.keymap.set("n", keys, func, { buffer = buf })
          end

          map("gr", vim.lsp.buf.references)
          map("gi", vim.lsp.buf.implementation)
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols)
          map("<leader>ws", require("telescope.builtin").lsp_workspace_symbols)
          map("gd", vim.lsp.buf.definition)
          map("K", vim.lsp.buf.hover)
          map("<leader>rn", vim.lsp.buf.rename)
          map("<leader>ca", vim.lsp.buf.code_action)
        end
      })
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("lua_ls", { capabilities = capabilities })
      vim.lsp.config("pyright", { capabilities = capabilities })
      vim.lsp.config("ts_ls", { capabilities = capabilities })
    end

  }

}

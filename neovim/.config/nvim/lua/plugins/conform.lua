return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      python = { "ruff_format", "black" },
      json = { "prettier", "jq", stop_after_first = true },
    },
    -- This makes the formatting happen automatically on save
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}

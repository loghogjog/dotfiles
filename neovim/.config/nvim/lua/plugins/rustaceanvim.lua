return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended for Nvim 0.11+ compatibility
    lazy = false,    -- This plugin is already lazy-loaded by filetype
    config = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ['rust-analyzer'] = {
              checkOnSave = {
                command = 'clippy',
              },
            },
          },
        },
      }
    end
  }
}

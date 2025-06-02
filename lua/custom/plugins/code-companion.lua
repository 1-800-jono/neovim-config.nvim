return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    { '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Code Companion chat toggle', mode = { 'n', 'v' } },
    { 'ga', '<cmd>CodeCompanionChat Add<cr>', desc = 'Code Companion chat add', mode = 'v' },
    { '<C-a>', '<cmd>CodeCompanionActions<cr>', noremap = true, silent = true, mode = { 'n', 'v' } },
  },
  opts = {
    adapters = {
      copilot = function()
        return require('codecompanion.adapters').extend('copilot', {
          schema = {
            model = {
              default = 'claude-3-7-sonnet',
            },
          },
        })
      end,
    },
    --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
    strategies = {
      --NOTE: Change the adapter as required
      chat = {
        adapter = 'copilot',
        roles = {
          -- I'm using hardcoded roles because there is another issue for llm-dynamic role for custom adapter.
          llm = ' Assistant',
          user = ' Me',
        },
      },
      inline = { adapter = 'copilot' },
    },
    display = {
      chat = {
        show_settings = true,
      },
    },
    --   log_level = 'DEBUG',
  },
  config = function()
    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd [[cab cc CodeCompanion]]
  end,
}

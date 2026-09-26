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
  cond = not vim.g.vscode,
  opts = {
    adapters = {
      copilot = function()
        return require('codecompanion.adapters').extend('copilot', {
          schema = {
            model = {
              -- Try these model identifiers for Claude in Copilot
              -- default = 'claude-3.5-sonnet',
              -- Alternative options to try:
              -- default = 'claude-3-5-sonnet',
              default = 'claude-3.7-sonnet',
              -- default = 'anthropic.claude-3-5-sonnet',
              -- default = 'gpt-4o', -- fallback to known working model
            },
          },
        })
      end,
    },
    strategies = {
      chat = {
        -- adapter = 'copilot',
        name = 'copilot',
        model = 'claude-3.7-sonnet',
      },
      inline = {
        -- adapter = 'copilot',
        name = 'copilot',
        model = 'claude-3.7-sonnet',
      },
    },
    -- display = {
    --   chat = {
    --     show_settings = true,
    --   },
    -- },
    log_level = 'DEBUG', -- Move this out of nested opts
  },
  -- config = function(_, opts)
  --   require('codecompanion').setup(opts)
  --   -- Expand 'cc' into 'CodeCompanion' in the command line
  --   vim.cmd [[cab cc CodeCompanion]]
  -- end,
}

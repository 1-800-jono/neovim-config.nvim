return {
  'CopilotC-Nvim/CopilotChat.nvim',
  enable = false,
  cond = not vim.g.vscode,
  dependencies = {
    { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
    { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
  },
  build = 'make tiktoken', -- Only on MacOS or Linux
  opts = {
    -- See Configuration section for options
  },
  -- See Commands section for default commands if you want to lazy load on them
  keys = {
    { '<leader>zc', ':CopilotChat<CR>', mode = 'n', desc = 'Chat with Copilot' },
    { '<leader>ze', ':CopilotChatExplain<CR>', mode = 'v', desc = 'Explain Copilot' },
    { '<leader>zr', ':CopilotChatReview<CR>', mode = 'v', desc = 'Review Code' },
    { '<leader>zf', ':CopilotChatFix<CR>', mode = 'v', desc = 'Fix Code' },
    { '<leader>zo', ':CopilotChatOptimize<CR>', mode = 'v', desc = 'Optimize Code' },
    { '<leader>zd', ':CopilotChatDebug<CR>', mode = 'v', desc = 'Debug Code' },
    { '<leader>zq', ':CopilotChatQuit<CR>', mode = 'n', desc = 'Quit Chat' },
  },
}

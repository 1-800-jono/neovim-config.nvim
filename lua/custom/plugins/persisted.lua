return {
  'olimorris/persisted.nvim',
  cond = not vim.g.vscode,
  event = 'BufReadPre', -- Ensure the plugin loads only when a buffer has been loaded
  opts = {
    use_git_branch = true, -- Include the git branch in the session file name?
    autoload = true, -- Automatically load the session for the cwd on Neovim startup?
  },
  keys = {
    { '<leader>ss', ':Telescope persisted<CR>', mode = 'n', desc = 'Open telescope with sessions' },
  },
}

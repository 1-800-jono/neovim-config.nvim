return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  cond = not vim.g.vscode,
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {}
  end,
}

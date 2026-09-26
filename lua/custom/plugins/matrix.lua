-- On startup: open a terminal tab when launched on a directory (e.g. `nvim .`),
-- then play the matrix rain overlay (from 1-800-jono/matrix-rain.nvim) on
-- top of it either way.
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Startup terminal / matrix rain',
  group = vim.api.nvim_create_augroup('custom-startup', { clear = true }),
  callback = function()
    if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
      local dir_buf = vim.api.nvim_get_current_buf()
      vim.cmd 'tab term'
      vim.cmd '1tabclose'
      -- Already gone if something (e.g. nvim-tree's directory hijack) set
      -- bufhidden=wipe on it, in which case closing the tab wiped it too.
      if vim.fn.bufexists(dir_buf) == 1 then
        vim.cmd('bwipeout ' .. dir_buf)
      end
    end

    require('matrix-rain').rain()
  end,
})

return {
  '1-800-jono/matrix-rain.nvim',
  lazy = false,
}

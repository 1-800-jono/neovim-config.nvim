-- Draws falling Matrix-style rain in a floating overlay for a couple of
-- seconds. Self-contained (no plugin): a non-focusable float on top of
-- whatever's underneath, so it never touches real buffer content and never
-- steals input.
local function matrix_rain(duration_ms)
  duration_ms = duration_ms or 2500

  local width = vim.o.columns
  local height = vim.o.lines - vim.o.cmdheight - 2
  if width < 1 or height < 1 then
    return
  end

  -- Half-width Katakana: single terminal cell wide (unlike full-width Katakana),
  -- and what the original Matrix digital-rain effect actually used.
  local chars = {}
  for i = 0xFF66, 0xFF9D do
    table.insert(chars, vim.fn.nr2char(i))
  end
  for i = 48, 57 do
    table.insert(chars, vim.fn.nr2char(i))
  end
  local function random_char()
    return chars[math.random(#chars)]
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = 'wipe'

  local ok, win = pcall(vim.api.nvim_open_win, buf, false, {
    relative = 'editor',
    row = 0,
    col = 0,
    width = width,
    height = height,
    style = 'minimal',
    focusable = false,
    zindex = 300,
  })
  if not ok then
    return
  end

  vim.api.nvim_set_hl(0, 'MatrixRain', { fg = '#00ff00', bold = true })
  vim.wo[win].winhighlight = 'Normal:MatrixRain,NormalNC:MatrixRain'

  local drops = {}
  for col = 1, width do
    drops[col] = math.random(-height, 0)
  end

  local trail_len = 12
  local function render()
    local grid = {}
    for row = 1, height do
      grid[row] = {}
      for col = 1, width do
        grid[row][col] = ' '
      end
    end
    for col = 1, width do
      local head = drops[col]
      for trail = 0, trail_len do
        local row = head - trail
        if row >= 1 and row <= height then
          grid[row][col] = random_char()
        end
      end
      drops[col] = drops[col] + 1
      if drops[col] - trail_len > height and math.random() > 0.95 then
        drops[col] = math.random(-height, 0)
      end
    end
    local out = {}
    for row = 1, height do
      out[row] = table.concat(grid[row])
    end
    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, out)
    vim.bo[buf].modifiable = false
  end

  local interval = 60
  local elapsed = 0
  local timer = (vim.uv or vim.loop).new_timer()
  local closed = false
  local function close()
    if closed then
      return
    end
    closed = true
    timer:stop()
    timer:close()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end

  timer:start(
    0,
    interval,
    vim.schedule_wrap(function()
      if closed or not vim.api.nvim_win_is_valid(win) then
        close()
        return
      end
      render()
      elapsed = elapsed + interval
      if elapsed >= duration_ms then
        close()
      end
    end)
  )
end

vim.api.nvim_create_user_command('MatrixRain', function()
  matrix_rain()
end, { desc = 'Play the matrix rain overlay' })

-- On startup: open a terminal tab when launched on a directory (e.g. `nvim .`),
-- then play the matrix rain overlay on top of it either way.
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Startup terminal / matrix rain',
  group = vim.api.nvim_create_augroup('custom-startup', { clear = true }),
  callback = function()
    if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
      local dir_buf = vim.api.nvim_get_current_buf()
      vim.cmd 'tab term'
      vim.cmd '1tabclose'
      vim.cmd('bwipeout ' .. dir_buf)
    end

    matrix_rain()
  end,
})

return {}

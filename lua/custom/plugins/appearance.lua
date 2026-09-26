return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    cond = not vim.g.vscode,
    config = function()
      local HEIGHT_RATIO = 0.8 -- You can change this
      local WIDTH_RATIO = 0.8 -- You can change this too
      require('nvim-tree').setup {
        view = {
          float = {
            enable = true,
            open_win_config = function()
              local screen_w = vim.opt.columns:get()
              local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_w = screen_w * WIDTH_RATIO
              local window_h = screen_h * HEIGHT_RATIO
              local window_w_int = math.floor(window_w)
              local window_h_int = math.floor(window_h)
              local center_x = (screen_w - window_w) / 2
              local center_y = ((vim.opt.lines:get() - window_h) / 2 - vim.opt.cmdheight:get())
              return {
                border = 'rounded',
                relative = 'editor',
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,
              }
            end,
          },
          width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
          end,
        },
        hijack_unnamed_buffer_when_opening = true,
        disable_netrw = true, -- disable :Explore
        hijack_directories = {
          enable = true,
          auto_open = false,
        },
      }
      vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle<CR>', { silent = true })
      vim.cmd.hi 'NvimTreeNormalFloat guibg=none'
    end,
  },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    cond = not vim.g.vscode,
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- insert_at_start = true,
      animation = false,
      -- Set the filetypes which barbar will offset itself for
      sidebar_filetypes = {
        -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
        -- NvimTree = true,
        -- Or, specify the text used for the offset:
        -- undotree = {
        --   text = 'undotree',
        --   align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
        -- },
        -- Or, specify the event which the sidebar executes when leaving:
        -- ['neo-tree'] = { event = 'BufWipeout' },
        -- Or, specify all three
        -- Outline = { event = 'BufWinLeave', text = 'symbols-outline', align = 'right' },
      },
    },
    -- version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    'typicode/bg.nvim',
    lazy = false,
  },
}

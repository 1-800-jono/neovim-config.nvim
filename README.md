# neovim-config.nvim

```
                                    .-----.
         .----------------------.   | === |
         |.-""""""""""""""""""-.|   |-----|
         ||                    ||   | === |
         ||     Follow the     ||   |-----|
         ||    white rabbit    ||   | === |
         ||                    ||   |-----|
         ||                    ||   |:::::|
         |'-..................-'|   |____o|
         `"")----------------(""`   ___________
        /::::::::::|  |::::::::::\  \ no mouse \
       /:::========|  |==hjkl==:::\  \ required \
      '""""""""""""'  '""""""""""""'  '""""""""""'
```

My personal Neovim config. Started from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), since made my own.

## Features

- LSPs: `lua_ls`, `ruby_lsp` (Rails-aware via `ruby-lsp-rails`)
- File tree via `nvim-tree`, buffer tabs via `barbar`
- `telescope`, `persisted` sessions, `gitsigns`, `git-blame`, `git-messenger`, `lazygit`
- `nvim .` opens a terminal tab automatically
- Matrix rain on startup, via [matrix-rain.nvim](https://github.com/1-800-jono/matrix-rain.nvim) — `:MatrixRain` / `:MatrixRain!`

## Install

Requires Neovim >= 0.9.4.

```bash
git clone git@github.com:1-800-jono/neovim-config.nvim.git ~/.config/nvim
```

Plugins install automatically on first launch via `lazy.nvim`.

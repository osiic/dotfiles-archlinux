# 🚀 Neovim IDE Configuration

Full-featured modern Neovim IDE configured in Lua with **Lazy.nvim**, Native LSP (0.11+), Treesitter, Telescope, Neo-tree, Catppuccin theme, and multi-language support.

---

## ⚡ 1-Line Quick Setup

### Option A: Via SSH (Recommended)
```bash
git clone git@github.com:osiic/nvim.git ~/.config/nvim && cd ~/.config/nvim && ./setup.sh
```

### Option B: Via HTTPS
```bash
git clone https://github.com/osiic/nvim.git ~/.config/nvim && cd ~/.config/nvim && ./setup.sh
```

---

## ⌨️ Main Keybindings
- **Leader Key:** `Space`
- **File Explorer:** `<leader>e` (Neo-tree)
- **Fuzzy Finder:** `<leader>ff` (Files), `<leader>fg` (Live Grep)
- **Save & Quit:** `Ctrl + s` (Save) & `<leader>q` (Quit)
- **LSP:** `gd` (Definition), `K` (Hover), `<leader>ca` (Code Action), `<leader>rn` (Rename)
- **Buffer:** `Shift + l` (Next), `Shift + h` (Prev), `<leader>x` (Close)
- **Splits:** `Ctrl + h/j/k/l` (Navigate), `<leader>sv/sh/se/sx` (Splits)

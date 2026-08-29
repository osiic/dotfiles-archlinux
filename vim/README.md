# 📝 Vim Minimal IDE (Cross-Platform & Multi-Distro)

Lightweight Native Vim configuration with **Zero External Plugins**.
Mirrored directly from modern Neovim workflows. Works out-of-the-box on **Arch Linux, Ubuntu/Debian, Gentoo, Fedora, Alpine, macOS, and Termux (Android)**.

---

## ⚡ 1-Line Quick Setup

### Option A: Via SSH (Recommended)
```bash
git clone git@github.com:osiic/vim.git ~/.vim-config && cd ~/.vim-config && ./setup.sh
```

### Option B: Via HTTPS
```bash
git clone https://github.com/osiic/vim.git ~/.vim-config && cd ~/.vim-config && ./setup.sh
```

---

## 🌳 File Tree Explorer (`<Space>e` / `Ctrl+e`)

File manager native Netrw yang dikonfigurasi menyerupai **Neo-tree**:

| Tombol di Tree | Aksi |
|---|---|
| `a` | Buat file (contoh: `index.js`) atau folder baru (akhiri dengan `/`, contoh: `components/`) |
| `d` | Hapus file atau folder (konfirmasi tekan `y`) |
| `r` | Rename / ganti nama file atau folder |
| `l` / `Enter` | Buka file atau buka folder |
| `h` | Naik ke folder atas / collapse |
| `q` | Tutup file tree sidebar |

---

## ⌨️ Shortcuts Utama (Identik Neovim)

- **Leader Key:** `Space`
- **Escape:** `jj` (Insert) & `jk` (Visual)
- **Save & Quit:** `Ctrl + s` (Save) & `<leader>q` (Quit)
- **Buffer:** `Shift + l` (Next), `Shift + h` (Prev), `<leader>x` (Close)
- **Window:** `Ctrl + h/j/k/l` (Navigasi), `<leader>sv/sh/se/sx` (Splits)
- **Search:** `<leader>ff` (Find file), `<leader>fg` (Grep project)
- **Terminal:** `<leader>t` (Terminal split)

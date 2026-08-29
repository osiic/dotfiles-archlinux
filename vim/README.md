# 📝 Vim Minimal IDE (Cross-Platform / Multi-Distro)

Lightweight Native Vim configuration with **Zero External Plugins**.
Mirrored directly from modern Neovim workflows. Works out-of-the-box on **Arch Linux, Ubuntu/Debian, Gentoo, Fedora, Alpine, macOS, and Termux (Android)**.

---

## ⚡ 1-Line Quick Install

Jalankan perintah ini di distro / OS apa saja:

```bash
git clone https://github.com/osiic/vim.git ~/.vim-config && cd ~/.vim-config && ./setup.sh
```

Atau cukup buat symlink manual jika sudah clone:
```bash
git clone https://github.com/osiic/vim.git ~/.vim-config
ln -sfn ~/.vim-config/.vimrc ~/.vimrc
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

### Mode, Save & Quit
- `jj` (Insert Mode) : Kembali ke Normal Mode (`<Esc>`)
- `jk` (Visual Mode) : Kembali ke Normal Mode (`<Esc>`)
- `Ctrl + s` : Simpan file (`:w`)
- `<leader>q` : Keluar (`:q`)
- `<Esc>` : Bersihkan highlight pencarian (`:nohlsearch`)

### Buffer Navigation
- `Shift + l` : Pindah ke buffer berikutnya (`:bnext`)
- `Shift + h` : Pindah ke buffer sebelumnya (`:bprev`)
- `<leader>x` : Tutup buffer aktif (`:bdelete`)
- `<leader>b` : List buffer yang terbuka

### Window Navigation & Splits
- `Ctrl + h` / `Ctrl + j` / `Ctrl + k` / `Ctrl + l` : Pindah panel (Kiri / Bawah / Atas / Kanan)
- `<leader>sv` : Split window vertical
- `<leader>sh` : Split window horizontal
- `<leader>se` : Samakan ukuran split window
- `<leader>sx` : Tutup split window aktif

### Project Search & Terminal
- `<leader>ff` : Fuzzy find file dalam project (`:find <nama_file>`)
- `<leader>fg` : Grep kata kunci di seluruh file (`:vimgrep /kata/ **/*`)
- `<leader>t` : Buka terminal bawaan Vim di split bawah (jika didukung OS)

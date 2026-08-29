# 📝 Vim Minimal IDE Configuration

Konfigurasi Vim native tanpa plugin eksternal, dibuat 100% identik dengan workflow Neovim kamu.

---

## 🌳 File Tree Explorer (`<leader>e` atau `<C-e>`)

Tampilan file explorer menggunakan Netrw yang sudah dikonfigurasi menyerupai **Neo-tree**:

| Tombol di Tree | Aksi |
|---|---|
| `a` | Buat file baru (contoh: `index.js`) atau folder baru (akhiri dengan `/`, contoh: `components/`) |
| `d` | Hapus file atau folder (tekan `y` untuk konfirmasi) |
| `r` | Rename / ganti nama file atau folder |
| `l` / `Enter` | Buka file atau buka/masuk folder |
| `h` | Naik ke folder atas / collapse |
| `q` | Tutup file tree sidebar |

---

## ⌨️ Shortcut Utama (Sama Persis dengan Neovim)

- **Leader Key:** `Space`

### Mode & Save / Quit
- `jj` (Insert Mode) : Kembali ke Normal Mode (`<Esc>`)
- `jk` (Visual Mode) : Kembali ke Normal Mode (`<Esc>`)
- `Ctrl + s` : Simpan file (`:w`)
- `<leader>q` : Keluar (`:q`)
- `<Esc>` : Bersihkan highlight pencarian (`:nohlsearch`)

### Buffer Management
- `Shift + l` : Pindah ke buffer berikutnya (`:bnext`)
- `Shift + h` : Pindah ke buffer sebelumnya (`:bprev`)
- `<leader>x` : Tutup buffer aktif (`:bdelete`)
- `<leader>b` : List buffer yang terbuka

### Window Navigation & Splits
- `Ctrl + h` / `Ctrl + j` / `Ctrl + k` / `Ctrl + l` : Navigasi antar window (Kiri / Bawah / Atas / Kanan)
- `<leader>sv` : Split window vertical
- `<leader>sh` : Split window horizontal
- `<leader>se` : Samakan ukuran split window
- `<leader>sx` : Tutup split window aktif

### Project Search & Terminal
- `<leader>ff` : Fuzzy find file dalam project (`:find <nama_file>`)
- `<leader>fg` : Grep kata kunci di seluruh file (`:vimgrep /kata/ **/*`)
- `<leader>t` : Buka terminal bawaan Vim di split bawah

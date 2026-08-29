# ⚡ Neovim Configuration

Konfigurasi Neovim modern, cepat, minimalis, dan siap pakai (out-of-the-box) untuk web development, scripting, dan general programming.

---

## 🌟 Fitur Utama

- 📦 **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) — Cepat, lazy loading otomatis.
- 🎨 **Tema**: [Catppuccin Mocha](https://github.com/catppuccin/nvim) — Gelap, modern, kontras nyaman di mata.
- 🌳 **Syntax Highlighting**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) — Highlighting akurat berbasis parsing AST.
- 💡 **LSP Support**: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + [Mason](https://github.com/williamboman/mason.nvim) — Autocomplete, go-to-definition, hover docs, rename.
- ⚡ **Auto-completion**: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) + [LuaSnip](https://github.com/L3MON4D3/LuaSnip) + friendly-snippets.
- 🔍 **Fuzzy Finder**: [Telescope](https://github.com/nvim-telescope/telescope.nvim) — Cari file, live grep teks, recent files, buffers.
- 📁 **File Explorer**: [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) — Sidebar file explorer dengan status git dan icon.
- 🐙 **Git Signs**: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) — Indikator diff di baris, stage/preview hunk, blame line.
- 🪄 **Coding Aids**:
  - `nvim-autopairs` — Tutup kurung/petik otomatis saat ngetik.
  - `Comment.nvim` — Toggle komentar cepat (`gcc` / `gc`).
  - `nvim-surround` — Bungkus/ubah tanda kurung/petik/HTML tag.
  - `indent-blankline.nvim` — Garis panduan indentasi visual.
  - `which-key.nvim` — Popup panduan tombol shortcut saat tekan `<leader>`.
- 🧹 **Formatter & Linter**: [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim) (Prettier, Stylua, ESLint_d, dll).

---

## 📋 Prasyarat (Requirements)

Sebelum install, pastikan tool berikut sudah terpasang di sistem:

| Tool | Versi / Catatan |
|---|---|
| **Neovim** | `>= 0.10.0` |
| **Git** | `>= 2.19.0` |
| **C Compiler** | `gcc` / `clang` (untuk build Treesitter parsers) |
| **Node.js & npm** | `>= 18.0.0` (untuk Mason LSP/Linter servers) |
| **ripgrep** | `rg` (untuk Telescope live grep) |
| **fd** | `fd` (untuk pencarian file cepat) |
| **Nerd Font** | Misal: *JetBrainsMono Nerd Font* / *FiraCode Nerd Font* (untuk icon) |

### Install Prasyarat (Contoh OS):

**Arch Linux:**
```bash
sudo pacman -S neovim git gcc nodejs npm ripgrep fd ttf-jetbrains-mono-nerd
```

**Ubuntu / Debian:**
```bash
sudo apt update && sudo apt install -y neovim git gcc nodejs npm ripgrep fd-find
```

**macOS (Homebrew):**
```bash
brew install neovim git gcc node ripgrep fd
```

---

## 🚀 Instalasi & Cara Mulai

1. **Backup config Neovim lama (jika ada):**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   ```

2. **Clone repo ini ke `~/.config/nvim`:**
   ```bash
   git clone https://github.com/osiic/nvim.git ~/.config/nvim
   ```

3. **Buka Neovim:**
   ```bash
   nvim
   ```
   *Plugin manager (lazy.nvim) akan mengunduh semua plugin secara otomatis saat pertama kali dibuka.*

4. **Install LSP, Formatter, dan Linter via Mason:**
   - Di dalam Neovim, ketik `:Mason` untuk melihat daftar tool.
   - Mason sudah otomatis menginstal:
     - **LSP**: `lua_ls`, `ts_ls`, `eslint`, `tailwindcss`
     - **Formatters & Linters**: `stylua`, `prettierd`, `eslint_d`, `dotenv-linter`, `rustywind`, `stylelint`, `nixfmt`

---

## 📁 Struktur Direktori

```text
~/.config/nvim/
├── init.lua                   # Entry point utama (load options, keymaps, plugins)
├── lua/
│   ├── core/
│   │   ├── options.lua        # Pengaturan dasar Neovim (tab, nomor baris, clipboard)
│   │   ├── keymaps.lua        # Shortcut bawaan / general keybindings
│   │   └── plugins.lua        # Bootstrap dan inisialisasi lazy.nvim
│   └── plugins/
│       ├── autopairs.lua      # Auto close kurung/petik + integrasi cmp
│       ├── catppuccin.lua     # Tema Catppuccin Mocha
│       ├── coding.lua         # Comment.nvim, surround, indent-blankline, which-key
│       ├── completion.lua     # nvim-cmp, luasnip, snippets
│       ├── dashboard-nvim.lua # Tampilan awal / Home page Neovim
│       ├── git.lua            # gitsigns.nvim (diff, blame, hunk)
│       ├── lsp.lua            # LSP client, Mason, mason-lspconfig
│       ├── lualine.lua        # Statusline modern di bagian bawah
│       ├── neo-tree.lua       # File explorer sidebar
│       ├── null-ls.lua        # Formatter & linter (none-ls + mason-tool-installer)
│       ├── telescope.lua      # Fuzzy finder file, kata, buffer
│       └── treesitter.lua     # Syntax highlighting & AST parser
└── README.md
```

---

## ⌨️ Daftar Shortcut (Keybindings Cheat Sheet)

> **Leader Key** diset ke tombol **`Space`** (Spasi).

### 1. General & Navigasi

| Shortcut | Mode | Aksi |
|---|---|---|
| `jj` | Insert | Keluar ke Normal mode (`<Esc>`) |
| `jk` | Visual | Keluar ke Normal mode (`<Esc>`) |
| `<C-s>` | Normal | Simpan file (`:w`) |
| `<leader>q` | Normal | Keluar (`:q`) |
| `<Esc>` | Normal | Hilangkan highlight hasil pencarian |
| `<leader>v` | Normal | Bersihkan karakter `\r` (paste aman dari Windows) |

### 2. Window / Split Management

| Shortcut | Mode | Aksi |
|---|---|---|
| `<C-h>` | Normal | Pindah fokus ke window kiri |
| `<C-j>` | Normal | Pindah fokus ke window bawah |
| `<C-k>` | Normal | Pindah fokus ke window atas |
| `<C-l>` | Normal | Pindah fokus ke window kanan |
| `<leader>sv` | Normal | Split window vertikal |
| `<leader>sh` | Normal | Split window horizontal |
| `<leader>se` | Normal | Samakan ukuran split window |
| `<leader>sx` | Normal | Tutup split window aktif |

### 3. Buffer (Tab File)

| Shortcut | Mode | Aksi |
|---|---|---|
| `Shift + l` (`<S-l>`) | Normal | Pindah ke buffer berikutnya |
| `Shift + h` (`<S-h>`) | Normal | Pindah ke buffer sebelumnya |
| `<leader>x` | Normal | Tutup buffer aktif |

### 4. File Explorer (Neo-tree)

| Shortcut | Mode | Aksi |
|---|---|---|
| `<leader>e` | Normal | Toggle Neo-tree (buka/tutup sidebar) |
| `<leader>ge` | Normal | Toggle Neo-tree Git status |
| `l` / `<CR>` | Tree | Buka file atau buka folder |
| `h` | Tree | Tutup folder |
| `<C-e>` | Tree | Tutup Neo-tree |

### 5. Fuzzy Finder (Telescope)

| Shortcut | Mode | Aksi |
|---|---|---|
| `<leader>ff` | Normal | Cari file berdasarkan nama |
| `<leader>fg` | Normal | Cari teks di seluruh project (Live Grep) |
| `<leader>fw` | Normal | Cari kata di bawah kursor |
| `<leader>fb` | Normal | Cari di daftar buffer yang terbuka |
| `<leader>fr` | Normal | Cari file yang baru dibuka (Recent files) |
| `<leader>fh` | Normal | Cari dokumentasi help Neovim |
| `<leader>fp` | Normal | Cari project |
| `<leader>fe` | Normal | Buka Telescope file browser |

### 6. LSP (Language Server) & Diagnostics

| Shortcut | Mode | Aksi |
|---|---|---|
| `gd` | Normal | Go to Definition (lompat ke definisi fungsi/variabel) |
| `gD` | Normal | Go to Declaration |
| `gi` | Normal | Go to Implementation |
| `gr` | Normal | Go to References (lihat semua pemakaian simbol) |
| `K` | Normal | Hover documentation (lihat tipe/dokumentasi) |
| `<leader>ca` | Normal/Visual | Code Action (fix error, import suggestion) |
| `<leader>rn` | Normal | Rename simbol di seluruh project |
| `<leader>d` | Normal | Tampilkan popup error/diagnostic di baris ini |
| `[d` | Normal | Lompat ke error/warning sebelumnya |
| `]d` | Normal | Lompat ke error/warning berikutnya |
| `<leader>s` | Normal | Format file saat ini (via Formatter / LSP) |

### 7. Git Integration (Gitsigns)

| Shortcut | Mode | Aksi |
|---|---|---|
| `]c` | Normal | Lompat ke perubahan git (hunk) berikutnya |
| `[c` | Normal | Lompat ke perubahan git (hunk) sebelumnya |
| `<leader>hs` | Normal/Visual | Stage hunk saat ini |
| `<leader>hr` | Normal/Visual | Reset / Undo hunk saat ini |
| `<leader>hp` | Normal | Preview perubahan hunk (diff popup) |
| `<leader>hb` | Normal | Blame line (lihat commit terakhir baris ini) |
| `<leader>hd` | Normal | Diffview file saat ini |

### 8. Auto-completion (nvim-cmp)

| Shortcut | Mode | Aksi |
|---|---|---|
| `<C-Space>` | Insert | Buka popup autocomplete manual |
| `<CR>` (Enter) | Insert | Pilih saran autocomplete |
| `<C-e>` | Insert | Tutup popup autocomplete |
| `<C-f>` | Insert | Scroll dokumentasi ke bawah |
| `<C-b>` | Insert | Scroll dokumentasi ke atas |

### 9. Comment & Surround

| Shortcut | Mode | Aksi |
|---|---|---|
| `gcc` | Normal | Toggle komentar satu baris |
| `gc` | Visual | Toggle komentar blok yang diseleksi |
| `ysiw"` | Normal | Bungkus kata (`iw`) dengan tanda petik ganda `"` |
| `cs"'` | Normal | Ubah pembungkus dari `"` ke `'` |
| `ds"` | Normal | Hapus tanda petik pembungkus `"` |

---

## 🛠️ Menambah Bahasa / Plugin Baru

### Menambah Language Server (LSP)
1. Buka `lua/plugins/lsp.lua`.
2. Tambahkan nama server ke tabel `ensure_installed` di `mason-lspconfig`.
3. Tambahkan setup server di bawah:
   ```lua
   lspconfig.pyright.setup({
     capabilities = capabilities,
     on_attach = on_attach,
   })
   ```

### Menambah Plugin Baru
Buat file baru di direktori `lua/plugins/<nama-plugin>.lua` dengan format:
```lua
return {
  "author/repository-name",
  event = "VeryLazy",
  config = function()
    require("nama-plugin").setup({
      -- opsi konfigurasi
    })
  end,
}
```

---

## 📄 Lisensi
Config ini dirilis di bawah lisensi MIT. Silakan gunakan dan sesuaikan sesuai kebutuhan!

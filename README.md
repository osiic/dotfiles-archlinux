# 🚀 Dotfiles & System Restore Management

Koleksi konfigurasi personal untuk desktop **Niri (Wayland)**, **DMS (DankMaterialShell)**, Shell, Text Editor, dan System Restore Point.

---

## 📂 Struktur Direktori

Repository ini menggunakan pola **Symlink**. File di dalam `~/dotfiles/` terhubung langsung ke `~/` dan `~/.config/`.
Artinya: **Setiap kali kamu edit config di lokasi aslinya (misal `~/.config/niri/config.kdl`), isi di dalam dotfiles ini otomatis terupdate!**

```text
~/dotfiles/
├── install.sh             # Script untuk deploy/pasang symlink ke sistem
├── sync.sh                # Script untuk auto-commit & push/pull perubahan git
├── README.md              # Panduan lengkap ini
├── home/                  # File yang diarahkan ke ~/ ($HOME)
│   ├── .zshrc
│   ├── .bashrc
│   ├── .bash_profile
│   ├── .gitconfig
│   └── .vimrc
└── config/                # Folder/file yang diarahkan ke ~/.config/
    ├── niri/              # Niri WM config & DMS integration
    ├── DankMaterialShell/ # DMS themes, widgets, & settings
    ├── ghostty/           # Ghostty terminal config & themes
    ├── nvim/              # Neovim configuration
    ├── starship.toml      # Prompt Starship
    ├── fastfetch/         # Fastfetch system info
    ├── btop/              # Resource monitor
    ├── cava/              # Audio visualizer
    ├── alacritty/         # Alacritty terminal theme
    └── swaylock/          # Lockscreen config
```

---

## 🛠️ Cara Pasang di Komputer Baru (Fresh Install)

1. Clone repository dotfiles:
   ```bash
   git clone <URL_REPO_GITHUB_KAMU> ~/dotfiles
   ```
2. Jalankan installer symlink:
   ```bash
   cd ~/dotfiles
   ./install.sh
   ```
   *Installer akan otomatis membuat symlink dan mengamankan file lama jika ada yang bentrok.*

---

## 🔄 Cara Sync & Backup Config (Git)

Jika kamu baru saja mengubah konfigurasi desktop / shell / editor dan ingin menyimpannya ke Git:

```bash
cd ~/dotfiles
./sync.sh
```
Atau berikan pesan commit spesifik:
```bash
./sync.sh "update niri keybinds and wallpaper timer"
```

Jika kamu sudah menambahkan remote GitHub (`git remote add origin <URL>`), script `./sync.sh` juga akan otomatis melakukan **pull** dan **push** ke repository GitHub kamu.

---

## 🛡️ System Restore Point (Timeshift)

Untuk restore point seluruh sistem operasi (OS-wide backup) jika terjadi error sistem/driver/kernel:

### 1. Install Timeshift
```bash
sudo pacman -S timeshift rsync
```

### 2. Buat Restore Point Baru (Snapshot)
- **Lewat GUI:** Buka aplikasi **Timeshift** dari menu / DMS Spotlight (`Mod + Space`).
- **Lewat CLI (Terminal):**
  ```bash
  # Buat snapshot dengan komentar
  sudo timeshift --create --comments "Clean Working Setup" --tags D
  ```

### 3. Lihat Daftar Restore Point
```bash
sudo timeshift --list
```

### 4. Restore Sistem jika Terjadi Masalah
- **Lewat CLI:**
  ```bash
  sudo timeshift --restore
  ```
  *(Pilih nomor snapshot yang ingin di-restore lalu ikuti petunjuk di layar).*

### 5. Otomatisasi Snapshot Harian
Aktifkan cron daemon untuk snapshot terjadwal:
```bash
sudo pacman -S cronie
sudo systemctl enable --now cronie.service
```
Buka Timeshift -> Settings -> Schedule -> Aktifkan Daily/Weekly snapshot sesuai kebutuhan.

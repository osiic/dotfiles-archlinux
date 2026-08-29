# 🚀 dotfiles-archlinux

Full Plug & Play Dotfiles, Modular Submodules, dan Full System Provisioning untuk **Arch Linux (Niri Wayland + DMS)**.

---

## ⚡ 1-Line Quick Setup (Pilih SSH atau HTTPS)

### Option A: Via SSH (Recommended)
```bash
git clone --recurse-submodules git@github.com:osiic/dotfiles-archlinux.git ~/dotfiles && cd ~/dotfiles && ./setup.sh all
```

### Option B: Via HTTPS
```bash
git clone --recurse-submodules https://github.com/osiic/dotfiles-archlinux.git ~/dotfiles && cd ~/dotfiles && ./setup.sh all
```

> **Apa saja yang otomatis di-setup oleh `./setup.sh all`?**
> 1. **Packages:** Install 80+ native Pacman packages, build & install `paru`, install AUR apps (Microsoft Edge, Claude Code, Antigravity, dll), serta Flatpak apps (OBS Studio).
> 2. **System Tweaks:** Limit pengisian baterai laptop maksimal **60%** (`battery-charge-threshold.service`), enable NetworkManager, Bluetooth, PipeWire Audio, CUPS printer, UFW firewall, dan cronie untuk Timeshift.
> 3. **Modular Configs:** Otomatis deploy symlink untuk Niri, DankMaterialShell, Ghostty, NeoVim, Starship, Zsh, Fastfetch, Swaylock, dan Wallpapers.

---

## 📂 Struktur Modular & Standalone Submodules

Setiap modul berdiri sendiri sebagai repository independen dan memiliki script `./setup.sh`:

```text
~/dotfiles/
├── setup.sh               # Single Unified Script: install, deploy modul, atau auto-sync
├── README.md              # Dokumentasi lengkap
│
├── packages/              # Package provisioning (Pacman, Paru/AUR, Flatpak)
│   ├── install-packages.sh
│   ├── pacman.txt
│   ├── aur.txt
│   └── flatpak.txt
│
├── system/                # System tweaks & systemd services
│   ├── install-system.sh
│   └── battery-charge-threshold.service (Limit Baterai 60%)
│
├── shell/                 # Shell environment (.zshrc, .bashrc, starship.toml) -> osiic/shell
├── ghostty/               # Ghostty terminal config -> osiic/ghostty
├── nvim/                  # Full Neovim IDE -> osiic/nvim
├── vim/                   # Vim Minimal IDE -> osiic/vim
├── desktop/               # Niri WM, DankMaterialShell, Swaylock, Wallpaper -> osiic/desktop
└── cli/                   # CLI Tools (.gitconfig, btop, cava, fastfetch, nvm, bun) -> osiic/cli
```

---

## 🧩 Penggunaan Parsial di Distro Lain (Ubuntu / Gentoo / Server)

Jika kamu berada di komputer kerja, VPS server, atau distro lain dan **hanya butuh modul tertentu**:

```bash
# Contoh 1: Hanya butuh Shell (Zsh + Starship)
./setup.sh shell

# Contoh 2: Hanya butuh Neovim IDE
./setup.sh nvim

# Contoh 3: Hanya deploy seluruh symlink config (tanpa install package Arch)
./setup.sh configs
```

---

## 🔄 Cara Sync & Backup Config

Untuk melakukan auto-commit dan push seluruh perubahan konfigurasi ke GitHub:
```bash
./setup.sh "pesan commit kamu"
```
Atau tanpa pesan:
```bash
./setup.sh sync
```

---

## 🐳 Docker On-Demand Policy (8GB RAM Optimization)

- **Engine & Compose Native:** Docker Engine + Docker Compose native (tanpa overhead Docker Desktop).
- **Socket Activation On-Demand (`docker.socket`):** Docker daemon **tidak berjalan di background saat boot/idle** sehingga RAM tetap lega. Daemon baru otomatis aktif saat perintah `docker` / `docker compose` dipanggil.
- **Workflow On-Demand:**
  ```bash
  # Mulai testing lokal / sandbox:
  docker compose up -d

  # Setelah selesai bekerja:
  docker compose down
  ```

---

## 🛡️ System Restore Point (Timeshift)

- **Buat Restore Point Baru:**
  ```bash
  sudo timeshift --create --comments "Working Stable State" --tags D
  ```
- **Restore OS:**
  ```bash
  sudo timeshift --restore
  ```

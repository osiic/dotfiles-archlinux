# 🚀 dotfiles-archlinux

Full Plug & Play Dotfiles, Modular Submodules, dan Full System Provisioning untuk **Arch Linux (Niri Wayland + DMS)**.

---

## ⚡ One-Command Bootstrap (Mesin / Laptop Baru)

Tinggal jalankan **1 baris perintah ini** di instalasi Arch Linux baru:

```bash
git clone --recurse-submodules https://github.com/osiic/dotfiles-archlinux.git ~/dotfiles && cd ~/dotfiles && ./install.sh all
```

> **Apa saja yang otomatis di-setup oleh `./install.sh all`?**
> 1. **Packages:** Install 80+ native Pacman packages, build & install `paru`, install AUR apps (Microsoft Edge, Claude Code, Antigravity, dll), serta Flatpak apps (OBS Studio).
> 2. **System Tweaks:** Limit pengisian baterai laptop maksimal **60%** (`battery-charge-threshold.service`), enable NetworkManager, Bluetooth, PipeWire Audio, CUPS printer, UFW firewall, dan cronie untuk Timeshift.
> 3. **Modular Configs:** Otomatis deploy symlink untuk Niri, DankMaterialShell, Ghostty, NeoVim, Starship, Zsh, Fastfetch, Swaylock, dan Wallpapers.

---

## 📂 Struktur Modular & Submodules

Setiap modul bersifat **independen** dan memiliki script `setup.sh` masing-masing:

```text
~/dotfiles/
├── install.sh             # Master installer: './install.sh [all|packages|system|configs|<module>]'
├── sync.sh                # Auto-sync git master & recursive submodules
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
├── shell/                 # Shell environment (.zshrc, .bashrc, starship.toml)
│   └── setup.sh
│
├── ghostty/               # Ghostty terminal config
│   └── setup.sh
│
├── nvim/                  # Git Submodule -> git@github.com:osiic/nvim.git
│   └── setup.sh
│
├── vim/                   # Vim config (.vimrc)
│   └── setup.sh
│
├── desktop/               # Niri WM, DankMaterialShell, Swaylock
│   ├── setup.sh
│   └── wallpaper/         # Git Submodule -> https://github.com/orangci/walls-catppuccin-mocha.git
│
└── cli/                   # CLI Tools (.gitconfig, btop, cava, fastfetch)
    └── setup.sh
```

---

## 🧩 Penggunaan Parsial di Distro Lain (Ubuntu / Debian / Server)

Jika kamu berada di komputer kerja, VPS server, atau distro lain dan **hanya butuh modul tertentu**:

```bash
# Contoh 1: Hanya butuh Neovim
git clone git@github.com:osiic/nvim.git ~/.config/nvim

# Contoh 2: Hanya butuh Shell (Zsh + Starship) dari dotfiles
git clone https://github.com/osiic/dotfiles-archlinux.git ~/dotfiles
cd ~/dotfiles
./install.sh shell

# Contoh 3: Hanya deploy semua config (tanpa install software Arch)
./install.sh configs
```

---

## 🔄 Cara Update & Sync Config

Setiap kali kamu edit konfigurasi (misal edit `~/.config/niri/config.kdl` atau `~/.zshrc`), filenya otomatis berubah di dalam `~/dotfiles` karena menggunakan **Live Symlink**.

Untuk menyimpan dan push ke GitHub:
```bash
cd ~/dotfiles
./sync.sh "update niri window rules"
```

---

## 🛡️ System Restore Point (Timeshift)

Untuk proteksi OS sebelum melakukan update besar atau utak-atik kernel:

- **Buat Restore Point Baru (CLI):**
  ```bash
  sudo timeshift --create --comments "Working Stable State" --tags D
  ```
- **Restore OS:**
  ```bash
  sudo timeshift --restore
  ```

# Changelog

Semua perubahan tercatat di file ini. Format mengacu pada [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

## [2.2.0] - 2026-09-03

### Changed
- **Touchpad:** Mengaktifkan `natural_scroll = yes` (arah scroll natural/alami, bukan inverted).
- **Touchpad Ergonomics:** Menambahkan `tap-to-click = yes`, `tap-and-drag = yes`, dan `disable_while_typing = yes`.
- **Gestures:** Mengaktifkan `workspace_swipe = on` (3-finger swipe gesture untuk pindah antar workspace secara smooth).

## [2.1.0] - 2026-09-03

### Changed
- **Waybar Temperature:** Mengganti pembacaan unit temperatur dari Fahrenheit (°F) ke Celsius (°C) dan auto-detect sensor thermal.
- **Waybar Backlight:** Menghapus hardcode device `intel_backlight` agar auto-detect display device.
- **Hyprland Environment:** Menambahkan environment variables standar Wayland (`QT_QPA_PLATFORM`, `GDK_BACKEND`, `ELECTRON_OZONE_PLATFORM_HINT`, dll).
- **Hyprland Portal:** Membersihkan autostart redundant script, mengandalkan native systemd & dbus activation `xdg-desktop-portal-hyprland`.

## [2.0.0] - 2026-09-03

### Changed
- **Terminal:** Mengganti default terminal shortcut (`SUPER + T`) dari Kitty ke Ghostty.
- **App Launcher:** Mengganti default runner (`SUPER + SPACE`) dari Wofi ke Fuzzel (Wayland C native, hemat memori).
- **File Manager:** Mengganti default browser shortcut (`SUPER + E`) dari Thunar ke Nautilus.
- **Performance & RAM Tweaks:**
  - Menurunkan blur pass menjadi 2 dan radius 4.
  - Mematikan shadow berat (`drop_shadow = false`) untuk menghemat alokasi RAM (8GB constraint) & iGPU.
  - Mengaktifkan `vfr = true` (Variable Frame Rate) pada Hyprland misc.
- **Notification Daemon:** Mengintegrasikan autostart `mako` yang ringan.
- **Package Management:** Beralih penuh ke `paru` (AUR helper) dan menghapus ketergantungan `yay`.

### Added
- Script deployment otomatis `setup.sh` untuk symlink konfigurasi desktop (`~/.config/hypr` dan `~/.config/waybar`).
- File `.gitignore` untuk mengabaikan artefak cache/backup.
- File `CHANGELOG.md` untuk mencatat setiap siklus perubahan konfigurasi.

### Removed
- Menghapus konfigurasi `config/kitty` (dikelola mandiri di `dotfiles/ghostty`).
- Menghapus folder `extra/home` (`.zshrc`, `.oh-my-zsh`, `.p10k.zsh`) agar tidak menduplikasi modul `dotfiles/shell`.
- Menghapus file petunjuk `yay.md`.

## [1.0.0] - 2024 (Arsip Branch `old`)
- Konfigurasi awal Hyprland, Waybar, Kitty, Wofi, dan script power button untuk ASUS ROG G15 Strix.

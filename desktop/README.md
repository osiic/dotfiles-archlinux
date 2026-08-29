# 🖥️ Niri & DankMaterialShell Desktop Environment

Complete Wayland desktop setup with **Niri (Scrollable Tiling Window Manager)**, **DankMaterialShell (DMS UI & Widgets)**, **Swaylock**, and **Catppuccin Wallpapers collection**.

---

## ⚡ 1-Line Quick Setup

### Option A: Via SSH (Recommended)
```bash
git clone --recurse-submodules git@github.com:osiic/desktop.git ~/.desktop-config && cd ~/.desktop-config && ./setup.sh
```

### Option B: Via HTTPS
```bash
git clone --recurse-submodules https://github.com/osiic/desktop.git ~/.desktop-config && cd ~/.desktop-config && ./setup.sh
```

---

## 📦 What's Included & Managed
- **Niri WM (`niri/`):** Full scrollable Wayland compositor config, keymaps, app rules, animations, dynamic wallpaper timer (2m cycle), and autostart apps.
- **DankMaterialShell (`DankMaterialShell/`):** System topbar, spotlight search, dashboard, clipboard manager, control center, themes, and plugins.
- **Swaylock (`swaylock/`):** Screen locker configuration with Catppuccin theme.
- **Wallpapers (`wallpaper/`):** Submodule koleksi wallpaper Catppuccin Mocha + symlink cepat di `~/Pictures/Wallpapers`.
- **Auto-Updater & Live Symlinks:** Terintegrasi auto-pull dari GitHub dan auto-reload Niri session.

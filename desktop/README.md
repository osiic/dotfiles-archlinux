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

## ⌨️ Custom Keyboard Remap (Hardware Level)

- **`Caps Lock` -> `Escape`** (`options "caps:escape"` aktif via XKB di Niri). Cocok untuk Vim/Neovim speed editing.

---

## 🎮 Desktop Keybindings Cheatsheet (`Mod` = Super / Windows Key)

### 🚀 Core Apps & DMS Controls
| Shortcut | Aksi |
|---|---|
| `Mod + T` | Buka Terminal (**Ghostty**) |
| `Mod + N` | Buka Editor (**Neovim di Ghostty**) |
| `Mod + B` | Buka Browser (**Microsoft Edge**) |
| `Mod + E` | Buka File Manager (**Nautilus**) |
| `Mod + Space` | **DMS Spotlight Search** (App Launcher) |
| `Mod + V` | **DMS Clipboard Manager** |
| `Mod + D` | **DMS Dashboard** |
| `Mod + Shift + C` | **DMS Control Center** |
| `Mod + Shift + N` | **DMS Notepad** |
| `Mod + X` | **DMS Power Menu** |
| `Mod + Alt + L` | **DMS Lock Screen** (Swaylock) |
| `Mod + Alt + P` | **DMS Color Picker** |
| `Mod + Alt + N` | **DMS Night Light** |
| `Mod + Alt + T` | **DMS Toggle Theme** |
| `Ctrl + Shift + Esc` | **DMS Process List** |
| `Mod + Shift + /` | Tampilkan Hotkey Overlay Niri |

### 🖼️ Wallpaper Controls
| Shortcut | Aksi |
|---|---|
| `Mod + Alt + ]` | **Next Wallpaper** (Ganti ke wallpaper berikutnya) |
| `Mod + Alt + [` | **Previous Wallpaper** (Kembali ke wallpaper sebelumnya) |
| *Auto Timer* | Wallpaper otomatis berganti tiap **2 menit** di background. |

### 🪟 Window Management & Navigation
| Shortcut | Aksi |
|---|---|
| `Mod + Q` | **Close Window** |
| `Mod + O` | **Toggle Overview Mode** |
| `Alt + Tab` | Switch Window Sebelumnya |
| `Mod + H / J / K / L` | Fokus window (Kiri / Bawah / Atas / Kanan) |
| `Mod + Ctrl + H / J / K / L` | Pindahkan kolom/window (Kiri / Bawah / Atas / Kanan) |
| `Mod + F` | Maximize Column |
| `Mod + Shift + F` | **Fullscreen Window** |
| `Mod + M` | Maximize Window to Edges |
| `Mod + C` | Center Column di layar |
| `Mod + Shift + Space` | **Toggle Floating Window** |
| `Mod + W` | Toggle Tabbed Column Display |
| `Mod + -` / `Mod + =` | Perkecil / Perbesar lebar kolom (-/+ 10%) |

### 🗂️ Workspaces & Multi-Monitor
| Shortcut | Aksi |
|---|---|
| `Mod + 1 .. 9` | Pindah ke Workspace 1 - 9 |
| `Mod + Shift + 1 .. 9` | Pindahkan Window ke Workspace 1 - 9 |
| `Mod + Shift + H / J / K / L` | Pindah fokus ke Monitor Kiri / Bawah / Atas / Kanan |
| `Mod + Shift + Ctrl + H / J / K / L` | Pindahkan Window ke Monitor Kiri / Bawah / Atas / Kanan |

### ⚙️ Session Controls
| Shortcut | Aksi |
|---|---|
| `Mod + Shift + R` | **Reload Config Niri** (`niri msg action load-config-file`) |
| `Mod + Shift + E` / `Mod + Shift + Q` | **Quit Niri Session** (Logout) |
| `Mod + Shift + P` | Matikan Monitor (Power off screen) |

---

## 📦 What's Included & Managed
- **Niri WM (`niri/`):** Full scrollable Wayland compositor config, keymaps, app rules, animations, dynamic wallpaper timer (2m cycle), and autostart apps.
- **DankMaterialShell (`DankMaterialShell/`):** System topbar, spotlight search, dashboard, clipboard manager, control center, themes, and plugins.
- **Swaylock (`swaylock/`):** Screen locker configuration with Catppuccin theme.
- **Wallpapers (`wallpaper/`):** Submodule koleksi wallpaper Catppuccin Mocha + symlink cepat di `~/Pictures/Wallpapers`.

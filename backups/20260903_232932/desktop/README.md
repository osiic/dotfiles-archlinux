# hyprland

Konfigurasi Wayland desktop environment berbasis Hyprland yang ringan dan teroptimasi.

## Struktur Direktori

```text
.
├── config/
│   ├── hypr/
│   │   ├── hong-kong-night.jpg
│   │   ├── hyprland.conf
│   │   └── xdg-portal-hyprland
│   └── waybar/
│       ├── config.jsonc
│       └── style.css
├── setup.sh
└── README.md
```

## Komponen Utama
- **WM:** `hyprland`
- **Bar:** `waybar`
- **Wallpaper:** `swaybg`
- **App Launcher:** `fuzzel`
- **Notifications:** `mako`
- **Terminal:** `ghostty` (dikelola via submodule terpisah `dotfiles/ghostty`)
- **File Manager:** `nautilus`
- **Portal:** `xdg-desktop-portal-hyprland`

## Instalasi / Deploy Symlinks

Jalankan via root dotfiles:
```bash
cd ~/dotfiles && ./setup.sh desktop
```

Atau jalankan mandiri:
```bash
./setup.sh
```

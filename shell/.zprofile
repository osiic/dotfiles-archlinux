# ~/.zprofile - Login profile for Zsh

# Auto-start Hyprland session on TTY1 without login prompt
if [[ -z "$WAYLAND_DISPLAY" && "${XDG_VTNR:-0}" -eq 1 && -z "$_HYPRLAND_STARTING" ]]; then
    export _HYPRLAND_STARTING=1
    exec start-hyprland
fi

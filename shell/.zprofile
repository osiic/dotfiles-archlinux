# ~/.zprofile - Login profile for Zsh

# Auto-start Niri session on TTY1 without login prompt
if [[ -z "$WAYLAND_DISPLAY" && "${XDG_VTNR:-0}" -eq 1 && -z "$_NIRI_STARTING" ]]; then
    export _NIRI_STARTING=1
    exec niri-session
fi

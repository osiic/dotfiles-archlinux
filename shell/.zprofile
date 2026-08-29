# ~/.zprofile - Login profile for Zsh

# Auto-start Niri session on TTY1 without login prompt
if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    if command -v niri-session >/dev/null 2>&1; then
        exec niri-session
    fi
fi

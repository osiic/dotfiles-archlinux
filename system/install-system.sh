#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Configuring System Tweaks & Services ==="

# 1. Battery Charge Threshold (Limit 60%)
if [ -f "$DIR/battery-charge-threshold.service" ]; then
    echo "Installing battery-charge-threshold.service..."
    sudo cp "$DIR/battery-charge-threshold.service" /etc/systemd/system/
    sudo systemctl daemon-reload
    sudo systemctl enable --now battery-charge-threshold.service || echo "Warning: battery threshold service enable failed (check if hardware supports BAT0 charge threshold)"
fi

# 2. Enable Standard System Services
SERVICES=(
    "NetworkManager.service"
    "bluetooth.service"
    "power-profiles-daemon.service"
    "ufw.service"
    "cups.service"
    "fstrim.timer"
    "systemd-timesyncd.service"
)

for svc in "${SERVICES[@]}"; do
    echo "Enabling $svc..."
    sudo systemctl enable "$svc" 2>/dev/null || true
done

# 3. Setup Timeshift automated daily snapshot via cronie if available
if command -v crond >/dev/null 2>&1 || systemctl list-unit-files cronie.service >/dev/null 2>&1; then
    echo "Enabling cronie.service for Timeshift automated snapshots..."
    sudo systemctl enable --now cronie.service 2>/dev/null || true
fi

echo "=== System Services Configuration Complete! ==="

#!/usr/bin/env bash

set -e

APP_NAME="Frames Unlock Animation"
INSTALL_DIR="$HOME/.local/share/frames-unlock-animation"
SERVICE_DIR="$HOME/.config/systemd/user"
SERVICE_NAME="frames-unlock-animation.service"

echo "Uninstalling $APP_NAME..."

systemctl --user stop "$SERVICE_NAME" || true
systemctl --user disable "$SERVICE_NAME" || true

rm -f "$SERVICE_DIR/$SERVICE_NAME"
rm -rf "$INSTALL_DIR"

systemctl --user daemon-reload

echo ""
echo "$APP_NAME has been removed."

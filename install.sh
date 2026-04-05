#!/usr/bin/env bash

set -e

APP_NAME="Frames Unlock Animation"
INSTALL_DIR="$HOME/.local/share/frames-unlock-animation"
SERVICE_DIR="$HOME/.config/systemd/user"
SERVICE_NAME="frames-unlock-animation.service"

echo "Installing $APP_NAME..."

echo "Creating installation directory..."
mkdir -p "$INSTALL_DIR"

echo "Copying program files..."
cp -r frames "$INSTALL_DIR/"
cp Frames_Unlock_Animation.py "$INSTALL_DIR/"
cp run_animation.sh "$INSTALL_DIR/"

echo "Installing systemd user service..."
mkdir -p "$SERVICE_DIR"
cp frames-unlock-animation.service "$SERVICE_DIR/"

echo "Reloading systemd..."
systemctl --user daemon-reload

echo "Enabling service..."
systemctl --user enable "$SERVICE_NAME"

echo "Starting service..."
systemctl --user start "$SERVICE_NAME"

echo ""
echo "$APP_NAME installed successfully."
echo "Lock and unlock your screen to test the animation."

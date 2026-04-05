#!/usr/bin/env bash

set -e # exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "script started $(date)" >> /tmp/unlock_animation_debug.log

# ---------- SINGLE LISTENER LOCK ----------

LISTENER_LOCK="/tmp/unlock_animation_listener.lock"

if [ -f "$LISTENER_LOCK" ]; then
    exit
fi

touch "$LISTENER_LOCK"
trap "rm -f $LISTENER_LOCK" EXIT


ANIMATION_SCRIPT="$SCRIPT_DIR/Frames_Unlock_Animation.py"
LOCKFILE="/tmp/unlock_animation.lock"


echo "listener active $(date)" >> /tmp/unlock_animation_debug.log


gdbus monitor --session \
--dest org.gnome.ScreenSaver \
--object-path /org/gnome/ScreenSaver |
while read -r line; do

    echo "$line" >> /tmp/unlock_animation_debug.log

    if [[ "$line" == *"ActiveChanged (false"* ]]; then

        if [ -f "$LOCKFILE" ]; then
            continue
        fi

        touch "$LOCKFILE"

        echo "unlock detected $(date)" >> /tmp/unlock_animation_debug.log
        echo "running animation $(date)" >> /tmp/unlock_animation_debug.log


        python3 "$ANIMATION_SCRIPT"

        rm -f "$LOCKFILE"

    fi

done
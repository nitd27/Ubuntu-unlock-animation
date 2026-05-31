import subprocess
import os
import time

#-----------Frames_Unlock_Animation-----------



#"frames" directory contains all images for the animation

#You can change Animation by choosing diffrent folder name, look out for options in /frames.
FRAME_DIR = os.path.join(os.path.dirname(__file__),"frames", "Miku-eye-frames")


FRAME_DELAY = 0.09


def get_setting(key):
    return subprocess.check_output(
        ["gsettings", "get", "org.gnome.desktop.background", key]
    ).decode().strip()


def set_wallpaper(uri):
    subprocess.run(
        ["gsettings", "set", "org.gnome.desktop.background", "picture-uri", uri],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )


original_wallpaper = get_setting("picture-uri")
original_option = get_setting("picture-options")

frames = sorted(
    f for f in os.listdir(FRAME_DIR)
    if f.lower().endswith((".jpg", ".jpeg", ".png"))
)

try:
    for frame in frames:
        path = os.path.abspath(os.path.join(FRAME_DIR, frame))
        uri = "file://" + path

        set_wallpaper(uri)
        time.sleep(FRAME_DELAY)

finally:
    subprocess.run(
        ["gsettings", "set", "org.gnome.desktop.background", "picture-uri", original_wallpaper]
    )

    subprocess.run(
        ["gsettings", "set", "org.gnome.desktop.background", "picture-options", original_option]
    )

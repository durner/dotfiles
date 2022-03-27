#!/bin/bash
# based on @domanpanda on reddit
# https://www.reddit.com/r/kde/comments/ofovbu/how_to_set_scaling_on_boot_with_some_conditions/
# based on jbouter post on kde forum
# https://forum.kde.org/viewtopic.php?f=17&t=164455#

CURSOR_CONFIG="${HOME}/.config/kcminputrc"
SCALING_CONFIG="${HOME}/.config/kdeglobals"
FONT_CONFIG="${HOME}/.config/kcmfonts"

# default settings for 100% scale
CURSOR_SIZE="24"
SCALING="1"
FORCE_FONT_DPI="96"
SCREEN_SCALE_FACTORS="eDP-1=1;HDMI-1=1;DP-1=1;"

if lsusb | grep "Microsoft"
then
    echo "Microsoft keyboard present"
    # settings for 150% scale
    CURSOR_SIZE="30"
    SCALING="1.5"
    FORCE_FONT_DPI="144"
    SCREEN_SCALE_FACTORS="eDP-1=1.5;HDMI-1=1.5;DP-1=1.5;"
fi

kwriteconfig5 --file $CURSOR_CONFIG --group "Mouse" --key "cursorSize" "$CURSOR_SIZE"
kwriteconfig5 --file $SCALING_CONFIG --group "KScreen" --key "ScaleFactor" "$SCALING"
kwriteconfig5 --file $SCALING_CONFIG --group "KScreen" --key "ScreenScaleFactors" "$SCREEN_SCALE_FACTORS"
kwriteconfig5 --file $FONT_CONFIG --group "General" --key "forceFontDPI" "$FORCE_FONT_DPI"

exit 0

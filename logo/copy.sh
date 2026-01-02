#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# There are a bunch of places images are stored in the project 
#
# Android 
# app/android/app/src/main/res/
# mipmap-mdpi/ic_launcher.png:    PNG image data, 48 x 48, 8-bit colormap, non-interlaced
# mipmap-hdpi/ic_launcher.png:    PNG image data, 72 x 72, 8-bit colormap, non-interlaced
# mipmap-xhdpi/ic_launcher.png:   PNG image data, 96 x 96, 8-bit colormap, non-interlaced
# mipmap-xxhdpi/ic_launcher.png:  PNG image data, 144 x 144, 8-bit colormap, non-interlaced
# mipmap-xxxhdpi/ic_launcher.png: PNG image data, 192 x 192, 8-bit colormap, non-interlaced

ANDROID_BASE=../app/android/app/src/main/res/

# Android 
cp logo_48.png $ANDROID_BASE/mipmap-mdpi/ic_launcher.png
cp logo_72.png $ANDROID_BASE/mipmap-hdpi/ic_launcher.png
cp logo_96.png $ANDROID_BASE/mipmap-xhdpi/ic_launcher.png
cp logo_144.png $ANDROID_BASE/mipmap-xxhdpi/ic_launcher.png
cp logo_192.png $ANDROID_BASE/mipmap-xxxhdpi/ic_launcher.png

WEB_BASE=../app/web/

# Web 
cp logo_192.png $WEB_BASE/icons/Icon-192.png
cp logo_512.png $WEB_BASE/icons/Icon-512.png
cp logo_192.png $WEB_BASE/icons/Icon-maskable-192.png
cp logo_512.png $WEB_BASE/icons/Icon-maskable-512.png
cp logo_16.png $WEB_BASE/favicon.png



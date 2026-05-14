#!/bin/bash

set -e

# --- Rose Pine GTK3 Theming ---
mkdir -p ~/.themes ~/.tmp/gtk3_extract
cd ~/.tmp/gtk3_extract

GTK3_TARBALL="gtk3.tar.gz"
curl -fLO --progress-bar --retry 5 https://github.com/rose-pine/gtk/releases/latest/download/$GTK3_TARBALL

tar -xzf "$GTK3_TARBALL" -C .
rm "$GTK3_TARBALL"

find . -maxdepth 2 -type d \( -name "rose-pine-gtk" -o -name "rose-pine-*-gtk" \) -exec mv {} ~/.themes/ \; 2>/dev/null || true

cd ~
rm -rf ~/.tmp/gtk3_extract

# --- Rose Pine GTK4 Theming ---
mkdir -p ~/.config/gtk-4.0 ~/.tmp/gtk4_extract
cd ~/.tmp/gtk4_extract

GTK4_TARBALL="gtk4.tar.gz"
curl -fLO --progress-bar --retry 5 https://github.com/rose-pine/gtk/releases/latest/download/$GTK4_TARBALL

tar -xzf "$GTK4_TARBALL" -C .
rm "$GTK4_TARBALL"

GTK4_SOURCE_DIR=$(find . -maxdepth 2 -type d -name "gtk-4.0" | head -n 1)

if [ -n "$GTK4_SOURCE_DIR" ]; then
    cp -r "$GTK4_SOURCE_DIR"/assets ~/.config/gtk-4.0/ 2>/dev/null || true
    cp -f "$GTK4_SOURCE_DIR"/gtk.css ~/.config/gtk-4.0/ 2>/dev/null || true
    cp -f "$GTK4_SOURCE_DIR"/gtk-dark.css ~/.config/gtk-4.0/ 2>/dev/null || true
fi

cd ~
rm -rf ~/.tmp/gtk4_extract

# --- Rose Pine Icons ---
mkdir -p ~/.icons
cd ~/.icons
if [ ! -d "rose-pine-icons" ]; then
    ICONS_TARBALL="rose-pine-icons.tar.gz"
    curl -fLO --progress-bar --retry 5 https://github.com/rose-pine/gtk/releases/latest/download/$ICONS_TARBALL
    
    mkdir -p ~/.tmp/icons_extract
    tar -xzf "$ICONS_TARBALL" -C ~/.tmp/icons_extract
    rm "$ICONS_TARBALL"

    find ~/.tmp/icons_extract -maxdepth 2 -type d -name "rose-pine-icons" -exec mv {} . \; 2>/dev/null || true
    rm -rf ~/.tmp/icons_extract
fi
cd ~

# --- Rose Pine Cursor ---
CURSOR_THEME_NAME="BreezeX-RosePine-Linux"
CURSOR_DOWNLOAD_URL="https://github.com/rose-pine/cursor/releases/download/v1.1.0/BreezeX-RosePine-Linux.tar.xz"
CURSOR_FILENAME="BreezeX-RosePine-Linux.tar.xz"
CURSOR_INSTALL_DIR="$HOME/.local/share/icons"

mkdir -p "$CURSOR_INSTALL_DIR"
cd "$CURSOR_INSTALL_DIR"
if [ ! -d "$CURSOR_THEME_NAME" ]; then
    curl -fLO --progress-bar --retry 5 "$CURSOR_DOWNLOAD_URL"
    tar -xf "$CURSOR_FILENAME" -C .
    rm "$CURSOR_FILENAME"
fi
cd ~

# --- Update GTK settings files ---
mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0

ini_gtk3=~/.config/gtk-3.0/settings.ini
mkdir -p "$(dirname "$ini_gtk3")"
if [ -f "$ini_gtk3" ]; then
    grep -q "gtk-theme-name" "$ini_gtk3" && \
        sed -i 's/^gtk-theme-name=.*/gtk-theme-name=rose-pine-gtk/' "$ini_gtk3" || \
        echo "gtk-theme-name=rose-pine-gtk" >> "$ini_gtk3"
    grep -q "gtk-icon-theme-name" "$ini_gtk3" && \
        sed -i 's/^gtk-icon-theme-name=.*/gtk-icon-theme-name=rose-pine-icons/' "$ini_gtk3" || \
        echo "gtk-icon-theme-name=rose-pine-icons" >> "$ini_gtk3"
    grep -q "gtk-cursor-theme-name" "$ini_gtk3" && \
        sed -i "s/^gtk-cursor-theme-name=.*/gtk-cursor-theme-name=$CURSOR_THEME_NAME/" "$ini_gtk3" || \
        echo "gtk-cursor-theme-name=$CURSOR_THEME_NAME" >> "$ini_gtk3"
else
    echo "[Settings]" > "$ini_gtk3"
    echo "gtk-theme-name=rose-pine-gtk" >> "$ini_gtk3"
    echo "gtk-icon-theme-name=rose-pine-icons" >> "$ini_gtk3"
    echo "gtk-cursor-theme-name=$CURSOR_THEME_NAME" >> "$ini_gtk3"
fi

ini_gtk4=~/.config/gtk-4.0/settings.ini
mkdir -p "$(dirname "$ini_gtk4")"
if [ -f "$ini_gtk4" ]; then
    grep -q "gtk-cursor-theme-name" "$ini_gtk4" && \
        sed -i "s/^gtk-cursor-theme-name=.*/gtk-cursor-theme-name=$CURSOR_THEME_NAME/" "$ini_gtk4" || \
        echo "gtk-cursor-theme-name=$CURSOR_THEME_NAME" >> "$ini_gtk4"
    grep -q "gtk-application-prefer-dark-theme" "$ini_gtk4" || echo "gtk-application-prefer-dark-theme=true" >> "$ini_gtk4"
else
    echo "[Settings]" > "$ini_gtk4"
    echo "gtk-cursor-theme-name=$CURSOR_THEME_NAME" >> "$ini_gtk4"
    echo "gtk-application-prefer-dark-theme=true" >> "$ini_gtk4"
fi

# --- Set cursor for X11/Wayland ---
gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_THEME_NAME" 2>/dev/null || true
grep -q "export XCURSOR_THEME=$CURSOR_THEME_NAME" ~/.profile || echo "export XCURSOR_THEME=$CURSOR_THEME_NAME" >> ~/.profile

# --- Update icon cache ---
gtk-update-icon-cache -f -t ~/.icons/rose-pine-icons || true
gtk-update-icon-cache -f -t "$CURSOR_INSTALL_DIR/$CURSOR_THEME_NAME" || true
gtk-update-icon-cache -f ~/.icons/rose-pine-icons || true
gtk-update-icon-cache -f "$CURSOR_INSTALL_DIR/$CURSOR_THEME_NAME" || true

echo "Visuals and fonts setup complete! You may want to log out and back in, or reboot, to ensure all theming is applied."

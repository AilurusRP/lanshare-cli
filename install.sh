#!/bin/sh

APP_NAME="lanshare-cli"
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
TARGET_DIR="/opt/lanshare-cli"

rm -rf "$TARGET_DIR"
mkdir -p "$TARGET_DIR"

for item in "$SCRIPT_DIR"/*; do
  base="$(basename '$item')"
  [ "$base" = "install.sh" ] && continue
  cp -a "$item" "$TARGET_DIR"/
done

MAIN_BIN="$TARGET_DIR/$APP_NAME"
chmod +x  "$MAIN_BIN"
ln -sf "$MAIN_BIN" "/usr/local/bin/$APP_NAME"


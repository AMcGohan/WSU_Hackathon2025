#!/bin/sh
echo -ne '\033c\033]0;SpeedyDungeon\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/SpeedyDungeon.x86_64" "$@"

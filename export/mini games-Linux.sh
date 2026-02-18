#!/bin/sh
echo -ne '\033c\033]0;mini games\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/mini games-Linux.x86_64" "$@"

#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

package_field() {
    sed -n "/^\[package\]/,/^\[/ { s/^$2 *= *\"\([^\"]*\)\".*/\1/p; }" "$1"
}

if [ "${1:-}" = "--list" ]; then
    for manifest in "$repo_dir"/templates/*/typst.toml; do
        name=$(package_field "$manifest" name)
        version=$(package_field "$manifest" version)
        printf '%s %s\n' "$name" "$version"
    done
    exit 0
fi

if [ -n "${TYPST_PACKAGE_PATH:-}" ]; then
    package_dir=$TYPST_PACKAGE_PATH
elif [ "$(uname -s)" = "Darwin" ]; then
    package_dir="$HOME/Library/Application Support/typst/packages"
else
    package_dir="${XDG_DATA_HOME:-$HOME/.local/share}/typst/packages"
fi

if [ "$#" -eq 0 ]; then
    set -- "$repo_dir"/templates/*
fi

for template in "$@"; do
    source_dir="$repo_dir/templates/$(basename -- "$template")"
    manifest="$source_dir/typst.toml"
    if [ ! -f "$manifest" ]; then
        printf '没有模板：%s；使用 --list 查看可选模板。\n' "$template" >&2
        exit 1
    fi
    name=$(package_field "$manifest" name)
    version=$(package_field "$manifest" version)
    destination="$package_dir/local/$name/$version"
    if [ -d "$destination" ]; then
        rm -r -- "$destination"
    fi
    mkdir -p -- "$destination"
    cp -R "$source_dir/." "$destination/"
    printf '已安装 @local/%s:%s\n  %s\n' "$name" "$version" "$destination"
done

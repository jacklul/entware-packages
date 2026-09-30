#!/usr/bin/env bash

if [ ! -f feeds.conf ]; then
    echo "Executed from a wrong directory ($PWD) - must be inside Entware repository!" >&2
    exit 1
fi

#shellcheck disable=SC2155
readonly ROOT_DIR="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/../")"

if [ -f "$ROOT_DIR/entware.config" ]; then
    echo "Appending to .config:"
    tee -a .config < "$ROOT_DIR/entware.config"
fi

if [ -d "$ROOT_DIR/.overrides" ]; then # better to use patches instead!
    cp -rfv "$ROOT_DIR/.overrides"/. .
fi

for arg in "$@"; do
    case "$arg" in
        unbound)
            git -C feeds/packages apply -v "$ROOT_DIR/.patches/unbound.patch"
        ;;
        transmission)
            if [[ $# -ne 1 ]]; then
                echo "Transmission cannot be compiled together with other packages!" >&2
                exit 1
            fi

            git apply -v "$ROOT_DIR/.patches/transmission-entware.patch"
            git -C feeds/packages apply -v "$ROOT_DIR/.patches/transmission-package.patch"
            make defconfig
            echo "-transmission" > .cache_key
        ;;
    esac
done

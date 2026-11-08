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

if [[ " $* " == *" openssl "* ]]; then # apply OpenSSL patch when needed by other packages
	git apply -v "$ROOT_DIR/.patches/openssl.patch"
fi

for arg in "$@"; do
    case "$arg" in
        curl)
            git -C feeds/packages apply -v "$ROOT_DIR/.patches/curl.patch"
        ;;
		nginx)
            git -C feeds/packages apply -v "$ROOT_DIR/.patches/nginx.patch"
		;;
		php8)
            git -C feeds/packages apply -v "$ROOT_DIR/.patches/php8.patch"
		;;
        transmission)
            if [[ " $* " == *" transmission-4.0.5 "* ]]; then
                git -C feeds/packages apply -v "$ROOT_DIR/.patches/transmission-4.0.5.patch"
                break
            fi

            if [[ $# -ne 1 ]]; then
                echo "Transmission 4.1+ cannot be compiled together with other packages!" >&2
                exit 1
            fi

            git apply -v "$ROOT_DIR/.patches/transmission-entware.patch"
            git -C feeds/packages apply -v "$ROOT_DIR/.patches/transmission-packages.patch"
            make defconfig
            echo "-transmission" > .cache_key # different build of tools and toolchain!
        ;;
        unbound)
            git -C feeds/packages apply -v "$ROOT_DIR/.patches/unbound.patch"
        ;;
    esac
done

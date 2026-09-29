#!/bin/bash

#shellcheck disable=SC2155
readonly self_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

rm -fv "$self_dir/feeds/packages/net/transmission/patches/010-temp-miniupnpc-2.2.8-compile.patch"

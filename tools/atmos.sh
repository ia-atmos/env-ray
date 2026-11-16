#!/bin/sh
# Builds an Atmos program of this environment:
#
#   tools/atmos.sh <file.atm> <out>
#
# with build/atmos-ray, the compiler of tools/setup.sh that includes ray.atm
# before the program and links raylib. ASAN=1 builds with the address
# sanitizer.

ROOT=$(cd "$(dirname "$0")/.." && pwd)
[ -n "$ASAN" ] && export ATMOS_ASAN=1
ATMOS_CFLAGS="${ATMOS_CFLAGS:--O2}" "$ROOT/build/atmos-ray" -o "$2" "$1"

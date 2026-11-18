#!/bin/sh
# Fetches and builds, in ext/ (ignored by git), what the port needs:
#
#   ext/raylib          raylib 6.2 with tools/raylib.patch (the test mode),
#                       built for the platform with no screen:
#                       ext/raylib/build-mem/libraylib.a
#   ext/raylib-games    the original games, at the commit of the target
#   ext/ceu-atmos       the Atmos compiler, at the commit ATMOS_REV: ext/ceu-atmos/atmos
#   build/atmos-ray     the compiler of this environment (ray.atm included)
#
# It may run again: what is already there is kept, and only rebuilt.

set -e
cd "$(dirname "$0")/.."
ROOT=$(pwd)
mkdir -p ext

RAYLIB_TAG=6.2
GAMES_REV=318688c
ATMOS_REV=8c9453c                       # the rules of pin, stable (main, 2026-11-18)

if [ ! -d ext/raylib ]; then
    git clone -q --depth 1 --branch $RAYLIB_TAG https://github.com/raysan5/raylib ext/raylib
fi
if [ ! -d ext/raylib-games ]; then
    git clone -q https://github.com/raysan5/raylib-games ext/raylib-games
    git -C ext/raylib-games checkout -q $GAMES_REV
fi
if [ ! -d ext/ceu-atmos ]; then
    git clone -q https://github.com/ia-atmos/lang ext/ceu-atmos
    git -C ext/ceu-atmos checkout -q $ATMOS_REV
fi

# raylib: the patch, unless it is already applied
if ! git -C ext/raylib apply --check --reverse "$ROOT/tools/raylib.patch" 2>/dev/null; then
    git -C ext/raylib apply "$ROOT/tools/raylib.patch"
fi
mkdir -p ext/raylib/build-mem
make -s -C ext/raylib/src PLATFORM=PLATFORM_MEMORY CUSTOM_CFLAGS=-O2 \
    RAYLIB_RELEASE_PATH="$ROOT/ext/raylib/build-mem" -j4 >/dev/null 2>&1 \
    || { echo "setup: raylib failed to build" >&2; exit 1; }

# the compiler, and the compiler of this environment (build/atmos-ray): the
# Atmos compiler with ray.atm included before every program, and the flags
# of raylib
make -s -C ext/ceu-atmos >/dev/null
mkdir -p build
RL="$ROOT/ext/raylib"
make -s -C ext/ceu-atmos env OUT="$ROOT/build/atmos-ray" ENV="$ROOT/ray.atm" \
    ENV_CFLAGS="-I$RL/src -I$RL/examples/shapes" \
    ENV_LDFLAGS="$RL/build-mem/libraylib.a -lm -lpthread -ldl" >/dev/null \
    || { echo "setup: atmos-ray failed to build" >&2; exit 1; }

echo "setup: ok"

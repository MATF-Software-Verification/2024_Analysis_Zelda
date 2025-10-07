#!/bin/bash

# Relativne putanje:
DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$DIR/../zelda/cmake-build-debug"

# Nazivi izlaznih fajlova sa datumom
DATE=$(date +%Y-%m-%d_%H-%M-%S)
OUT="$DIR/clang_tidy_$DATE.txt"
FIX="$DIR/clang_fixes_$DATE.yaml"

# Skup provera koje clang-tidy pokreće
CHECKS='clang-diagnostic-*,clang-analyzer-*,modernize-*,performance-*,readability-*,bugprone-*'

# Provera da li je clang-tools instaliran
command -v run-clang-tidy >/dev/null || { echo "Instaliraj: sudo apt install clang-tools"; exit 1; }

# Provera da li postoji compile_commands.json
[[ -f "$BUILD_DIR/compile_commands.json" ]] || { echo "Nema compile_commands.json u $BUILD_DIR"; exit 1; }

# Pokretanje analize
run-clang-tidy -p="$BUILD_DIR" -checks="$CHECKS" -header-filter='.*' -export-fixes="$FIX" | tee "$OUT"




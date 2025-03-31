#!/bin/bash

if ! command -v clang-tidy &> /dev/null; then
    echo "clang-tidy nije instaliran. Instalirati  ga pomoću 'sudo apt install clang-tidy' i pokušati ponovo."
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$(realpath "$SCRIPT_DIR/cmake-build-debug")"
SRC_DIR="$(realpath "$SCRIPT_DIR/..")"

if [ ! -f "$BUILD_DIR/compile_commands.json" ]; then
    echo "Nije pronađen fajl compile_commands.json u $BUILD_DIR. Uveriti se da je CMake podešen sa -DCMAKE_EXPORT_COMPILE_COMMANDS=ON."
    exit 1
fi

echo "Pokretanje clang-tidy analize..."
run-clang-tidy -checks='clang-diagnostic-*,clang-analyzer-*,modernize-use-auto,modernize-use-nullptr,modernize-use-noexcept,modernize-use-emplace,modernize-use-emplace-back,modernize-loop-convert,modernize-use-using' -p "$BUILD_DIR" "$SRC_DIR" > clang-tidy-report.txt 2>&1

if [ -f clang-tidy-report.txt ]; then
    echo "Analiza je uspešno završena. Izveštaj je sačuvan u fajlu clang-tidy-report.txt"
else
    echo "Došlo je do greške tokom analize."
fi


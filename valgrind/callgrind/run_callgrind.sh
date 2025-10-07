#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
WORK_DIR="$DIR/../../zelda"
EXE="$WORK_DIR/cmake-build-debug/zelda"

pid=$$
CALL_OUT="$DIR/callgrind_output_$pid.out"
ANNOT_OUT="$DIR/callgrind_annotate_$pid.txt"

[[ -x "$EXE" ]] || { echo "Nema izvršnog fajla: $EXE"; exit 1; }

(
  cd "$WORK_DIR" || exit 1
  valgrind --tool=callgrind --callgrind-out-file="$CALL_OUT" "$EXE"
)

[[ -f "$CALL_OUT" ]] || { echo "Callgrind izlaz nije kreiran"; exit 1; }
callgrind_annotate --auto=yes "$CALL_OUT" > "$ANNOT_OUT"
echo "Izlaz: $CALL_OUT"
echo "Annotate: $ANNOT_OUT"

if command -v kcachegrind >/dev/null; then kcachegrind "$CALL_OUT" & fi


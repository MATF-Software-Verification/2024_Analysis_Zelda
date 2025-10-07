#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
work_dir="$SCRIPT_DIR/../../zelda"
exe_path="$work_dir/cmake-build-debug/zelda"   # malo slovo!

pid=$$
memcheck_output_file="memcheck_output_$pid.txt"

# Pokreni iz radnog direktorijuma
(
  cd "$work_dir" || exit 1
  G_SLICE=always-malloc MALLOC_CHECK_=3 valgrind --tool=memcheck \
    --leak-check=summary --show-leak-kinds=reachable \
    --track-origins=no --num-callers=10 --partial-loads-ok=yes \
    --log-file="$SCRIPT_DIR/$memcheck_output_file" "$exe_path" &
  valgrind_pid=$!
  wait $valgrind_pid
)

if [ -f "$SCRIPT_DIR/$memcheck_output_file" ]; then
  echo "Memcheck analiza završena. Izlaz: $memcheck_output_file"
else
  echo "Greška: Memcheck izlaz nije kreiran!"; exit 1
fi

echo "Rezime Memcheck analize:"
grep -E "ERROR SUMMARY|definitely lost|indirectly lost|possibly lost" "$SCRIPT_DIR/$memcheck_output_file" || true
echo "Analiza završena."
exit 0


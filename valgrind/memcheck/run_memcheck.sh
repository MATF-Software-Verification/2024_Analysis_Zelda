#!/bin/bash


src_dir="/home/vuk/Desktop/Zelda/cmake-build-debug"

# Generisanje jedinstvenog PID-a za izlazne fajlove
pid=$$

# Naziv izlaznog fajla za Memcheck
memcheck_output_file="memcheck_output_$pid.txt"

# Pokretanje Memcheck-a sa minimalnim usporavanjem
G_SLICE=always-malloc MALLOC_CHECK_=3 valgrind --tool=memcheck \
    --leak-check=summary --show-leak-kinds=reachable \
    --track-origins=no --num-callers=10 --partial-loads-ok=yes \
    --log-file="$memcheck_output_file" "$src_dir/Zelda" &

valgrind_pid=$!



# Čekamo da se igra završi
wait $valgrind_pid

# Proveravanje izlaznog faj;a
if [ -f "$memcheck_output_file" ]; then
    echo "Memcheck analiza završena. Izlaz sačuvan u: $memcheck_output_file"
else
    echo "Greška: Memcheck izlaz nije kreiran!"
    exit 1
fi

# Ispisivanje rezime-a curenja memorije
echo "Rezime Memcheck analize:"
grep -"ERROR SUMMARY|definitely lost|indirectly lost|possibly lost" "$memcheck_output_file"

echo "Analiza završena."
exit 0

#!/bin/bash

# Definisanje direktorijuma gde se nalazi izvršni fajl
src_dir="/home/vuk/Desktop/Zelda/cmake-build-debug"

# Generisanje jedinstvenog PID-a za izlazne fajlove
pid=$$

# Nazivi izlaznih fajlova
callgrind_output_file="callgrind_output_$pid.out"
callgrind_annotate_output_file="callgrind_annotate_output_$pid.txt"

# Pokrećetanje Valgrind Callgrinda na izvršnoj datoteci
valgrind --tool=callgrind --callgrind-out-file="$callgrind_output_file" "$src_dir/Zelda"


if [ -f "$callgrind_output_file" ]; then
    echo "Kreiran Callgrind izlaz: $callgrind_output_file"
else
    echo "Greška: Callgrind izlaz nije kreiran!"
    exit 1
fi

# Analiziranje Callgrinda izlaza i čuvanje annotate fajla
callgrind_annotate --auto=yes "$callgrind_output_file" > "$callgrind_annotate_output_file"

# Provera da li je annotate fajl uspešno kreiran
if [ -f "$callgrind_annotate_output_file" ]; then
    echo "Kreiran Callgrind annotate izlaz: $callgrind_annotate_output_file"
else
    echo "Greška: Annotate izlaz nije kreiran!"
    exit 1
fi

# Pokretanje
if command -v kcachegrind &> /dev/null; then
    echo "Pokretanje kcachegrinda..."
    kcachegrind "$callgrind_output_file" &
else
    echo " kcachegrind nije instaliran. Instaliranje pomocu komande: sudo apt install kcachegrind"
fi

echo "Analiza završena."

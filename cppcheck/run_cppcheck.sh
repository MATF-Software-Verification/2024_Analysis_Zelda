#!/bin/bash

# Provera da li je Cppcheck instaliran
if ! command -v cppcheck &> /dev/null; then
    echo "Cppcheck nije instaliran. Instalirati ga pomoću 'sudo apt install cppcheck' i pokušati ponovo."
    exit 1
fi


PROJECT_PATH="../zelda/src"
OUTPUT_TXT="cpp_check_res.txt"  


echo "Pokrećem Cppcheck za projekt: $PROJECT_PATH..."
cppcheck --enable=all --inconclusive --suppress=missingInclude "$PROJECT_PATH" 2> "$OUTPUT_TXT"


if [ ! -f "$OUTPUT_TXT" ]; then
    echo "Cppcheck nije uspeo da kreira tekstualni fajl. Proverite greške."
    exit 1
fi

echo "Izveštaj je uspešno kreiran: $OUTPUT_TXT"



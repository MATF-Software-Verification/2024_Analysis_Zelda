#!/bin/bash

DOXYFILE="doxyfile"

# Provera da li je Doxygen instaliran
if ! command -v doxygen &> /dev/null; then
    echo "Doxygen nije instaliran. Instaliram ga sada..."
    sudo apt update && sudo apt install -y doxygen
else
    echo "Doxygen je već instaliran."
fi

# Provera da li fajl "doxyfile" postoji, ako ne, generišemo ga
if [ ! -f "$DOXYFILE" ]; then
    echo "Generisanje osnovnog doxyfile konfiguracionog fajla..."
    doxygen -g "$DOXYFILE"
    echo "Doxyfile je generisan."
fi

# Otvaranje doxyfile u GNOME Text Editoru (ili bilo kom podrazumevanom GUI editoru)
echo "Otvaranje doxyfile u Text Editoru..."
if command -v gnome-text-editor &> /dev/null; then
    gnome-text-editor "$DOXYFILE"  # Otvara u GNOME Text Editoru
elif command -v xdg-open &> /dev/null; then
    xdg-open "$DOXYFILE"  # Otvara u podrazumevanom GUI editoru
else
    echo "Otvaranje u terminalu"
    nano "$DOXYFILE"
fi

# Čekanje da korisnik zatvori editor pre pokretanja doxygen-a

while pgrep -x "gnome-text-editor" > /dev/null; do sleep 1; done



doxygen "$DOXYFILE"

echo "Generisanje dokumentacije je završeno!"

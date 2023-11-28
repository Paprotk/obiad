#!/bin/bash

# Pobierz aktualną datę w formacie RRMMDDEE
now=$(date +"%y%m%d")

# Folder archiwum
archiwum_folder="archiwum"

# Sprawdź, czy folder archiwum istnieje, jeśli nie, utwórz go
if [ ! -d "$archiwum_folder" ]; then
    mkdir "$archiwum_folder"
fi

# Zmienna do śledzenia czy znaleziono pliki do przeniesienia
found_files=false

# Przenieś pliki .png i .jpg, które nie mają dzisiejszej daty w nazwie, do folderu archiwum
for file in *.png *.jpg; do
    if [ -f "$file" ]; then
        # Sprawdź, czy nazwa pliku nie zawiera dzisiejszej daty
        if ! [[ "$file" == *"$now"* ]]; then
            mv "$file" "$archiwum_folder/"
            echo "Przeniesiono plik $file do folderu archiwum."
            found_files=true
        fi
    fi
done

# Sprawdź, czy znaleziono pliki do przeniesienia
if [ "$found_files" = false ]; then
    echo "Nie znaleziono plików do przeniesienia. Skrypt zatrzymany."
    exit 1
fi

# Przejście do katalogu repozytorium Git
cd ~/Desktop/obiad

# Dodaj wszystkie zmiany
git add .

# Utwórz commit z wiadomością
git commit -m "Przeniesiono plik $file do folderu archiwum."

# Wypchnij zmiany na GitHub
git push origin main


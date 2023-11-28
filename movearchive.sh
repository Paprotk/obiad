#!/bin/bash

# Pobierz aktualną datę w formacie RRMMDDEE
now=$(date +"%y%m%d")

# Folder archiwum
archiwum_folder="archiwum"

# Sprawdź, czy folder archiwum istnieje, jeśli nie, utwórz go
if [ ! -d "$archiwum_folder" ]; then
    mkdir "$archiwum_folder"
fi

# Przenieś pliki .png i .jpg, które nie mają dzisiejszej daty w nazwie, do folderu archiwum
for file in *.png *.jpg; do
    if [ -f "$file" ]; then
        # Sprawdź, czy nazwa pliku nie zawiera dzisiejszej daty
        if ! [[ "$file" == *"$now"* ]]; then
            mv "$file" "$archiwum_folder/"
            echo "Przeniesiono plik $file do folderu archiwum."
        fi
    fi
done

# Przejście do katalogu repozytorium Git
cd ~/Desktop/obiad

# Dodaj wszystkie zmiany
git add .

# Utwórz commit z wiadomością
git commit -m "Przeniesiono plik $file do folderu archiwum."

# Wypchnij zmiany na GitHub
git push origin main

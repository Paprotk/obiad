#!/bin/bash

# Katalog archiwum
archive_dir=/home/arek/Desktop/obiad/archive

# Sprawdź, czy istnieje katalog archiwum, jeśli nie, utwórz go
if [ ! -d "$archive_dir" ]; then
    mkdir "$archive_dir"
fi

# Znajdź pliki z rozszerzeniem .png i .jpg
for file in *.png *.jpg; do
    if [ -f "$file" ]; then
        # Sprawdź, czy nazwa pliku już zawiera datę
        if ! [[ "$file" =~ ^[0-9]{6}\.[a-zA-Z]+$ ]]; then
            # Pobierz aktualną datę w formacie RRMMDDEE
            now=$(date +"%y%m%d")
            
            # Pobierz oryginalne rozszerzenie pliku
            extension="${file##*.}"
            
            # Stwórz nową nazwę pliku z oryginalnym rozszerzeniem na końcu
            new_name="${now}.${extension}"
            
            # Jeśli data w nazwie pliku nie jest dzisiejsza, przenieś do archiwum
            if [ ! "$now" == "$(date +"%y%m%d" -d "@$(stat -c %Y "$file")")" ]; then
                mv "$file" "$archive_dir/$file"
                echo "Plik $file przeniesiony do archiwum."
            else
                mv "$file" "$new_name"
                echo "Zmieniono nazwę pliku $file na: $new_name"
            fi
        else
            echo "Plik $file już zawiera datę w nazwie. Nie zmieniam nazwy."
        fi
    fi
done

# Przejście do katalogu repozytorium Git
cd /home/arek/Desktop/obiad

# Dodaj wszystkie zmiany
git add .

# Utwórz commit z wiadomością
git commit -m "Zmieniono nazwę na dzisiejszą datę"

# Wypchnij zmiany na GitHub
git push origin main


#!/bin/bash

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
            
            mv "$file" "$new_name"
            echo "Zmieniono nazwę pliku $file na: $new_name"
        else
            echo "Plik $file już zawiera datę w nazwie. Nie zmieniam nazwy."
        fi
    fi
done

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


# Przejście do katalogu repozytorium Git
cd ~/Desktop/obiad

# Dodaj wszystkie zmiany
git add .

# Utwórz commit z wiadomością
git commit -m "Zmieniono nazwę na dzisiejszą datę"

# Wypchnij zmiany na GitHub
git push origin main


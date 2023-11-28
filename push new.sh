#!/bin/bash

# Pobierz aktualną datę w formacie RRMMDDEE
now=$(date +"%y%m%d")

# Stwórz nową nazwę pliku
new_name="${now}.png"

# Zmień nazwę pliku 1.png na nową nazwę
mv 1.png "$new_name"

echo "Zmieniono nazwę pliku na: $new_name"

# Sprawdź, czy folder archiwum istnieje, jeśli nie, utwórz go
archive_folder="archiwum"
if [ ! -d "$archive_folder" ]; then
    mkdir "$archive_folder"
fi

# Przenieś plik do folderu archiwum
mv "$new_name" "$archive_folder/"

echo "Plik przeniesiony do folderu archiwum: $archive_folder/$new_name"

# Przejście do katalogu repozytorium Git
 cd ~/Desktop/obiad

# Dodaj wszystkie zmiany
git add .

# Utwórz commit z wiadomością
git commit -m "Aktualizacja pliku $new_name i przeniesienie do archiwum"

# Wypchnij zmiany na GitHub
git push origin main

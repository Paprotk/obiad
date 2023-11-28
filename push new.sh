#!/bin/bash

# Pobierz aktualną datę w formacie RRMMDDEE
now=$(date +"%y%m%d")

# Znajdź pliki z rozszerzeniem .png i .jpg, a następnie stwórz nową nazwę pliku
for file in *.png *.jpg; do
    if [ -f "$file" ]; then
        # Pobierz oryginalne rozszerzenie pliku
        extension="${file##*.}"
        
        # Stwórz nową nazwę pliku z oryginalnym rozszerzeniem na końcu
        new_name="${now}.${extension}"
        
        mv "$file" "$new_name"
        echo "Zmieniono nazwę pliku $file na: $new_name"
    fi
done


# Sprawdź, czy folder archiwum istnieje, jeśli nie, utwórz go
#archive_folder="archiwum"
#if [ ! -d "$archive_folder" ]; then
#    mkdir "$archive_folder"
#fi

# Przenieś plik do folderu archiwum
#mv "$new_name" "$archive_folder/"

#echo "Plik przeniesiony do folderu archiwum: $archive_folder/$new_name"

# Przejście do katalogu repozytorium Git
# cd ~/Desktop/obiad

# Dodaj wszystkie zmiany
#git add .

# Utwórz commit z wiadomością
#git commit -m "Aktualizacja pliku $new_name i przeniesienie do archiwum"

# Wypchnij zmiany na GitHub
#git push origin main

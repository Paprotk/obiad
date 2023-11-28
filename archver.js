function moveFirstPNGToArchive() {
    const tokenInput = document.getElementById('tokenInput');
    const token = tokenInput.value.trim();
    const repoOwner = 'paprotk';
    const repoName = 'obiad';
    const mainFolder = '';
    const archiveFolder = 'archiwum';

    // Get the list of files in the main folder
    fetch(`https://api.github.com/repos/${repoOwner}/${repoName}/contents/${mainFolder}`, {
        headers: {
            'Authorization': `token ${token}`,
        },
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`GitHub API request failed with status: ${response.status}`);
        }
        return response.json();
    })
    .then(files => {
        // Check if files is an array
        if (!Array.isArray(files)) {
            console.error('Invalid response. Expected an array of files.');
            console.log('Actual response:', files);
            return;
        }

        const firstPNG = files.find(file => file.type === 'file' && file.name.toLowerCase().endsWith('.jpg'));

        if (!firstPNG) {
            alert('Brak plików JPG do przeniesienia.');
            return;
        }

        const fileName = firstPNG.name;
        const mainFolderFilePath = mainFolder ? `${mainFolder}/${fileName}` : fileName;
        const mainFolderFileUrl = `https://api.github.com/repos/${repoOwner}/${repoName}/contents/${mainFolderFilePath}`;
        const moveUrl = `https://api.github.com/repos/${repoOwner}/${repoName}/contents/${archiveFolder}/${fileName}`;

        // Get the content of the file in the main folder
        fetch(mainFolderFileUrl, {
            headers: {
                'Authorization': `token ${token}`,
            },
        })
        .then(response => response.json())
        .then(data => {
            const content = data.content;
            const message = 'Przeniesiono plik do archiwum';

            // Move the file to the archive folder
            fetch(moveUrl, {
                method: 'PUT',
                headers: {
                    'Authorization': `token ${token}`,
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    message,
                    content,
                }),
            })
            .then(response => response.json())
            .then(data => {
                console.log('Plik przeniesiony pomyślnie:', data);

                // Delete the file from the main folder
                fetch(mainFolderFileUrl, {
                    method: 'DELETE',
                    headers: {
                        'Authorization': `token ${token}`,
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        message: 'Usunięto plik z głównego folderu',
                        sha: firstPNG.sha, // Include the SHA of the file for verification
                    }),
                })
                .then(response => response.json())
                .then(deletedData => {
                    console.log('Plik usunięty pomyślnie z głównego folderu:', deletedData);
                })
                .catch(error => {
                    console.error('Błąd podczas usuwania pliku z głównego folderu:', error);
                });
            })
            .catch(error => {
                console.error('Błąd podczas przenoszenia pliku:', error);
            });
        })
        .catch(error => {
            console.error('Błąd podczas pobierania danych o pliku:', error);
        });
    })
    .catch(error => {
        console.error('Błąd podczas pobierania listy plików:', error);
    });
}

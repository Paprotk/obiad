function uploadFile() {
    const tokenInput = document.getElementById('tokenInput');
    const fileInput = document.getElementById('fileInput');
    const file = fileInput.files[0];

    const token = tokenInput.value.trim();

    if (!token) {
        alert('Wprowadź token dostępu GitHub.');
        return;
    }

    const repoOwner = 'paprotk';
    const repoName = 'obiad';

    const currentDate = new Date();
    const year = String(currentDate.getFullYear()).slice(-2);
    const month = String(currentDate.getMonth() + 1).padStart(2, '0');
    const day = String(currentDate.getDate()).padStart(2, '0');
    const formattedDate = `${year}${month}${day}`;

    const fileExtension = getFileExtension(file.name);
    const newFileName = `${formattedDate}.${fileExtension}`;

    const uploadUrl = `https://api.github.com/repos/${repoOwner}/${repoName}/contents/${newFileName}`;

    const reader = new FileReader();
    reader.onload = function (event) {
        const content = event.target.result;

        fetch(uploadUrl, {
                method: 'PUT',
                headers: {
                    'Authorization': `token ${token}`,
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    message: 'Dodano nowy plik',
                    content: btoa(content),
                }),
            })
            .then(response => response.json())
            .then(data => {
                console.log('Plik przesłany pomyślnie:', data);
            })
            .catch(error => {
                console.error('Błąd podczas przesyłania pliku:', error);
            });
    };

    reader.readAsBinaryString(file);
}

function getFileExtension(fileName) {
    return fileName.split('.').pop().toLowerCase();
}
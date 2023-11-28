function validateToken() {
    const tokenLabel = document.getElementById('tokenLabel');
    const tokenInput = document.getElementById('tokenInput');
    const uploadButton = document.getElementById('uploadButton');
    const moveButton = document.getElementById('moveButton'); // Przycisk "Move PNG to Archive"
    const fileInput = document.getElementById('fileInput');

    const token = tokenInput.value.trim();

    if (!token) {
        alert('Wprowadź token dostępu GitHub.');
        return;
    }

    fetch('https://api.github.com/user', {
            headers: {
                'Authorization': `token ${token}`,
            },
        })
        .then(response => {
            if (response.ok) {
                // Hide login elements and show file upload elements
                tokenLabel.style.display = 'none';
                tokenInput.style.display = 'none';
                document.querySelector('button').style.display = 'none'; // Hide the Login button
                uploadButton.style.display = 'inline-block'; // Show the Upload button
                moveButton.style.display = 'inline-block'; // Show the Move button
                fileInput.style.display = 'inline-block'; // Show the file input
            } else {
                alert('Nieprawidłowy token. Spróbuj ponownie.');
            }
        })
        .catch(error => {
            console.error('Błąd podczas walidacji tokenu:', error);
            alert('Błąd podczas walidacji tokenu. Spróbuj ponownie.');
        });
}

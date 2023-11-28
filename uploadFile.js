<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>File Upload</title>
</head>
<body>

    <div>
        <label for="tokenInput">GitHub Token:</label>
        <input type="text" id="tokenInput">
    </div>

    <div>
        <label for="fileInput">Choose a file:</label>
        <input type="file" id="fileInput">
    </div>

    <button onclick="uploadFile()">Upload File</button>

    <p id="resultParagraph"></p>

    <script>
        function uploadFile() {
            const tokenInput = document.getElementById('tokenInput');
            const fileInput = document.getElementById('fileInput');
            const resultParagraph = document.getElementById('resultParagraph');
            const file = fileInput.files[0];

            const token = tokenInput.value.trim();

            if (!token) {
                alert('Enter your GitHub access token.');
                return;
            }

            // ... (rest of the code remains unchanged)

            .then(data => {
                // Update the paragraph element with the result
                resultParagraph.innerHTML = 'File uploaded successfully: ' + JSON.stringify(data);
            })
            .catch(error => {
                // Update the paragraph element with the error message
                resultParagraph.innerHTML = 'Error uploading file: ' + JSON.stringify(error);
            });
        }

        function getFileExtension(fileName) {
            return fileName.split('.').pop().toLowerCase();
        }
    </script>

</body>
</html>

document.getElementById("iniciarButton").addEventListener("click", function() {
    // Realiza una solicitud al servidor Django para iniciar la detección de pose
    fetch("abduccion_brazo_izquierdo/", { method: "POST" })
        .then(response => response.json())
        .then(data => {
            // Verifica si la respuesta contiene la URL de la imagen
            if (data && data.image_url) {
                // Obtén el lienzo y su contexto
                const canvas = document.getElementById("mediapipeCanvas");
                const ctx = canvas.getContext("2d");

                // Configura la imagen renderizada en el lienzo
                const image = new Image();
                image.src = data.image_url;

                // Manejo de errores en la carga de la imagen
                image.onerror = function() {
                    console.error("Error al cargar la imagen.");
                };

                // Dibuja la imagen en el lienzo
                image.onload = function() {
                    ctx.drawImage(image, 0, 0);
                };
            } else {
                console.error("La respuesta del servidor no contiene una URL de imagen válida.");
            }
        })
        .catch(error => {
            console.error("Error:", error);
        });
});

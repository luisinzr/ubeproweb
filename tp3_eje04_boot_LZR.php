<?php
session_start();

// Reiniciar número si se pide desde JS
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['reiniciar'])) {
  $_SESSION['numero_aleatorio'] = rand(1, 10);
  echo $_SESSION['numero_aleatorio'];
  exit;
}

// Inicializar número aleatorio si no existe
if (!isset($_SESSION['numero_aleatorio'])) {
  $_SESSION['numero_aleatorio'] = rand(1, 10);
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Juego de Adivinanzas</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-white py-5">

  <div class="container text-center">
    <h1 class="mb-4">Adivina el número secreto (1 al 10)</h1>

    <div class="mb-3">
      <input type="number" id="intento" class="form-control form-control-lg w-50 mx-auto" placeholder="Escribe un número" min="1" max="10">
    </div>

    <button class="btn btn-primary btn-lg" onclick="verificarAdivinanza()">Intentar</button>
    <button class="btn btn-danger btn-lg ms-2" onclick="reiniciarJuego()">Reiniciar</button>

    <div id="resultado" class="mt-4 fs-4"></div>
  </div>

  <script>
    let numeroSecreto = <?php echo $_SESSION['numero_aleatorio']; ?>;
    let intentos = 0;

    function verificarAdivinanza() {
      const intento = parseInt(document.getElementById("intento").value);
      const resultado = document.getElementById("resultado");

      if (isNaN(intento) || intento < 1 || intento > 10) {
        resultado.innerHTML = '<div class="alert alert-warning">Por favor ingresa un número del 1 al 10.</div>';
        return;
      }

      intentos++;

      if (intento === numeroSecreto) {
        resultado.innerHTML = '<div class="alert alert-success">¡Correcto! Has adivinado el número secreto.</div>';
        intentos = 0;
      } else if (intentos === 1) {
        resultado.innerHTML = '<div class="alert alert-danger">Incorrecto. Te queda un segundo intento.</div>';
      } else {
        resultado.innerHTML = '<div class="alert alert-danger">Has fallado dos veces. El juego se reinicia.</div>';
        setTimeout(reiniciarJuego, 1500); // Reinicia después de mostrar el mensaje
      }
    }

    function reiniciarJuego() {
      fetch("index.php", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "reiniciar=1"
      })
      .then(response => response.text())
      .then(nuevoNumero => {
        numeroSecreto = parseInt(nuevoNumero);
        document.getElementById("intento").value = "";
        document.getElementById("resultado").innerHTML = "";
        intentos = 0;
      });
    }
  </script>

</body>
</html>


<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Contador de Visitas</title>
  <!-- Bootstrap para estilo visual -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light text-center py-5">

  <div class="container">
    <h1 class="mb-4">Bienvenido a mi sitio web</h1>

    <?php
      // Ruta del archivo que almacena el número de visitas
      $archivo = "contador.txt";

      // Si el archivo no existe, lo creamos con valor 0
      if (!file_exists($archivo)) {
        file_put_contents($archivo, 0);
      }

      // Leemos el contenido actual del archivo
      $visitas = (int)file_get_contents($archivo);

      // Incrementamos el contador
      $visitas++;

      // Guardamos el nuevo número de visitas en el archivo
      file_put_contents($archivo, $visitas);

      // Mostramos el número de visitas
      echo "<div class='alert alert-info'><strong>Visitas totales:</strong> $visitas</div>";
    ?>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

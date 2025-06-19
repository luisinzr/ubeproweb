<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>Galería con Bootstrap</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

  <div class="container py-4">
    <h1 class="text-center mb-4">Galería de Imágenes UBE</h1>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
      <?php
        $dir = "images/";  // Ruta relativa desde index.php
        $images = array_slice(glob($dir . "*.{jpg,jpeg,png,gif}", GLOB_BRACE), 0, 6);

        if ($images === false) {
          echo "<p>No se pudieron cargar las imágenes.</p>";
        } elseif (count($images) === 0) {
          echo "<p>No hay imágenes en la carpeta '$dir'.</p>";
        } else {
          foreach ($images as $image) {
            echo '<div class="col">';
            echo '  <div class="card h-100">';
            echo '    <img src="' . htmlspecialchars($image) . '" class="card-img-top" alt="Imagen galería">';
            echo '  </div>';
            echo '</div>';
          }
        }
      ?>
    </div>
  </div>

  <!-- Bootstrap JS Bundle (opcional) -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

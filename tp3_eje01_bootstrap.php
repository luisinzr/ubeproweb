<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Tienda Tecnológica</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .submenu {
      display: none;
    }
  </style>
</head>
<body class="bg-light">

  <div class="container py-5">
    <h2 class="text-center text-primary mb-4">Tienda Tecnológica</h2>

    <div class="mx-auto" style="max-width: 400px;">
      <?php
        $categorias = [
          "Celulares" => ["Samsung", "Apple", "Xiaomi", "Motorola"],
          "Laptops" => ["HP", "Lenovo", "Dell", "Asus"],
          "Relojes" => ["Garmin", "Apple", "Samsung", "Xiaomi"],
          "Televisores" => ["LG", "Sony", "Samsung", "TCL"]
        ];

        foreach ($categorias as $categoria => $marcas) {
          echo "<div class='mb-3'>
                  <button class='btn btn-dark w-100 text-start' onclick='toggleSubmenu(this)'>$categoria</button>
                  <div class='submenu bg-primary rounded mt-1'>";
          foreach ($marcas as $marca) {
            echo "<div class='text-white py-2 px-3 border-top'>$marca</div>";
          }
          echo "  </div>
                </div>";
        }
      ?>
    </div>
  </div>

  <!-- Tu script para submenús -->
  <script>
    function toggleSubmenu(button) {
      const submenu = button.nextElementSibling;
      const all = document.querySelectorAll('.submenu');
      all.forEach(el => {
        if (el !== submenu) el.style.display = 'none';
      });
      submenu.style.display = submenu.style.display === 'block' ? 'none' : 'block';
    }
  </script>

  <!-- Bootstrap JS con Popper incluido -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

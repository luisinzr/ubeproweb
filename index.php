<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Tienda Categorías</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .categoria {
      display: none;
    }
    .activo {
      display: block;
    }
  </style>
</head>
<body class="bg-light">

<?php
session_start();

// Lista de productos clasificados por categoría
$productos = [
  // Laptops
  ['nombre' => 'Monitor Gamer LG 24" Full HD 144Hz', 'precio' => 180.00, 'imagen' => 'https://www.lg.com/ec/images/monitores/md07537025/gallery/DZ-1.jpg', 'categoria' => 'laptops'],
  
  // Partes
  ['nombre' => 'Cooler Led T/ Torre – Cougar Forza 50 Essencial', 'precio' => 35.00, 'imagen' => 'https://tecnogame.ec/wp-content/uploads/2023/12/Cougar-Forza-50.jpg', 'categoria' => 'partes'],
  ['nombre' => 'Case Antec AX20 Elite / Vidrio templado', 'precio' => 47.70, 'imagen' => 'https://www.bestcell.com.ec/imgadmin/storage/imagenes_articulos/1089/4812.jpg.480.webp', 'categoria' => 'partes'],
  ['nombre' => 'Tarjeta de Video ASUS GeForce GTX 1650', 'precio' => 220.00, 'imagen' => 'https://www.bestcell.com.ec/imgadmin/storage/imagenes_articulos/619/2445.jpg.webp', 'categoria' => 'partes'],
  ['nombre' => 'Fuente de Poder EVGA 600W 80 Plus White', 'precio' => 55.00, 'imagen' => 'https://http2.mlstatic.com/D_NQ_NP_971066-MLU73040286004_112023-O.webp', 'categoria' => 'partes'],
  ['nombre' => 'Riser PCIe GPU MZHOU Ver013 Pro', 'precio' => 20.00, 'imagen' => 'https://www.bestcell.com.ec/imgadmin/storage/imagenes_articulos/682/2775.jpg.480.webp', 'categoria' => 'partes'],
  
  // Accesorios
  ['nombre' => 'Combo Gamer Mouse, Audifonos – Marvo MH01', 'precio' => 18.00, 'imagen' => 'https://tecnogame.ec/wp-content/uploads/2022/01/Combo-M-Y-A-MH01.jpg', 'categoria' => 'accesorios'],
  ['nombre' => 'Teclado Mecánico Redragon K552 RGB', 'precio' => 42.00, 'imagen' => 'https://redragon.es/content/uploads/2021/05/Modal-Kumara-748-x-980px.png', 'categoria' => 'accesorios'],
  ['nombre' => 'Memoria RAM DDR4 8GB 3200MHz Kingston', 'precio' => 28.00, 'imagen' => 'https://tecnobytesec.com/wp-content/uploads/2024/02/kingston-fury-rgb-ddr4-3200mhz-8gb-cl16-1-600x600.jpg', 'categoria' => 'accesorios'],
  ['nombre' => 'SSD Kingston A400 240GB 2.5"', 'precio' => 30.00, 'imagen' => 'https://www.idcmayoristas.com/wp-content/uploads/2024/10/SA400S37240G-1.png.webp', 'categoria' => 'accesorios'],
];

// Inicializar carrito si no existe
if (!isset($_SESSION['carrito'])) {
  $_SESSION['carrito'] = [];
}

// Agregar producto
if (isset($_GET['agregar'])) {
  $id = $_GET['agregar'];
  if (isset($productos[$id])) {
    $_SESSION['carrito'][] = $productos[$id];
  }
}

// Contador de carrito
$contador = count($_SESSION['carrito']);
?>

<div class="container py-4">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h1 class="text-primary">Tienda Tecnológica</h1>
    <a href="carrito.php" class="btn btn-outline-primary position-relative">
      Ver Carrito 🛒
      <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
        <?= $contador ?>
      </span>
    </a>
  </div>

  <!-- Menú de categorías con imágenes y tooltip -->
  <div class="row mb-4 text-center">
    <div class="col-md-4">
      <button class="btn btn-outline-dark w-100 p-4" 
              onclick="mostrarCategoria('laptops')" 
              data-bs-toggle="tooltip" 
              data-bs-html="true" 
              title="<strong>Productos:</strong><br>- Monitor Gamer LG 24&quot;">
        <img src="https://cdn-icons-png.flaticon.com/512/1063/1063376.png" width="70" alt="Laptops"><br>
        <strong class="fs-5">Laptops</strong>
      </button>
    </div>

    <div class="col-md-4">
      <button class="btn btn-outline-dark w-100 p-4" 
              onclick="mostrarCategoria('partes')" 
              data-bs-toggle="tooltip" 
              data-bs-html="true" 
              title="<strong>Productos:</strong><br>- Cooler Cougar<br>- Case Antec<br>- Tarjeta ASUS<br>- Fuente EVGA<br>- Riser PCIe">
        <img src="https://cdn-icons-png.flaticon.com/512/2933/2933836.png" width="70" alt="Partes"><br>
        <strong class="fs-5">Partes</strong>
      </button>
    </div>

    <div class="col-md-4">
      <button class="btn btn-outline-dark w-100 p-4" 
              onclick="mostrarCategoria('accesorios')" 
              data-bs-toggle="tooltip" 
              data-bs-html="true" 
              title="<strong>Productos:</strong><br>- Combo Marvo<br>- Teclado Redragon<br>- RAM Kingston<br>- SSD Kingston">
        <img src="https://cdn-icons-png.flaticon.com/512/281/281847.png" width="70" alt="Accesorios"><br>
        <strong class="fs-5">Accesorios</strong>
      </button>
    </div>
  </div>

  <!-- Productos -->
  <div class="row">
    <?php foreach ($productos as $id => $producto): ?>
      <div class="col-md-4 mb-4 categoria <?= $producto['categoria'] ?>">
        <div class="card h-100">
          <img src="<?= $producto['imagen'] ?>" class="card-img-top" alt="<?= $producto['nombre'] ?>">
          <div class="card-body d-flex flex-column">
            <h5 class="card-title"><?= $producto['nombre'] ?></h5>
            <p class="card-text text-success">$<?= number_format($producto['precio'], 2) ?></p>
            <a href="?agregar=<?= $id ?>" class="btn btn-primary mt-auto">Agregar al carrito</a>
          </div>
        </div>
      </div>
    <?php endforeach; ?>
  </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function mostrarCategoria(cat) {
    document.querySelectorAll('.categoria').forEach(e => e.classList.remove('activo'));
    document.querySelectorAll('.' + cat).forEach(e => e.classList.add('activo'));
  }

  // Activar tooltips
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
  tooltipTriggerList.forEach(t => new bootstrap.Tooltip(t));
</script>

</body>
</html>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Carrito de Compras</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<?php
session_start();

// Eliminar un producto del carrito
if (isset($_GET['eliminar'])) {
  $index = $_GET['eliminar'];
  if (isset($_SESSION['carrito'][$index])) {
    unset($_SESSION['carrito'][$index]);
    $_SESSION['carrito'] = array_values($_SESSION['carrito']);
  }
}

// Vaciar todo el carrito
if (isset($_GET['vaciar'])) {
  unset($_SESSION['carrito']);
  $_SESSION['carrito'] = [];
}

// Finalizar compra
$compraExitosa = false;
if (isset($_GET['comprar'])) {
  if (!empty($_SESSION['carrito'])) {
    $compraExitosa = true;
    unset($_SESSION['carrito']);
    $_SESSION['carrito'] = [];
  }
}
?>

<div class="container py-4">
  <h1 class="text-primary mb-4">🛒 Tu Carrito</h1>

  <a href="index.php" class="btn btn-outline-secondary mb-3">⬅ Volver a la tienda</a>

  <?php if ($compraExitosa): ?>
    <div class="alert alert-success">✅ ¡Compra finalizada con éxito!</div>
  <?php endif; ?>

  <?php if (!empty($_SESSION['carrito'])): ?>
    <div class="d-flex justify-content-between mb-3">
      <a href="?vaciar=true" class="btn btn-outline-danger">🗑 Vaciar carrito</a>
      <a href="?comprar=true" class="btn btn-success">✅ Finalizar compra</a>
    </div>

    <div class="row">
      <?php foreach ($_SESSION['carrito'] as $i => $item): ?>
        <div class="col-md-4 mb-4">
          <div class="card h-100 border-success">
            <img src="<?= $item['imagen'] ?>" class="card-img-top" alt="<?= $item['nombre'] ?>">
            <div class="card-body d-flex flex-column">
              <h5 class="card-title"><?= $item['nombre'] ?></h5>
              <p class="card-text text-success">$<?= number_format($item['precio'], 2) ?></p>
              <a href="?eliminar=<?= $i ?>" class="btn btn-danger mt-auto">Eliminar</a>
            </div>
          </div>
        </div>
      <?php endforeach; ?>
    </div>
  <?php else: ?>
    <div class="alert alert-info">Tu carrito está vacío.</div>
  <?php endif; ?>
</div>

</body>
</html>
<?php
session_start();

// Conexión a la base de datos
$host = "localhost";
$user = "root";
$password = "";
$dbname = "mi_login_db";

str_pad($fila["id"], 4, "0", STR_PAD_LEFT);

$conn = new mysqli($host, $user, $password, $dbname);
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Cerrar sesión
if (isset($_GET['logout'])) {
    session_destroy();
    header("Location: login.php");
    exit();
}

$mensaje = "";
$datosUsuario = null;

// Lógica del login con usuario y contraseña
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $username = $_POST["username"] ?? "";
    $userpass = $_POST["password"] ?? "";

    $stmt = $conn->prepare("SELECT id, username, password FROM usuarios WHERE username = ? AND password = ?");
    $stmt->bind_param("ss", $username, $userpass);
    $stmt->execute();
    $resultado = $stmt->get_result();

    if ($resultado->num_rows === 1) {
        $datosUsuario = $resultado->fetch_assoc();
        $_SESSION["user"] = $datosUsuario["username"];
        $_SESSION["id"] = $datosUsuario["id"];
        $mensaje = '<div class="alert alert-success">✅ Usuario validado correctamente.</div>';
    } else {
        $mensaje = '<div class="alert alert-danger">❌ Usuario no encontrado o contraseña incorrecta.</div>';
    }

    $stmt->close();
}

// Variable para mostrar el id en el input
$idMostrar = isset($_SESSION["id"]) ? str_pad($_SESSION["id"], 4, "0", STR_PAD_LEFT) : "(asignado automáticamente)";

// Obtener todos los usuarios
$todos = $conn->query("SELECT id, username, password FROM usuarios ORDER BY id ASC");
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>Login con Bootstrap y ID formateado</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">

<div class="container mt-5">
  <h2 class="text-center mb-4">Formulario de Inicio de Sesión</h2>

  <div class="card shadow-sm p-4 mb-4">
    <form method="POST" action="login.php">
      <div class="mb-3">
        <label class="form-label">ID (automático):</label>
        <input type="text" class="form-control" value="<?php echo htmlspecialchars($idMostrar); ?>" disabled />
      </div>

      <div class="mb-3">
        <label class="form-label">Usuario:</label>
        <input type="text" name="username" class="form-control" required />
      </div>

      <div class="mb-3">
        <label class="form-label">Contraseña:</label>
        <input type="password" name="password" class="form-control" required />
      </div>

      <button type="submit" class="btn btn-primary">Entrar</button>
    </form>
  </div>

  <?php if ($mensaje): ?>
    <?php echo $mensaje; ?>
  <?php endif; ?>

  <?php if ($datosUsuario): ?>
    <div class="card p-3 mb-4">
      <h5 class="mb-3">🔐 Usuario autenticado:</h5>
      <ul class="list-group">
        <li class="list-group-item"><strong>ID:</strong> <?php echo str_pad($datosUsuario["id"], 4, "0", STR_PAD_LEFT); ?></li>
        <li class="list-group-item"><strong>Usuario:</strong> <?php echo $datosUsuario["username"]; ?></li>
        <li class="list-group-item"><strong>Contraseña:</strong> <?php echo $datosUsuario["password"]; ?></li>
      </ul>
      <a href="login.php?logout=1" class="btn btn-danger mt-3">Cerrar sesión</a>
    </div>
  <?php endif; ?>

  <h4 class="mb-3">📋 Lista de usuarios registrados:</h4>
  <table class="table table-bordered table-striped">
    <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Usuario</th>
        <th>Contraseña</th>
      </tr>
    </thead>
    <tbody>
      <?php while ($fila = $todos->fetch_assoc()): ?>
        <tr>
          <td><?php echo str_pad($fila["id"], 4, "0", STR_PAD_LEFT); ?></td>
          <td><?php echo $fila["username"]; ?></td>
          <td><?php echo $fila["password"]; ?></td>
        </tr>
      <?php endwhile; ?>
    </tbody>
  </table>
</div>

</body>
</html>

<?php $conn->close(); ?>


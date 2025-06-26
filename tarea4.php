<?php
session_start();

$host = "localhost";
$db = "lista_tareas_db";
$user = "root";  // Cambia si es necesario
$pass = "";      // Cambia si es necesario

$mysqli = new mysqli($host, $user, $pass, $db);
if ($mysqli->connect_errno) {
    die("Error de conexión: " . $mysqli->connect_error);
}

function limpiar($dato) {
    return htmlspecialchars(trim($dato));
}

$mensaje = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST["login"])) {
        $rol = limpiar($_POST["rol"]);
        $nombre = limpiar($_POST["nombre"]);
        $clave = limpiar($_POST["clave"]);

        // Validar solo contraseña
        if (($rol == "Usuario" && $clave === "0000") || ($rol == "Administrador" && $clave === "1111")) {

            // Buscar usuario en DB
            $stmt = $mysqli->prepare("SELECT id FROM usuarios WHERE nombre = ?");
            $stmt->bind_param("s", $nombre);
            $stmt->execute();
            $res = $stmt->get_result();

            if ($res->num_rows == 1) {
                $fila = $res->fetch_assoc();
                $id_usuario = $fila["id"];
            } else {
                // Insertar usuario nuevo
                $stmt_insert = $mysqli->prepare("INSERT INTO usuarios (nombre, rol) VALUES (?, ?)");
                $stmt_insert->bind_param("ss", $nombre, $rol);
                $stmt_insert->execute();
                $id_usuario = $stmt_insert->insert_id;
                $stmt_insert->close();
            }
            $stmt->close();

            $_SESSION["usuario"] = $nombre;
            $_SESSION["rol"] = $rol;
            $_SESSION["id_usuario"] = $id_usuario;
            $mensaje = "";
        } else {
            $mensaje = "❌ Contraseña incorrecta para el rol seleccionado.";
        }
    }

    if (isset($_POST["logout"])) {
        session_destroy();
        header("Location: " . $_SERVER['PHP_SELF']);
        exit;
    }

    // Agregar tarea
    if (isset($_POST["agregar_tarea"]) && isset($_SESSION["usuario"])) {
        $desc = limpiar($_POST["agregar_tarea"]);
        if ($desc !== "") {
            $stmt = $mysqli->prepare("INSERT INTO tareas (descripcion, autor_id) VALUES (?, ?)");
            $stmt->bind_param("si", $desc, $_SESSION["id_usuario"]);
            if ($stmt->execute()) {
                $mensaje = "✅ Tarea agregada correctamente.";
            } else {
                $mensaje = "❌ Error al agregar tarea.";
            }
            $stmt->close();
        }
    }

    // Eliminar tarea (solo admin)
    if (isset($_POST["eliminar"])) {
        if (isset($_SESSION["rol"]) && $_SESSION["rol"] === "Administrador") {
            $id_tarea = (int)$_POST["eliminar"];
            $stmt = $mysqli->prepare("DELETE FROM tareas WHERE id = ?");
            $stmt->bind_param("i", $id_tarea);
            if ($stmt->execute()) {
                $mensaje = "✅ Tarea eliminada.";
            } else {
                $mensaje = "❌ Error al eliminar tarea.";
            }
            $stmt->close();
        } else {
            $mensaje = "❌ No tienes permiso para eliminar tareas.";
        }
    }

    // Editar tarea - mostrar input
    if (isset($_POST["editar"])) {
        if (isset($_SESSION["rol"]) && $_SESSION["rol"] === "Administrador") {
            $_SESSION["modo_editar"] = (int)$_POST["editar"];
            $mensaje = "";
        } else {
            $mensaje = "❌ No tienes permiso para modificar tareas.";
        }
    }

    // Guardar edición
    if (isset($_POST["guardar_edicion"]) && isset($_POST["nuevo_texto"])) {
        if (isset($_SESSION["rol"]) && $_SESSION["rol"] === "Administrador") {
            $id_editar = (int)$_POST["guardar_edicion"];
            $nuevo_texto = limpiar($_POST["nuevo_texto"]);
            $stmt = $mysqli->prepare("UPDATE tareas SET descripcion = ? WHERE id = ?");
            $stmt->bind_param("si", $nuevo_texto, $id_editar);
            if ($stmt->execute()) {
                unset($_SESSION["modo_editar"]);
                $mensaje = "✅ Tarea modificada correctamente.";
            } else {
                $mensaje = "❌ Error al modificar tarea.";
            }
            $stmt->close();
        } else {
            $mensaje = "❌ No tienes permiso para modificar tareas.";
        }
    }
}

// Obtener todas las tareas con autor
$tareas = [];
$stmt = $mysqli->prepare("SELECT tareas.id, tareas.descripcion, usuarios.nombre FROM tareas INNER JOIN usuarios ON tareas.autor_id = usuarios.id ORDER BY tareas.id DESC");
$stmt->execute();
$res = $stmt->get_result();
while ($fila = $res->fetch_assoc()) {
    $tareas[] = $fila;
}
$stmt->close();

$tareas_opciones = [
    "Levantar requerimientos", "Diseño de arquitectura", "Crear casos de uso",
    "Modelar base de datos", "Planificar sprints", "Programar backend",
    "Programar frontend", "Realizar pruebas QA", "Documentar sistema", "Hacer despliegue final"
];
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>Lista de Tareas con Roles</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>.card { min-height: 180px; }</style>
</head>
<body class="bg-light">
<div class="container py-4">

<?php if (!isset($_SESSION["usuario"])): ?>
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card p-4 shadow">
        <h3 class="text-center mb-3">Iniciar sesión</h3>
        <form method="post">
          <label class="form-label">Rol:</label>
          <select name="rol" class="form-select mb-3" required>
            <option value="">-- Selecciona --</option>
            <option value="Administrador">Administrador</option>
            <option value="Usuario">Usuario</option>
          </select>
          <label class="form-label">Nombre:</label>
          <input type="text" name="nombre" class="form-control mb-3" placeholder="Tu nombre" required />
          <label class="form-label">Contraseña:</label>
          <input type="password" name="clave" class="form-control mb-3" placeholder="Contraseña" required />
          <button type="submit" name="login" class="btn btn-primary w-100">Ingresar</button>
        </form>
        <?php if ($mensaje): ?>
          <div class="alert alert-danger mt-3"><?= htmlspecialchars($mensaje) ?></div>
        <?php endif; ?>
      </div>
    </div>
  </div>

<?php else: ?>

  <div class="d-flex justify-content-between align-items-center mb-4">
    <h4>👤 <?= htmlspecialchars($_SESSION["usuario"]) ?> (<?= $_SESSION["rol"] ?>)</h4>
    <form method="post">
      <button name="logout" class="btn btn-danger">Cerrar sesión</button>
    </form>
  </div>

  <?php if ($mensaje && !isset($_POST["login"])): ?>
    <div class="alert <?= strpos($mensaje, '❌') === false ? 'alert-success' : 'alert-danger' ?>"><?= htmlspecialchars($mensaje) ?></div>
  <?php endif; ?>

  <h5>🛒 Carrito de Tareas</h5>
  <div class="row g-3 mb-4">
    <?php foreach ($tareas as $t): ?>
      <div class="col-md-4">
        <div class="card shadow-sm p-3">
          <?php if (isset($_SESSION["modo_editar"]) && $_SESSION["modo_editar"] == $t['id']): ?>
            <form method="post">
              <input type="text" name="nuevo_texto" value="<?= htmlspecialchars($t['descripcion']) ?>" class="form-control mb-2" required />
              <button type="submit" name="guardar_edicion" value="<?= $t['id'] ?>" class="btn btn-success w-100">Guardar</button>
            </form>
          <?php else: ?>
            <h6 class="mb-1"><?= htmlspecialchars($t['descripcion']) ?></h6>
            <small class="text-muted">Agregado por: <?= htmlspecialchars($t['nombre']) ?></small>
            <form method="post" class="d-flex justify-content-between mt-2">
              <button name="editar" value="<?= $t['id'] ?>" class="btn btn-warning btn-sm me-1">✏️ Editar</button>
              <button name="eliminar" value="<?= $t['id'] ?>" class="btn btn-danger btn-sm">🗑️ Eliminar</button>
            </form>
          <?php endif; ?>
        </div>
      </div>
    <?php endforeach; ?>
  </div>

  <h5>➕ Agregar tarea al carrito</h5>
  <form method="post" class="input-group mb-4">
    <select name="agregar_tarea" class="form-select" required>
      <option value="">-- Selecciona una tarea --</option>
      <?php foreach ($tareas_opciones as $t): ?>
        <option value="<?= htmlspecialchars($t) ?>"><?= htmlspecialchars($t) ?></option>
      <?php endforeach; ?>
    </select>
    <button class="btn btn-success">Agregar</button>
  </form>

<?php endif; ?>

</div>
</body>
</html>

<?php
session_start();
$conexion = new mysqli("localhost", "root", "", "cp5_tareas");

if (!isset($_SESSION['usuario_id'])) {
    header("Location: index.php");
    exit;
}

$usuario_id = $_SESSION['usuario_id'];
$rol = $_SESSION['rol'];

// Obtener datos del usuario y su tarea asignada
$query = $conexion->query("
    SELECT u.id, u.nombre, u.email, r.rol_nombre, t.id AS tarea_id, t.titulo, t.descripcion, t.estado
    FROM usuarios u
    JOIN roles r ON u.rol_id = r.rol_id
    LEFT JOIN tareas t ON t.usuario_id = u.id
    WHERE u.id = $usuario_id
");
$usuario = $query->fetch_assoc();

// Acciones POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Eliminar tarea
    if (isset($_POST['eliminar']) && $rol === "Administrador") {
        $tarea_id = $_POST['tarea_id'];
        $conexion->query("DELETE FROM tareas WHERE id = $tarea_id");
        header("Location: gestion_tareas.php");
        exit;
    }

    // Editar tarea (cambiar título y descripción por defecto)
    if (isset($_POST['editar']) && $rol === "Gerente de proyecto") {
        $tarea_id = $_POST['tarea_id'];
        $conexion->query("UPDATE tareas SET titulo = 'Editado por gerente', descripcion = 'Actualizado por gerente' WHERE id = $tarea_id");
        header("Location: gestion_tareas.php");
        exit;
    }

    // Actualizar estado (solo para miembros)
    if (isset($_POST['actualizar_estado']) && $rol === "Miembro del equipo") {
        $nuevo_estado = $_POST['nuevo_estado'];
        $tarea_id = $_POST['tarea_id'];
        $conexion->query("UPDATE tareas SET estado = '$nuevo_estado' WHERE id = $tarea_id AND usuario_id = $usuario_id");
        header("Location: gestion_tareas.php");
        exit;
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Gestión de Tareas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">

    <h2>Gestión de Tareas</h2>

    <table class="table table-bordered">
        <tr><th>Nombre</th><td><?= $usuario['nombre'] ?></td></tr>
        <tr><th>Email</th><td><?= $usuario['email'] ?></td></tr>
        <tr><th>Rol</th><td><?= $usuario['rol_nombre'] ?></td></tr>
        <tr><th>Tarea</th><td><?= $usuario['titulo'] ?? 'Ninguna asignada' ?></td></tr>
        <tr><th>Estado</th><td><?= $usuario['estado'] ?? '-' ?></td></tr>
        <tr><th>Descripción</th><td><?= $usuario['descripcion'] ?? '-' ?></td></tr>
    </table>

    <h4>Acciones Disponibles</h4>

    <?php if ($usuario['tarea_id']): ?>
        <form method="post">
            <input type="hidden" name="tarea_id" value="<?= $usuario['tarea_id'] ?>">

            <?php if ($rol === "Administrador"): ?>
                <button type="submit" name="eliminar" class="btn btn-danger">Eliminar Tarea</button>

            <?php elseif ($rol === "Gerente de proyecto"): ?>
                <button type="submit" name="editar" class="btn btn-warning">Editar Tarea</button>

            <?php elseif ($rol === "Miembro del equipo"): ?>
                <select name="nuevo_estado" class="form-select d-inline w-auto">
                    <option value="Pendiente" <?= $usuario['estado'] == "Pendiente" ? "selected" : "" ?>>Pendiente</option>
                    <option value="En proceso" <?= $usuario['estado'] == "En proceso" ? "selected" : "" ?>>En proceso</option>
                    <option value="Completado" <?= $usuario['estado'] == "Completado" ? "selected" : "" ?>>Completado</option>
                </select>
                <button type="submit" name="actualizar_estado" class="btn btn-success">Actualizar Estado</button>
            <?php endif; ?>
        </form>
    <?php else: ?>
        <div class="alert alert-warning">No tienes ninguna tarea asignada.</div>
    <?php endif; ?>

    <br>
    <a href="index.php" class="btn btn-secondary">Volver al Inicio</a>

</body>
</html>

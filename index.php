<?php
session_start();

// Conexión a la base de datos
$conexion = new mysqli("localhost", "root", "", "cp5_tareas");
if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

// Claves predefinidas por rol para validación
$claves_por_rol = [
    "Administrador" => "0000",
    "Gerente de proyecto" => "1111",
    "Miembro del equipo" => "2222"
];

// Cierre de sesión: elimina la sesión y redirige al inicio
if (isset($_GET['logout'])) {
    session_destroy();
    header("Location: index.php");
    exit;
}

// Proceso de registro de nuevo usuario
if (isset($_POST['registro'])) {
    $nombre = $_POST['nombre'];
    $email = $_POST['email'];
    $rol = $_POST['rol'];
    $clave = $_POST['clave'];

    // Validar la clave correspondiente al rol seleccionado
    if ($clave === $claves_por_rol[$rol]) {
        // Obtener ID del rol desde la tabla roles
        $stmt = $conexion->prepare("SELECT rol_id FROM roles WHERE rol_nombre = ?");
        $stmt->bind_param("s", $rol);
        $stmt->execute();
        $res = $stmt->get_result();
        $rol_id = $res->fetch_assoc()['rol_id'];

        // Insertar el nuevo usuario en la base de datos
        $insert = $conexion->prepare("INSERT INTO usuarios (nombre, email, clave, rol_id) VALUES (?, ?, ?, ?)");
        $insert->bind_param("sssi", $nombre, $email, $clave, $rol_id);
        $insert->execute();

        // Guardar el rol y el ID del usuario en sesión
        $_SESSION['rol'] = $rol;
        $_SESSION['usuario_id'] = $insert->insert_id;
    } else {
        echo "<div class='alert alert-danger'>Clave incorrecta para el rol seleccionado</div>";
    }
}

// Proceso de inicio de sesión
if (isset($_POST['login'])) {
    $email = $_POST['email'];
    $clave = $_POST['clave'];

    // Buscar usuario con el correo y clave proporcionados
    $consulta = $conexion->prepare("SELECT u.id, u.nombre, u.email, u.clave, r.rol_nombre 
    FROM usuarios u 
    JOIN roles r ON u.rol_id = r.rol_id 
    WHERE u.email = ? AND u.clave = ?");
    $consulta->bind_param("ss", $email, $clave);
    $consulta->execute();
    $res = $consulta->get_result();

    // Si las credenciales son correctas, guardar sesión
    if ($usuario = $res->fetch_assoc()) {
        $_SESSION['rol'] = $usuario['rol_nombre'];
        $_SESSION['usuario_id'] = $usuario['id'];
    } else {
        echo "<div class='alert alert-danger'>Credenciales incorrectas</div>";
    }
}

// Procesos POST para eliminar, editar, actualizar estado y asignar tarea
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $usuario_id = $_SESSION['usuario_id'] ?? 0;
    $rol = $_SESSION['rol'] ?? '';

    if (isset($_POST['eliminar_id']) && ($rol == "Administrador" || $rol == "Gerente de proyecto")) {
        $id = intval($_POST['eliminar_id']);
        $conexion->query("DELETE FROM tareas WHERE id = $id");
        header("Location: index.php");
        exit;
    }

    if (isset($_POST['editar_id']) && $rol == "Gerente de proyecto") {
        $id = intval($_POST['editar_id']);
        $conexion->query("UPDATE tareas SET titulo='[Editado]', descripcion='[Actualizado]' WHERE id = $id");
        header("Location: index.php");
        exit;
    }

    if (isset($_POST['actualizar_estado_id']) && isset($_POST['nuevo_estado']) && $rol == "Miembro del equipo") {
        $id = intval($_POST['actualizar_estado_id']);
        $nuevo_estado = $conexion->real_escape_string($_POST['nuevo_estado']);
        $conexion->query("UPDATE tareas SET estado = '$nuevo_estado' WHERE id = $id AND usuario_id = $usuario_id");
        header("Location: index.php");
        exit;
    }

    if (isset($_POST['asignar_tarea']) && $rol == "Miembro del equipo") {
        $tarea_id = intval($_POST['tarea_id']);
        // Solo asigna si usuario_id es NULL
        $conexion->query("UPDATE tareas SET usuario_id = $usuario_id WHERE id = $tarea_id AND usuario_id IS NULL");
        header("Location: index.php");
        exit;
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Sistema de Tareas</title>
    <!-- Carga Bootstrap para mejorar el diseño visual -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">

<?php if (!isset($_SESSION['rol'])): ?>
    <!-- Pantalla inicial con opciones de login o registro -->
    <div class="text-center">
        <h2>Proyecto: Sistema de Gestión de Tareas por Equipos</h2>
        <h2>Clase practica 5</h2>
        <a href="?accion=login" class="btn btn-primary m-2">Iniciar Sesión</a>
        <a href="?accion=registro" class="btn btn-success m-2">Registrarse</a>
    </div>

    <!-- Formulario de registro -->
    <?php if (isset($_GET['accion']) && $_GET['accion'] == "registro"): ?>
        <h3>Registro</h3>
        <form method="post" class="card p-3">
            <input class="form-control mb-2" type="text" name="nombre" placeholder="Nombre" required>
            <input class="form-control mb-2" type="email" name="email" placeholder="Correo" required>
            <select name="rol" class="form-select mb-2">
                <option>Administrador</option>
                <option>Gerente de proyecto</option>
                <option>Miembro del equipo</option>
            </select>
            <input class="form-control mb-2" type="password" name="clave" placeholder="Clave por rol" required>
            <button class="btn btn-success" type="submit" name="registro">Registrar</button>
        </form>

    <!-- Formulario de login -->
    <?php elseif (isset($_GET['accion']) && $_GET['accion'] == "login"): ?>
        <h3>Iniciar Sesión</h3>
        <form method="post" class="card p-3">
            <input class="form-control mb-2" type="email" name="email" placeholder="Correo" required>
            <input class="form-control mb-2" type="password" name="clave" placeholder="Clave" required>
            <button class="btn btn-primary" type="submit" name="login">Entrar</button>
        </form>
    <?php endif; ?>

<?php else: ?>
    <!-- Bienvenida y navegación para usuarios logueados -->
    <div class="d-flex justify-content-between mb-3">
        <h3>Hola, <?= htmlspecialchars($_SESSION['rol']) ?></h3>
        <div>
            <a href="?logout=true" class="btn btn-danger">Cerrar sesión</a>
            <a href="gestion_tareas.php" class="btn btn-warning">Ver Gestión de Tareas</a>
        </div>
    </div>

    <?php
    $usuario_id = $_SESSION['usuario_id'];
    $rol = $_SESSION['rol'];

    // Si el usuario es miembro del equipo, puede asignarse tareas disponibles
    if ($rol == "Miembro del equipo"): ?>
        <form method="post" class="mb-4">
            <label>Unirse a una tarea:</label>
            <select name="tarea_id" class="form-select">
                <?php
                $no_asignadas = $conexion->query("SELECT id, titulo FROM tareas WHERE usuario_id IS NULL");
                while ($fila = $no_asignadas->fetch_assoc()) {
                    echo "<option value='" . intval($fila['id']) . "'>" . htmlspecialchars($fila['titulo']) . "</option>";
                }
                ?>
            </select>
            <button class="btn btn-info mt-2" type="submit" name="asignar_tarea">Unirme</button>
        </form>
    <?php endif; ?>

    <!-- Mostrar todas las tareas según el rol -->
    <h4>Listado de Tareas</h4>
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>Título</th>
                <th>Descripción</th>
                <th>Nombre Usuario</th>
                <th>Email Usuario</th>
                <th>Clave Usuario</th>
                <th>Rol Usuario</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        <?php
        $query_base = "
            SELECT tareas.id, tareas.titulo, tareas.descripcion, tareas.usuario_id, tareas.estado,
                   usuarios.nombre, usuarios.email, usuarios.clave, roles.rol_nombre
            FROM tareas
            LEFT JOIN usuarios ON tareas.usuario_id = usuarios.id
            LEFT JOIN roles ON usuarios.rol_id = roles.rol_id
        ";

        $tareas = ($rol == "Miembro del equipo")
            ? $conexion->query($query_base . " WHERE tareas.usuario_id = $usuario_id")
            : $conexion->query($query_base);

        while ($t = $tareas->fetch_assoc()) {
            echo "<tr>
                <td>" . htmlspecialchars($t['titulo']) . "</td>
                <td>" . htmlspecialchars($t['descripcion']) . "</td>
                <td>" . ($t['nombre'] ?? 'Sin asignar') . "</td>
                <td>" . ($t['email'] ?? '-') . "</td>
                <td>" . ($t['clave'] ?? '-') . "</td>
                <td>" . ($t['rol_nombre'] ?? '-') . "</td>
                <td>";

            // Botón eliminar (Administrador y Gerente)
            if ($rol == "Administrador" || $rol == "Gerente de proyecto") {
                echo "<form method='post' style='display:inline-block; margin-right: 4px;'>
                        <input type='hidden' name='eliminar_id' value='" . intval($t['id']) . "'>
                        <button class='btn btn-sm btn-danger' type='submit'>Eliminar</button>
                      </form>";
            }

            // Botón editar (solo Gerente)
            if ($rol == "Gerente de proyecto") {
                echo "<form method='post' style='display:inline-block; margin-right: 4px;'>
                        <input type='hidden' name='editar_id' value='" . intval($t['id']) . "'>
                        <button class='btn btn-sm btn-warning' type='submit'>Editar</button>
                      </form>";
            }

            // Cambiar estado (Miembro asignado)
            if ($rol == "Miembro del equipo" && $t['usuario_id'] == $usuario_id) {
                echo "<form method='post' style='display:inline-block; margin-right: 4px;'>
                        <input type='hidden' name='actualizar_estado_id' value='" . intval($t['id']) . "'>
                        <select name='nuevo_estado' class='form-select form-select-sm d-inline w-auto'>
                            <option " . ($t['estado'] == "Pendiente" ? "selected" : "") . ">Pendiente</option>
                            <option " . ($t['estado'] == "En proceso" ? "selected" : "") . ">En proceso</option>
                            <option " . ($t['estado'] == "Completado" ? "selected" : "") . ">Completado</option>
                        </select>
                        <button class='btn btn-sm btn-success' type='submit'>Actualizar</button>
                      </form>";
            }

            echo "</td></tr>";
        }
        ?>
        </tbody>
    </table>

<?php endif; ?>

</body>
</html>



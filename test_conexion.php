<?php
$conexion = new mysqli("localhost", "root", "", "cp5_tareas");

if ($conexion->connect_error) {
    die("❌ Error de conexión: " . $conexion->connect_error);
} else {
    echo "✅ Conexión exitosa a la base de datos cp5_tareas.";
}
?>

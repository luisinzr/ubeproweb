-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-07-2025 a las 17:24:43
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `biblioteca_db`
--
CREATE DATABASE IF NOT EXISTS `biblioteca_db` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `biblioteca_db`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `author` varchar(50) NOT NULL,
  `year` int(11) DEFAULT NULL,
  `genre` varchar(50) DEFAULT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `books`
--

INSERT INTO `books` (`id`, `title`, `author`, `year`, `genre`, `quantity`) VALUES
(1, 'El Quijote', 'Miguel de Cervantes', 1605, 'Novela', 5),
(2, 'Cien Años de Soledad', 'Gabriel García Márquez', 1967, 'Realismo Mágico', 3),
(3, '1984', 'George Orwell', 1949, 'Distopía', 7),
(4, 'Orgullo y Prejuicio', 'Jane Austen', 1813, 'Romance', 4),
(5, 'Donde los árboles cantan', 'Laura Gallego', 2011, 'Fantasía', 6),
(6, 'Crimen y Castigo', 'Fiódor Dostoievski', 1866, 'Filosofía', 2),
(7, 'El Principito', 'Antoine de Saint-Exupéry', 1943, 'Fábula', 10),
(8, 'Las Mil y Una Noches', 'Anónimo', NULL, 'Cuentos', 5),
(9, 'Moby Dick', 'Herman Melville', 1851, 'Aventura', 3),
(10, 'La Odisea', 'Homero', NULL, 'Épica', 4),
(11, 'Alicia en el País', 'Lewis Carroll', 1865, 'Fantasía', 8),
(12, 'Un Mundo Feliz', 'Aldous Huxley', 1932, 'Distopía', 6),
(13, 'El Alquimista', 'Paulo Coelho', 1988, 'Aventura Espiritual', 9),
(14, 'El Nombre de la Rosa', 'Umberto Eco', 1980, 'Misterio', 3),
(15, 'La Sombra del Viento', 'Carlos Ruiz Zafón', 2001, 'Misterio', 7),
(16, 'Rebelión en la Granja', 'George Orwell', 1945, 'Sátira', 5),
(17, 'Fahrenheit 451', 'Ray Bradbury', 1953, 'Ciencia Ficción', 4),
(18, 'Drácula', 'Bram Stoker', 1897, 'Terror', 2),
(19, 'Frankenstein', 'Mary Shelley', 1818, 'Gótico', 3),
(20, 'Los Miserables', 'Victor Hugo', 1862, 'Histórica', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'Administrator'),
(2, 'Librarian'),
(3, 'Reader');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `date_of_issue` date DEFAULT NULL,
  `date_of_return` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role_id`) VALUES
(1, 'luis', 'luis@gmail.com', '$2y$10$cqStGYCRkfMYOyFgi3nAxO7tsdBBivjPnR60Tsnq5QDECau8l3./u', 3),
(2, 'Administrador', 'admin@gmail.com', '$2y$10$yq72wOl6M0QKH6886jB9eOdTg0.QPT5tHDIg07Vn01eRblcAhM2Qq', 3),
(3, 'Bibliotecario', 'biblio@gmail.com', '$2y$10$hJCOq3qWUs.jQOS9fDJS0OrJk4P1iCfvigd3/UtaWGBnfkFAsb.P2', 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `book_id` (`book_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
--
-- Base de datos: `biblioteca_online`
--
CREATE DATABASE IF NOT EXISTS `biblioteca_online` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `biblioteca_online`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libros`
--

CREATE TABLE `libros` (
  `id` int(11) NOT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `autor` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `libros`
--

INSERT INTO `libros` (`id`, `titulo`, `autor`) VALUES
(1, 'Cien años', 'Gabriel García Márquez'),
(2, '1984', 'George Orwell'),
(3, 'El Principito', 'Antoine de Saint-Exupéry'),
(4, 'Crónica', 'Gabriel García Márquez'),
(5, 'Rayuela', 'Julio Cortázar'),
(6, 'Ficciones', 'Jorge Luis Borges'),
(7, 'Pedro Páramo', 'Juan Rulfo'),
(8, 'Aura', 'Carlos Fuentes'),
(9, 'El túnel', 'Ernesto Sabato'),
(10, 'La tregua', 'Mario Benedetti'),
(11, 'Don Quijote', 'Miguel de Cervantes'),
(12, 'Los de abajo', 'Mariano Azuela'),
(13, 'La sombra del viento', 'Carlos Ruiz Zafón'),
(14, 'El alquimista', 'Paulo Coelho'),
(15, 'Ensayo sobre la ceguera', 'José Saramago'),
(16, 'La casa de los espíritus', 'Isabel Allende'),
(17, 'Amor en tiempos del cólera', 'García Márquez'),
(18, 'Demian', 'Hermann Hesse'),
(19, 'La ciudad y los perros', 'Mario Vargas Llosa'),
(20, 'Travesuras de la niña mala', 'Mario Vargas Llosa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre_rol` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre_rol`) VALUES
(1, 'Administrador'),
(2, 'Bibliotecario'),
(3, 'Lector');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transacciones`
--

CREATE TABLE `transacciones` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_libro` int(11) DEFAULT NULL,
  `tipo_accion` varchar(50) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `contrasena` varchar(255) NOT NULL,
  `id_rol` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `libros`
--
ALTER TABLE `libros`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `transacciones`
--
ALTER TABLE `transacciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_libro` (`id_libro`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `libros`
--
ALTER TABLE `libros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `transacciones`
--
ALTER TABLE `transacciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `transacciones`
--
ALTER TABLE `transacciones`
  ADD CONSTRAINT `transacciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `transacciones_ibfk_2` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`);
--
-- Base de datos: `cp5_tareas`
--
CREATE DATABASE IF NOT EXISTS `cp5_tareas` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `cp5_tareas`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `rol_id` int(11) NOT NULL,
  `rol_nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rol_id`, `rol_nombre`) VALUES
(1, 'Administrador'),
(2, 'Gerente de proyecto'),
(3, 'Miembro del equipo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

CREATE TABLE `tareas` (
  `id` int(11) NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `descripcion` varchar(300) DEFAULT NULL,
  `estado` enum('Pendiente','En proceso','Completado') NOT NULL DEFAULT 'Pendiente',
  `usuario_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `tareas`
--

INSERT INTO `tareas` (`id`, `titulo`, `descripcion`, `estado`, `usuario_id`) VALUES
(23, 'Configuración del Servidor', 'Instalar Apache, PHP y MySQL en el entorno local.', 'Pendiente', 113),
(24, 'Desarrollo Frontend', 'Maquetar la interfaz con HTML, CSS y Bootstrap.', 'En proceso', 101),
(25, 'Implementación de Login', 'Crear sistema de autenticación con sesiones.', 'Pendiente', 113),
(26, 'Gestión de Usuarios', 'Permitir crear, editar y eliminar usuarios.', 'Pendiente', 114),
(27, 'Control de Accesos', 'Restringir funcionalidades según el rol del usuario.', 'Pendiente', NULL),
(28, 'Panel de Estadísticas', 'Mostrar métricas clave del proyecto.', 'Pendiente', 101),
(29, 'Sistema de Comentarios', 'Permitir feedback en tareas asignadas.', 'Pendiente', 101),
(30, 'Documentación Final', 'Redactar la guía técnica y manual del usuario.', 'Pendiente', 101),
(31, 'Análisis de Requisitos', 'Recolectar y documentar requerimientos del cliente.', 'Pendiente', NULL),
(32, 'Diseño de Base de Datos', 'Crear modelo entidad-relación para la base de datos.', 'Pendiente', NULL),
(33, 'Configuración del Servidor', 'Instalar y configurar Apache, PHP y MySQL.', 'Pendiente', 101),
(34, 'Desarrollo Frontend', 'Maquetar la interfaz usando HTML, CSS y Bootstrap.', 'Pendiente', NULL),
(35, 'Implementación de Login', 'Desarrollar sistema de autenticación con sesiones.', 'Pendiente', NULL),
(36, 'Gestión de Usuarios', 'Crear funcionalidades para administrar usuarios.', 'Pendiente', NULL),
(37, 'Control de Accesos', 'Restringir accesos según roles definidos.', 'Pendiente', NULL),
(38, 'Panel de Estadísticas', 'Mostrar métricas y reportes del proyecto.', 'Pendiente', NULL),
(39, 'Sistema de Comentarios', 'Implementar feedback para tareas asignadas.', 'Pendiente', NULL),
(40, 'Documentación Final', 'Redactar manual técnico y de usuario.', 'Pendiente', NULL),
(41, 'Integración con API Externa', 'Conectar sistema con API de terceros.', 'Pendiente', NULL),
(42, 'Optimización de Consultas SQL', 'Mejorar rendimiento de las consultas.', 'Pendiente', NULL),
(43, 'Pruebas Unitarias', 'Crear y ejecutar pruebas para funciones críticas.', 'Pendiente', NULL),
(44, 'Desarrollo Backend', 'Programar lógica del servidor y APIs.', 'Pendiente', NULL),
(45, 'Implementación de Seguridad', 'Agregar validaciones y protección CSRF.', 'Pendiente', NULL),
(46, 'Diseño Responsivo', 'Asegurar que la web funcione en móviles.', 'Pendiente', NULL),
(47, 'Configuración de Entorno', 'Preparar entorno local y de producción.', 'Pendiente', NULL),
(48, 'Manejo de Sesiones', 'Controlar sesiones y tiempo de expiración.', 'Pendiente', NULL),
(49, 'Carga y Gestión de Archivos', 'Subir y administrar documentos y archivos.', 'Pendiente', NULL),
(50, 'Notificaciones por Email', 'Enviar alertas y mensajes a usuarios.', 'Pendiente', NULL),
(51, 'Interfaz de Usuario', 'Mejorar experiencia y usabilidad.', 'Pendiente', NULL),
(52, 'Despliegue en Servidor', 'Subir proyecto a servidor remoto.', 'Pendiente', NULL),
(53, 'Backup de Base de Datos', 'Crear copias de seguridad automáticas.', 'Pendiente', NULL),
(54, 'Control de Versiones', 'Configurar repositorio Git y ramas.', 'Pendiente', NULL),
(55, 'Diseño de Base de Datos Avanzado', 'Implementar índices y claves foráneas.', 'Pendiente', NULL),
(56, 'Documentación de Código', 'Agregar comentarios y documentación interna.', 'Pendiente', NULL),
(57, 'Automatización de Tareas', 'Crear scripts para tareas repetitivas.', 'Pendiente', NULL),
(58, 'Migración de Datos', 'Importar datos desde sistemas antiguos.', 'Pendiente', NULL),
(59, 'Gestión de Roles y Permisos', 'Definir y aplicar permisos granularmente.', 'Pendiente', NULL),
(60, 'Creación de Reportes', 'Generar reportes dinámicos para usuarios.', 'Pendiente', NULL),
(61, 'Integración con Redes Sociales', 'Permitir login y compartir contenido.', 'Pendiente', NULL),
(62, 'Validación de Formularios', 'Implementar validaciones en frontend y backend.', 'Pendiente', NULL),
(63, 'Auditoría de Cambios', 'Registrar modificaciones en las tareas.', 'Pendiente', NULL),
(64, 'Optimización de Imágenes', 'Reducir tamaño y mejorar carga.', 'Pendiente', NULL),
(65, 'Implementación de Cache', 'Mejorar velocidad con sistema de cache.', 'Pendiente', NULL),
(66, 'Diseño de API REST', 'Crear endpoints para comunicación externa.', 'Pendiente', NULL),
(67, 'Gestión de Sesiones Activas', 'Monitorear y administrar sesiones abiertas.', 'Pendiente', NULL),
(68, 'Soporte Multilenguaje', 'Añadir soporte para varios idiomas.', 'Pendiente', NULL),
(69, 'Implementación de Chat', 'Agregar sistema de chat entre usuarios.', 'Pendiente', NULL),
(70, 'Validación de Seguridad', 'Revisar vulnerabilidades comunes.', 'Pendiente', NULL),
(71, 'Configuración de HTTPS', 'Implementar certificados SSL/TLS.', 'Pendiente', NULL),
(72, 'Pruebas de Integración', 'Verificar interacción entre módulos.', 'Pendiente', NULL),
(73, 'Optimización SEO', 'Mejorar posicionamiento en motores de búsqueda.', 'Pendiente', NULL),
(74, 'Configuración de Logs', 'Registrar actividad y errores del sistema.', 'Pendiente', NULL),
(75, 'Importación y Exportación', 'Agregar funcionalidades para importar y exportar datos.', 'Pendiente', NULL),
(76, 'Diseño UI/UX', 'Realizar mejoras visuales y de usabilidad.', 'Pendiente', NULL),
(77, 'Monitorización del Sistema', 'Implementar alertas y seguimiento.', 'Pendiente', NULL),
(78, 'Automatización de Despliegue', 'Configurar pipelines CI/CD.', 'Pendiente', NULL),
(79, 'Implementación de WebSockets', 'Permitir comunicación en tiempo real.', 'Pendiente', NULL),
(80, 'Creación de Tutoriales', 'Documentar uso del sistema para usuarios.', 'Pendiente', NULL),
(81, 'Pruebas de Carga', 'Simular tráfico y medir rendimiento.', 'Pendiente', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `clave` varchar(100) NOT NULL,
  `rol_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `clave`, `rol_id`) VALUES
(100, 'luis', 'luis@gmail.com', '0000', 1),
(101, 'Carlos', 'carlos@gmail.com', '2222', 3),
(103, 'Pedro', 'pedro@gmail.com', '1111', 2),
(107, 'Juan', 'juan@gmail.com', '2222', 3),
(108, 'Maria', 'maria@gmail.com', '2222', 3),
(111, 'jaime', 'jaime@gmail.com', '2222', 3),
(112, 'Ricardo', 'ricardo@gmail.com', '1111', 2),
(113, 'rosa', 'rosa@gmail.com', '2222', 3),
(114, 'cecilia', 'cecilia@gmail.com', '2222', 3),
(115, 'jorge', 'jorge@gmail.com', '0000', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `rol_id` (`rol_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `rol_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD CONSTRAINT `tareas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`);
--
-- Base de datos: `lista_tareas_db`
--
CREATE DATABASE IF NOT EXISTS `lista_tareas_db` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `lista_tareas_db`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

CREATE TABLE `tareas` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `autor_id` int(11) NOT NULL,
  `nombre_usuario` varchar(100) DEFAULT NULL,
  `clave_usuario` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `tareas`
--

INSERT INTO `tareas` (`id`, `descripcion`, `autor_id`, `nombre_usuario`, `clave_usuario`) VALUES
(5, 'Documentar sistema', 1, NULL, NULL),
(7, 'Realizar pruebas QA', 4, NULL, NULL),
(8, 'Planificar sprints', 4, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `rol` enum('Usuario','Administrador') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `rol`) VALUES
(1, 'luis', 'Usuario'),
(2, 'Carlos', 'Administrador'),
(3, 'Pedro', 'Administrador'),
(4, 'Maria', 'Usuario');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `autor_id` (`autor_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD CONSTRAINT `tareas_ibfk_1` FOREIGN KEY (`autor_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;
--
-- Base de datos: `mi_login_db`
--
CREATE DATABASE IF NOT EXISTS `mi_login_db` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `mi_login_db`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `password`) VALUES
(11, 'juan', '1000'),
(2, 'ana', '1001'),
(17, 'pedro', '1002'),
(15, 'maria', '1003'),
(5, 'carlos', '1004'),
(13, 'laura', '1005'),
(8, 'diego', '1006'),
(16, 'paula', '1007'),
(3, 'andres', '1008'),
(19, 'sofia', '1009'),
(14, 'luis', '1010'),
(4, 'camila', '1011'),
(6, 'david', '1012'),
(12, 'karla', '1013'),
(10, 'jorge', '1014'),
(7, 'diana', '1015'),
(9, 'fernando', '1016'),
(20, 'valeria', '1017'),
(18, 'ricardo', '1018'),
(1, 'alejandra', '1019');
--
-- Base de datos: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Volcado de datos para la tabla `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"cp5_tareas\",\"table\":\"usuarios\"},{\"db\":\"cp5_tareas\",\"table\":\"tareas\"},{\"db\":\"cp5_tareas\",\"table\":\"roles\"},{\"db\":\"mi_login_db\",\"table\":\"usuarios\"},{\"db\":\"biblioteca_online\",\"table\":\"usuarios\"},{\"db\":\"biblioteca_online\",\"table\":\"roles\"},{\"db\":\"biblioteca_db\",\"table\":\"books\"},{\"db\":\"biblioteca_db\",\"table\":\"users\"},{\"db\":\"tareas_equipo\",\"table\":\"usuarios_c5\"},{\"db\":\"tareas_equipo\",\"table\":\"tareas_c5\"}]');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Volcado de datos para la tabla `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'cp5_tareas', 'tareas', '{\"sorted_col\":\"`tareas`.`usuario_id` ASC\"}', '2025-07-08 13:46:28'),
('root', 'lista_tareas_db', 'tareas', '{\"sorted_col\":\"`tareas`.`clave_usuario` DESC\"}', '2025-06-26 13:48:34'),
('root', 'tareas_equipo', 'roles_c5', '{\"sorted_col\":\"`roles_c5`.`rol_id` ASC\"}', '2025-06-30 13:58:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Volcado de datos para la tabla `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2025-07-08 14:53:46', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"es\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indices de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indices de la tabla `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indices de la tabla `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indices de la tabla `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indices de la tabla `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indices de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indices de la tabla `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indices de la tabla `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indices de la tabla `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indices de la tabla `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indices de la tabla `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indices de la tabla `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indices de la tabla `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Base de datos: `tareas_equipo`
--
CREATE DATABASE IF NOT EXISTS `tareas_equipo` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `tareas_equipo`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles_c5`
--

CREATE TABLE `roles_c5` (
  `rol_id` int(11) NOT NULL,
  `rol_nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `roles_c5`
--

INSERT INTO `roles_c5` (`rol_id`, `rol_nombre`) VALUES
(1, 'Administrador'),
(2, 'Gerente de proyecto'),
(3, 'Miembro del equipo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas_c5`
--

CREATE TABLE `tareas_c5` (
  `id` int(11) NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `descripcion` varchar(300) DEFAULT NULL,
  `estado` varchar(10) DEFAULT 'Pendiente',
  `usuario_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `tareas_c5`
--

INSERT INTO `tareas_c5` (`id`, `titulo`, `descripcion`, `estado`, `usuario_id`) VALUES
(1, 'Red Neuronal Simple', NULL, 'Pendiente', NULL),
(2, 'Clasificador de Imágenes', NULL, 'Pendiente', NULL),
(3, 'Sistema Experto Médico', NULL, 'Pendiente', NULL),
(4, 'Predicción del Clima', NULL, 'Pendiente', NULL),
(5, 'Control de Semáforos', NULL, 'Pendiente', NULL),
(6, 'Reconocimiento de Voz', NULL, 'Pendiente', NULL),
(7, 'Chatbot de Atención', NULL, 'Pendiente', NULL),
(8, 'Visión por Computadora', NULL, 'Pendiente', NULL),
(9, 'Sistema de Recomendación', NULL, 'Pendiente', NULL),
(10, 'Optimización con Genéticos', NULL, 'Pendiente', NULL),
(11, 'Robot Seguidor de Línea', NULL, 'Pendiente', NULL),
(12, 'Predicción de Ventas IA', NULL, 'Pendiente', NULL),
(13, 'Clasificador de Texto', NULL, 'Pendiente', NULL),
(14, 'Sistema de Detección Facial', NULL, 'Pendiente', NULL),
(15, 'Monitoreo con IoT', NULL, 'Pendiente', NULL),
(16, 'Procesamiento de Lenguaje', NULL, 'Pendiente', NULL),
(17, 'Análisis de Sentimiento', NULL, 'Pendiente', NULL),
(18, 'Detección de Anomalías', NULL, 'Pendiente', NULL),
(19, 'Control Inteligente de Tráfico', NULL, 'Pendiente', NULL),
(20, 'Plataforma de Aprendizaje IA', NULL, 'Pendiente', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_c5`
--

CREATE TABLE `usuarios_c5` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contraseña` varchar(100) NOT NULL,
  `rol_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `roles_c5`
--
ALTER TABLE `roles_c5`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `tareas_c5`
--
ALTER TABLE `tareas_c5`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `usuarios_c5`
--
ALTER TABLE `usuarios_c5`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `rol_id` (`rol_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `roles_c5`
--
ALTER TABLE `roles_c5`
  MODIFY `rol_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tareas_c5`
--
ALTER TABLE `tareas_c5`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `usuarios_c5`
--
ALTER TABLE `usuarios_c5`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tareas_c5`
--
ALTER TABLE `tareas_c5`
  ADD CONSTRAINT `tareas_c5_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios_c5` (`id`);

--
-- Filtros para la tabla `usuarios_c5`
--
ALTER TABLE `usuarios_c5`
  ADD CONSTRAINT `usuarios_c5_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles_c5` (`rol_id`);
--
-- Base de datos: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

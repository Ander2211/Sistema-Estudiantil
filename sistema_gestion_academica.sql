-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 19-10-2025 a las 20:01:03
-- Versión del servidor: 9.1.0
-- Versión de PHP: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_gestion_academica`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignacion_maestro_aula`
--

DROP TABLE IF EXISTS `asignacion_maestro_aula`;
CREATE TABLE IF NOT EXISTS `asignacion_maestro_aula` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maestro_id` int NOT NULL,
  `aula_id` int NOT NULL,
  `materia_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `maestro_id` (`maestro_id`),
  KEY `aula_id` (`aula_id`),
  KEY `materia_id` (`materia_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

DROP TABLE IF EXISTS `asistencia`;
CREATE TABLE IF NOT EXISTS `asistencia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `estudiante_id` int DEFAULT NULL,
  `materia_id` int DEFAULT NULL,
  `maestro_id` int DEFAULT NULL,
  `fecha` date DEFAULT (curdate()),
  `estado` enum('Presente','Ausente') DEFAULT 'Ausente',
  PRIMARY KEY (`id`),
  KEY `fk_asistencia_estudiante` (`estudiante_id`),
  KEY `fk_asistencia_materia` (`materia_id`),
  KEY `fk_asistencia_maestro` (`maestro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calendario`
--

DROP TABLE IF EXISTS `calendario`;
CREATE TABLE IF NOT EXISTS `calendario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `color` varchar(20) DEFAULT '#3788d8',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `calendario`
--

INSERT INTO `calendario` (`id`, `titulo`, `descripcion`, `fecha_inicio`, `fecha_fin`, `color`) VALUES
(19, 'Dia del Niño', '', '2025-10-01', '2025-10-01', '#37d757'),
(13, 'Entrega de tarea de ciencias para quinto', '', '2025-10-14', '2025-10-16', '#37d757'),
(15, 'No hay clases', '', '2025-10-30', '2025-10-31', '#b0b0b0'),
(16, 'Tarea de Moral', '', '2025-10-13', '2025-10-14', '#6551f5');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiantesalon`
--

DROP TABLE IF EXISTS `estudiantesalon`;
CREATE TABLE IF NOT EXISTS `estudiantesalon` (
  `id` int NOT NULL AUTO_INCREMENT,
  `estudiante_id` int DEFAULT NULL,
  `salon_id` int DEFAULT NULL,
  `grado` varchar(50) DEFAULT NULL,
  `anio_escolar` year DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_estudiantesalon_estudiante` (`estudiante_id`),
  KEY `fk_estudiantesalon_salon` (`salon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grado`
--

DROP TABLE IF EXISTS `grado`;
CREATE TABLE IF NOT EXISTS `grado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `turno` enum('mañana','tarde') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `grado`
--

INSERT INTO `grado` (`id`, `nombre`, `turno`) VALUES
(1, 'Primero', 'mañana'),
(2, 'Primero', 'tarde'),
(3, 'Segundo', 'mañana'),
(4, 'Segundo', 'tarde'),
(5, 'Tercero', 'mañana'),
(6, 'Tercero', 'tarde'),
(7, 'Cuarto', 'mañana'),
(8, 'Cuarto', 'tarde'),
(9, 'Quinto', 'mañana'),
(10, 'Quinto', 'tarde');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horario`
--

DROP TABLE IF EXISTS `horario`;
CREATE TABLE IF NOT EXISTS `horario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `grado_id` int DEFAULT NULL,
  `materia_id` int DEFAULT NULL,
  `dia_semana` enum('Lunes','Martes','Miércoles','Jueves','Viernes') DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_horario_grado` (`grado_id`),
  KEY `fk_horario_materia` (`materia_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `horario`
--

INSERT INTO `horario` (`id`, `grado_id`, `materia_id`, `dia_semana`, `hora_inicio`, `hora_fin`) VALUES
(14, 1, 6, 'Lunes', '07:15:00', '08:10:00'),
(15, 1, 8, 'Lunes', '08:10:00', '08:55:00'),
(16, 1, 2, 'Lunes', '08:55:00', '09:50:00'),
(17, 1, 8, 'Lunes', '09:50:00', '10:35:00'),
(18, 1, 3, 'Lunes', '10:35:00', '11:30:00'),
(19, 1, 5, 'Martes', '07:15:00', '08:10:00'),
(20, 1, 8, 'Martes', '08:10:00', '08:55:00'),
(21, 1, 5, 'Martes', '08:55:00', '09:50:00'),
(22, 1, 8, 'Martes', '09:50:00', '10:35:00'),
(23, 1, 3, 'Martes', '10:35:00', '11:30:00'),
(24, 1, 2, 'Miércoles', '07:15:00', '08:10:00'),
(25, 1, 8, 'Miércoles', '08:10:00', '08:55:00'),
(26, 1, 2, 'Miércoles', '08:55:00', '09:50:00'),
(27, 1, 8, 'Miércoles', '09:50:00', '10:35:00'),
(28, 1, 3, 'Miércoles', '10:35:00', '11:30:00'),
(29, 1, 1, 'Jueves', '07:15:00', '08:10:00'),
(30, 1, 8, 'Jueves', '08:10:00', '08:55:00'),
(31, 1, 2, 'Jueves', '08:55:00', '09:50:00'),
(32, 1, 8, 'Jueves', '09:50:00', '10:35:00'),
(33, 1, 3, 'Jueves', '10:35:00', '11:30:00'),
(34, 1, 1, 'Viernes', '07:15:00', '08:10:00'),
(35, 1, 8, 'Viernes', '08:10:00', '08:55:00'),
(36, 1, 2, 'Viernes', '08:55:00', '09:50:00'),
(37, 1, 8, 'Viernes', '09:50:00', '10:35:00'),
(38, 1, 3, 'Viernes', '10:35:00', '11:30:00'),
(39, 2, 1, 'Lunes', '13:00:00', '13:55:00'),
(40, 2, 8, 'Lunes', '13:55:00', '14:40:00'),
(41, 2, 2, 'Lunes', '14:40:00', '15:35:00'),
(42, 2, 8, 'Lunes', '15:35:00', '16:20:00'),
(43, 2, 3, 'Lunes', '16:20:00', '17:15:00'),
(44, 2, 4, 'Martes', '13:00:00', '13:55:00'),
(45, 2, 8, 'Martes', '13:55:00', '14:40:00'),
(46, 2, 5, 'Martes', '14:40:00', '15:35:00'),
(47, 2, 8, 'Martes', '15:35:00', '16:20:00'),
(48, 2, 6, 'Martes', '16:20:00', '17:15:00'),
(49, 2, 7, 'Miércoles', '13:00:00', '13:55:00'),
(50, 2, 8, 'Miércoles', '13:55:00', '14:40:00'),
(51, 2, 1, 'Miércoles', '14:40:00', '15:35:00'),
(52, 2, 8, 'Miércoles', '15:35:00', '16:20:00'),
(53, 2, 2, 'Miércoles', '16:20:00', '17:15:00'),
(54, 2, 3, 'Jueves', '13:00:00', '13:55:00'),
(55, 2, 8, 'Jueves', '13:55:00', '14:40:00'),
(56, 2, 4, 'Jueves', '14:40:00', '15:35:00'),
(57, 2, 8, 'Jueves', '15:35:00', '16:20:00'),
(58, 2, 5, 'Jueves', '16:20:00', '17:15:00'),
(59, 2, 6, 'Viernes', '13:00:00', '13:55:00'),
(60, 2, 8, 'Viernes', '13:55:00', '14:40:00'),
(61, 2, 7, 'Viernes', '14:40:00', '15:35:00'),
(62, 2, 8, 'Viernes', '15:35:00', '16:20:00'),
(63, 2, 1, 'Viernes', '16:20:00', '17:15:00');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `horario_completo`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `horario_completo`;
CREATE TABLE IF NOT EXISTS `horario_completo` (
`dia_semana` enum('Lunes','Martes','Miércoles','Jueves','Viernes')
,`grado_id` int
,`grado_nombre` varchar(50)
,`grado_turno` enum('mañana','tarde')
,`hora_fin` time
,`hora_inicio` time
,`id` int
,`materia_id` int
,`materia_nombre` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

DROP TABLE IF EXISTS `materia`;
CREATE TABLE IF NOT EXISTS `materia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `materia`
--

INSERT INTO `materia` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Lenguaje y Literatura', NULL),
(2, 'Matemáticas', NULL),
(3, 'Sociales', NULL),
(4, 'Ciencias', NULL),
(5, 'Educación Física', NULL),
(6, 'Informática', NULL),
(7, 'Inglés', NULL),
(8, 'Recreo', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nota`
--

DROP TABLE IF EXISTS `nota`;
CREATE TABLE IF NOT EXISTS `nota` (
  `id` int NOT NULL AUTO_INCREMENT,
  `estudiante_id` int DEFAULT NULL,
  `materia_id` int DEFAULT NULL,
  `maestro_id` int DEFAULT NULL,
  `nota` decimal(4,2) DEFAULT NULL,
  `periodo` varchar(50) DEFAULT NULL,
  `fecha_registro` date DEFAULT (curdate()),
  PRIMARY KEY (`id`),
  KEY `fk_nota_estudiante` (`estudiante_id`),
  KEY `fk_nota_materia` (`materia_id`),
  KEY `fk_nota_maestro` (`maestro_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

DROP TABLE IF EXISTS `pago`;
CREATE TABLE IF NOT EXISTS `pago` (
  `id` int NOT NULL AUTO_INCREMENT,
  `estudiante_id` int DEFAULT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `concepto` varchar(200) DEFAULT NULL,
  `fecha_pago` date DEFAULT NULL,
  `estado` enum('pendiente','pagado') DEFAULT 'pendiente',
  PRIMARY KEY (`id`),
  KEY `fk_pago_estudiante` (`estudiante_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reporte`
--

DROP TABLE IF EXISTS `reporte`;
CREATE TABLE IF NOT EXISTS `reporte` (
  `id` int NOT NULL AUTO_INCREMENT,
  `estudiante_id` int DEFAULT NULL,
  `maestro_id` int DEFAULT NULL,
  `tipo` enum('conducta','academico','inasistencias') DEFAULT NULL,
  `descripcion` text,
  `fecha` date DEFAULT (curdate()),
  PRIMARY KEY (`id`),
  KEY `fk_reporte_estudiante` (`estudiante_id`),
  KEY `fk_reporte_maestro` (`maestro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salon`
--

DROP TABLE IF EXISTS `salon`;
CREATE TABLE IF NOT EXISTS `salon` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `capacidad` int DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `salon`
--

INSERT INTO `salon` (`id`, `nombre`, `capacidad`, `ubicacion`) VALUES
(1, 'Aula 101', 30, 'Edificio Principal - Primer Piso'),
(2, 'Aula 102', 25, 'Edificio Principal - Primer Piso'),
(3, 'Laboratorio Computación', 20, 'Edificio Ciencia - Segundo Piso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `carnet` varchar(20) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contraseña` varchar(255) NOT NULL,
  `rol` enum('estudiante','maestro','admin') NOT NULL,
  `grado` varchar(50) DEFAULT NULL,
  `turno` enum('mañana','tarde') DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `carnet` (`carnet`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `carnet`, `nombre`, `email`, `contraseña`, `rol`, `grado`, `turno`, `activo`) VALUES
(1, '00123', 'Anderson Hernández', NULL, '123', 'estudiante', 'Quinto', 'tarde', 1),
(2, '00124', 'Ángel Martínez', NULL, '123', 'estudiante', 'Quinto', 'tarde', 1),
(4, 'PROF001', 'Juan Carlos Menjívar', 'juan@gmail.com', '124', 'maestro', NULL, NULL, 1),
(5, 'admin001', 'Administrador Principal', 'admin@escuela.edu', 'admin123', 'admin', NULL, NULL, 1),
(7, 'PROF003', 'Carlos Roberto Silva', 'carlos@escuela.edu', '123', 'maestro', NULL, NULL, 1),
(10, '00125', 'Luis Angel', '33null@gmail.com', '123', 'estudiante', 'Tercero', 'mañana', 1),
(11, '00126', 'Jose', 'jose@gmail.com', '123', 'estudiante', 'Segundo', 'mañana', 1),
(15, '00156', 'Josue', 'josue06@gmail.com', '123', 'estudiante', 'Primero', 'mañana', 1),
(16, '00157', 'Pablo', 'pablo06@gmail.com', '123', 'estudiante', 'Segundo', 'mañana', 1),
(17, 'PROF006', 'Eduardo', 'eduardo@gmail.com', '123', 'maestro', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura para la vista `horario_completo`
--
DROP TABLE IF EXISTS `horario_completo`;

DROP VIEW IF EXISTS `horario_completo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `horario_completo`  AS SELECT `h`.`id` AS `id`, `h`.`grado_id` AS `grado_id`, `g`.`nombre` AS `grado_nombre`, `g`.`turno` AS `grado_turno`, `h`.`materia_id` AS `materia_id`, `m`.`nombre` AS `materia_nombre`, `h`.`dia_semana` AS `dia_semana`, `h`.`hora_inicio` AS `hora_inicio`, `h`.`hora_fin` AS `hora_fin` FROM ((`horario` `h` join `grado` `g` on((`h`.`grado_id` = `g`.`id`))) join `materia` `m` on((`h`.`materia_id` = `m`.`id`))) ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `horario`
--
ALTER TABLE `horario`
  ADD CONSTRAINT `fk_horario_grado` FOREIGN KEY (`grado_id`) REFERENCES `grado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_horario_materia` FOREIGN KEY (`materia_id`) REFERENCES `materia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `fk_pago_estudiante` FOREIGN KEY (`estudiante_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reporte`
--
ALTER TABLE `reporte`
  ADD CONSTRAINT `fk_reporte_estudiante` FOREIGN KEY (`estudiante_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_reporte_maestro` FOREIGN KEY (`maestro_id`) REFERENCES `usuario` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

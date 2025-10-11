-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 11-10-2025 a las 02:30:02
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
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `calendario`
--

INSERT INTO `calendario` (`id`, `titulo`, `descripcion`, `fecha_inicio`, `fecha_fin`, `color`) VALUES
(12, 'Tarea Lenguaje', '', '2025-10-07', '2025-10-07', '#fb9056'),
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `horario`
--

INSERT INTO `horario` (`id`, `grado_id`, `materia_id`, `dia_semana`, `hora_inicio`, `hora_fin`) VALUES
(1, 1, 1, 'Lunes', '07:02:11', '07:02:11'),
(2, 2, 1, 'Lunes', '09:02:11', '11:02:11');

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
(8, 'Física', NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `carnet`, `nombre`, `email`, `contraseña`, `rol`, `grado`, `turno`, `activo`) VALUES
(1, '00123', 'Anderson Hernández', NULL, '123', 'estudiante', 'Quinto', 'tarde', 1),
(2, '00124', 'Ángel Martínez', NULL, '123', 'estudiante', 'Quinto', 'tarde', 1),
(3, '00125', 'Daniel Lopez', '33null@g.com', '123', 'estudiante', 'Tercero', 'mañana', 1),
(4, 'PROF001', 'Juan Carlos Menjívar', NULL, '124', 'maestro', NULL, NULL, 1),
(5, 'admin001', 'Administrador Principal', 'admin@escuela.edu', 'admin123', 'admin', NULL, NULL, 1),
(7, 'PROF003', 'Carlos Roberto Silva', 'carlos@escuela.edu', '123', 'maestro', NULL, NULL, 1);

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

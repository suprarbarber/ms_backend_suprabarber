-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-06-2024 a las 05:41:11
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
-- Base de datos: `suprabarber`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `identificacion` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `contrasena` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo_electronico` varchar(255) NOT NULL,
  `estado_cuenta` varchar(10) DEFAULT 'ACTIVO',
  `tipo_cuenta` varchar(10) DEFAULT 'CORRIENTE',
  `roll` varchar(10) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `identificacion` (`identificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `identificacion`, `nombre`, `contrasena`, `telefono`, `correo_electronico`, `estado_cuenta`, `tipo_cuenta`, `roll`) VALUES
(46, 989, 'Andre London', '$2b$04$ejGmIb/H8bDxnuOGC2evIONRTRcfXnnBQU.t0BkAPCp4x2zU8c9ea', '33', 'llanta400@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(68, 6048, 'freddy Giraldo', '$2b$04$ZwibRY3p2T2pAe2lKtIlsuLWe4Lu5vFCfZJMwBooC6ySeHK30yo/y', '888', 'freddy1@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(74, 2, 'freddy Frenandez', '$2b$04$uASPt4ruESmKZINfR.MqK.SwpeH7T9FbhMM8RbA06QgrgJi0d5YmO', '000', 'frecos1@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(81, 1000414627, 'freddy Frenandez', '$2b$04$qNvccQW6n99.5orU7tMRj.Two0DZFYGhuJf5tvBacR.QyWm1sF2yW', '000', 'frelucas@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(82, 99, 'laura Frenandez', '$2b$04$U8f/5X9OCkZ0ntAJ16LQcuyGBKa54JjcdX76UnVNodDWWYp3ylyoq', '000', 'laura@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(83, 6778, 'laura Frenandez', '$2b$04$kU9YYKZy/clz/cZW8xQgk.tiLIE8iPugcIvkupO.yPkazAv7k0UNu', '000', 'pati@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(84, 97656, 'laura Frenandez', '$2b$04$dF76rv0cdU6ATX4D8OP0Q.cZ7..jTbd7FG2bo99Cqa/fSusBD.N92', '000', 'patito@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(85, 1001, 'laura Frenandez', '$2b$04$de2H3w4WMMQ3eJZSpCavUOlOpt0oLTwP4/t59R25YzsummzSzSai2', '000', 'pat001@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(86, 10099, 'laura Frenandez', '$2b$04$gGo1iGKlggrEKGTP1A2T5e3s5Wr6VVolcg5IAdCBfduAwMrQC5ml2', '000', 'polo1@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(87, 1009977, 'laura Frenandez', '$2b$04$Cck7C/K02j58e7G5KTPWIOlyNVlXqg5ubt/qKPkSKwNxdQ6X4k.Mi', '000', '1100@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(88, 100997755, 'laura Frenandez', '$2b$04$ey.kuLsUwFo3TdIAUNVBuucInS1RqWSa6EWR/TZh6sijE4EVDqxxG', '000', '1100uu@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(89, 9898, 'luna Frenandez', '$2b$04$CCkzIOBUyZcmxGU2PFuVOe37YCwJaIrMB7GGAQQm29bQn6WZkgfMa', '000', 'luna@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(90, 7778, 'luna Frenandez', '$2b$04$NNLPhRzxWnGWcGuZQwS3GOx.owjEL/Cz4qX.FGxDA97XzzQB8FD0m', '000', 'lueuwj@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(91, 777, 'Caribe Londoño', '$2b$04$TOlK/U3T9TQgAFmwMwfEAOShXbY.ZDTZvhnCGzdhSQWjUdwtWEneO', '67237623', 'caribe@gmail.com', 'ACTIVO', 'CORRIENTE', 'barbero'),
(93, 86788, 'Loreno Perez', '$2b$04$lPeUOFqhXmKLy1fVrKXUNO2l4QzOEBOZvaVqPantUXW6apg3FWoF.', '7867678', 'lore@gmail.com', 'ACTIVO', 'CORRIENTE', 'barbero'),
(94, 9889654, 'lorena', '$2b$04$LEw4qS2/rzJ22MkiRnoTWuflrKLDGkCZTQD3.jDnCSDIRiDb7qjE6', '667363', 'lorenas@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(96, 221, 'CLAUDIA CORDOBA', '$2b$04$zwzJAmave5y0eStvaygs6uZHN25YDIOf2PUy.FBSFY6.djgTkdDTC', '738766565', 'clau@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

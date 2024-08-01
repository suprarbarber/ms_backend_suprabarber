-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 30-07-2024 a las 01:28:24
-- Versión del servidor: 8.3.0
-- Versión de PHP: 8.1.2-1ubuntu2.18

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
CREATE DATABASE IF NOT EXISTS `suprabarber` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `suprabarber`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_CORREO_CLIENTE`$$
CREATE PROCEDURE `SP_ACTUALIZAR_CORREO_CLIENTE` (IN `_ID` INT(11), IN `_CORREO` VARCHAR(200))   BEGIN

UPDATE clientes SET correo = _CORREO
WHERE id_cliente = _ID;

END$$

DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_NOMBRE_CLIENTE`$$
CREATE PROCEDURE `SP_ACTUALIZAR_NOMBRE_CLIENTE` (IN `_ID` INT(11), IN `_NOMBRE` VARCHAR(200))   BEGIN

UPDATE clientes SET nombre = _NOMBRE
WHERE id_cliente = _ID;

END$$

DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_TELEFONO_CLIENTE`$$
CREATE PROCEDURE `SP_ACTUALIZAR_TELEFONO_CLIENTE` (IN `_ID` INT(11), IN `_TEL` BIGINT(10))   BEGIN

UPDATE clientes SET telefono = _TEL
WHERE id_cliente = _ID;

END$$

DROP PROCEDURE IF EXISTS `SP_CANCELAR_CITA`$$
CREATE PROCEDURE `SP_CANCELAR_CITA` (IN `_ID_RESERVA` INT)   BEGIN

UPDATE reservas SET estado_reserva = 'CANCELADO'
WHERE id_reserva = _ID_RESERVA;

END$$

DROP PROCEDURE IF EXISTS `SP_CREAR_CITA`$$
CREATE PROCEDURE `SP_CREAR_CITA` (IN `_ID_TURNO` INT(11), IN `_ID_SERVICIO` INT(11), IN `_FECHA` DATE)   BEGIN

INSERT INTO reservas(id_servicio, id_registro_horario, fecha) VALUES (_ID_SERVICIO, _ID_TURNO, _FECHA);
SELECT LAST_INSERT_ID() AS id_reserva;

END$$

DROP PROCEDURE IF EXISTS `SP_CREAR_FACTURA_CITA`$$
CREATE PROCEDURE `SP_CREAR_FACTURA_CITA` (IN `_ID_RESERVA` INT(11), IN `_ID_CORTE` INT(11), IN `_ID_CLIENTE` INT(11), IN `_ID_BARBERO` INT(11))   INSERT INTO factura_reserva(id_reserva, id_corte,id_cliente, id_barbero)
VALUES (_ID_RESERVA, _ID_CORTE, _ID_CLIENTE,_ID_BARBERO)$$

DROP PROCEDURE IF EXISTS `SP_CREAR_RESENA`$$
CREATE PROCEDURE `SP_CREAR_RESENA` (IN `_ID` INT(11), IN `_COMENTARIO` VARCHAR(255))   BEGIN
INSERT INTO resenas ( id_cliente, comentario) VALUES (_ID, _COMENTARIO);

END$$

DROP PROCEDURE IF EXISTS `SP_DESACTIVAR_CUENTA_CLIENTE`$$
CREATE PROCEDURE `SP_DESACTIVAR_CUENTA_CLIENTE` (IN `_ID` INT(11))   BEGIN
UPDATE clientes
SET estado_cuenta ='INACTIVO' 
WHERE id_cliente = _ID;

END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_RESENAS`$$
CREATE PROCEDURE `SP_ELIMINAR_RESENAS` (IN `_ID` INT(11), IN `_ID_RESENA` INT(11))   BEGIN

DELETE FROM resenas
WHERE id_cliente = _ID AND id_resena = _ID_RESENA;


END$$

DROP PROCEDURE IF EXISTS `SP_LOGUEAR_ADMIN`$$
CREATE PROCEDURE `SP_LOGUEAR_ADMIN` (IN `_CORREO` VARCHAR(200))   BEGIN

SELECT A.usuario, A.contrasena
FROM administrador A 
WHERE A.usuario = _CORREO COLLATE utf8mb4_general_ci;

END$$

DROP PROCEDURE IF EXISTS `SP_LOGUEAR_USUARIO`$$
CREATE PROCEDURE `SP_LOGUEAR_USUARIO` (IN `_CORREO` VARCHAR(200))   BEGIN

SELECT C.id_cliente, C.nombre, C.contrasena, C.correo
FROM clientes C
WHERE correo COLLATE utf8mb4_general_ci = _CORREO COLLATE utf8mb4_general_ci AND C.estado_cuenta = 'ACTIVO';

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_BARBEROS`$$
CREATE PROCEDURE `SP_MOSTRAR_BARBEROS` ()   BEGIN
SELECT B.id_barbero, B.nombre, B.telefono, B.contrasena, B.correo
FROM barberos B;
END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_CALIFICACION`$$
CREATE PROCEDURE `SP_MOSTRAR_CALIFICACION` ()   BEGIN 
SELECT C.id_cliente, C.comentario
FROM calificacion C;
END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_CITAS`$$
CREATE PROCEDURE `SP_MOSTRAR_CITAS` (IN `_ID` INT(11))   BEGIN
SELECT R.id_reserva,R.estado_reserva,R.fecha,B.nombre AS barbero,H.hora_inicial AS turno, C.nombre AS corte
FROM factura_reserva F
INNER JOIN cortes C ON F.id_corte = C.id_corte
INNER JOIN reservas R ON F.id_reserva = R.id_reserva
INNER JOIN registro_horarios H ON R.id_registro_horario = H.id_registro_horario
INNER JOIN barberos B ON F.id_barbero = B.id_barbero
WHERE F.id_cliente = _ID;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_CORTES`$$
CREATE PROCEDURE `SP_MOSTRAR_CORTES` ()   BEGIN

SELECT C.id_corte, C.nombre, C.url_imagen
FROM cortes C;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_CORTES_SERVICIO`$$
CREATE PROCEDURE `SP_MOSTRAR_CORTES_SERVICIO` (IN `_ID_SERVICIO` INT(11))   BEGIN
SELECT C.id_corte ,C.nombre, C.id_servicio, C.url_imagen
FROM cortes C
WHERE id_servicio = _ID_SERVICIO;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_PRODUCTOS`$$
CREATE PROCEDURE `SP_MOSTRAR_PRODUCTOS` ()   BEGIN

SELECT P.nombre, P.descripcion, P.precio, P.url_imagen
FROM productos P;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_PROMOCIONES`$$
CREATE PROCEDURE `SP_MOSTRAR_PROMOCIONES` ()   BEGIN
SELECT p.codigo ,p.descripcion, p.codigo
FROM promociones p;
END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_RESENAS`$$
CREATE PROCEDURE `SP_MOSTRAR_RESENAS` ()   BEGIN

SELECT R.id_resena,R.id_cliente,C.nombre,R.comentario
FROM resenas R
INNER JOIN clientes C ON R.id_cliente = C.id_cliente;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_SERVICIOS`$$
CREATE PROCEDURE `SP_MOSTRAR_SERVICIOS` ()   BEGIN

SELECT S.nombre, S.id_servicio
FROM servicios S;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_TODOS_CLIENTES`$$
CREATE PROCEDURE `SP_MOSTRAR_TODOS_CLIENTES` ()   BEGIN

SELECT C.id_cliente, C.nombre, C.telefono, C.correo
FROM clientes C;
END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_TURNO`$$
CREATE PROCEDURE `SP_MOSTRAR_TURNO` ()   BEGIN

SELECT R.hora_inicial, R.id_registro_horario
FROM registro_horarios R;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_UN_BARBERO`$$
CREATE PROCEDURE `SP_MOSTRAR_UN_BARBERO` (IN `_ID` INT(11))   BEGIN

SELECT B.id_barbero, B.nombre, B.telefono, B.contrasena, B.correo
FROM barberos B 
WHERE B.id_barbero = _ID;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_UN_CLIENTE`$$
CREATE PROCEDURE `SP_MOSTRAR_UN_CLIENTE` (IN `_ID` INT(11))   BEGIN

SELECT C.id_cliente, C.nombre, C.telefono, C.contrasena, C.correo
FROM clientes C
WHERE C.id_cliente = _ID;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_UN_CORTE`$$
CREATE PROCEDURE `SP_MOSTRAR_UN_CORTE` (IN `_ID` INT(11))   BEGIN

SELECT C.nombre
FROM cortes C
WHERE C.id_corte = _ID;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_UN_PRODUCTO`$$
CREATE PROCEDURE `SP_MOSTRAR_UN_PRODUCTO` (IN `_ID` INT)   BEGIN

SELECT P.nombre, P.descripcion, P.stock
FROM productos P
WHERE P.id_producto = _ID;

END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_BARBERO`$$
CREATE PROCEDURE `SP_REGISTRAR_BARBERO` (IN `_ID` INT(11), IN `_NOMBRE` VARCHAR(200), IN `_TELEFONO` BIGINT(10), IN `_CONTRA` VARCHAR(200), IN `_CORREO` VARCHAR(200))   BEGIN

INSERT INTO barberos(id_barbero, nombre, telefono, contrasena,correo)
VALUES (_ID, _NOMBRE, _TELEFONO, _CONTRA, _CORREO);

END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_CLIENTE`$$
CREATE PROCEDURE `SP_REGISTRAR_CLIENTE` (IN `_ID` INT(11), IN `_NOMBRE` VARCHAR(200), IN `_TELEFONO` BIGINT(10), IN `_CORREO` VARCHAR(200), IN `_CONTRA` VARCHAR(200))   BEGIN

INSERT INTO clientes(id_cliente, nombre, telefono, contrasena,correo)
VALUES (_ID, _NOMBRE, _TELEFONO, _CONTRA, _CORREO);

END$$

DROP PROCEDURE IF EXISTS `SP_REPROGRAMAR_CITA`$$
CREATE PROCEDURE `SP_REPROGRAMAR_CITA` (IN `_ID_RESERVA` INT(11), IN `_ID_HORARIO` INT(11), IN `_FECHA` DATE)   BEGIN

UPDATE reservas SET id_registro_horario = _ID_HORARIO, estado_reserva = 'REPROGRAMADO', fecha = _FECHA
WHERE id_reserva = _ID_RESERVA;

END$$

DROP PROCEDURE IF EXISTS `SP_VERIFICAR_CUENTA_CLIENTE`$$
CREATE PROCEDURE `SP_VERIFICAR_CUENTA_CLIENTE` (IN `_ID` INT)   BEGIN

SELECT C.correo, C.contrasena
FROM clientes C
WHERE C.id_cliente = _ID;

END$$

DROP PROCEDURE IF EXISTS `SP_VERIFICAR_EXISTENCIA_DE_CUENTA`$$
CREATE PROCEDURE `SP_VERIFICAR_EXISTENCIA_DE_CUENTA` (IN `_ID` INT(11), IN `_CORREO` VARCHAR(255))   BEGIN 

SELECT C.id_cliente, C.nombre, C.correo
FROM clientes C
WHERE C.id_cliente = _ID OR C.correo COLLATE utf8mb4_general_ci = _CORREO COLLATE utf8mb4_general_ci;


END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

DROP TABLE IF EXISTS `administrador`;
CREATE TABLE `administrador` (
  `id_administrador` int NOT NULL,
  `usuario` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `contrasena` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`id_administrador`, `usuario`, `contrasena`) VALUES
(1, 'admin', '$2b$04$ey.kuLsUwFo3TdIAUNVBuucInS1RqWSa6EWR/TZh6sijE4EVDqxxG');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barberia`
--

DROP TABLE IF EXISTS `barberia`;
CREATE TABLE `barberia` (
  `id_barberia` int NOT NULL,
  `nombre` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `estado` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `id_ubicacion` int NOT NULL,
  `id_links` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barberos`
--

DROP TABLE IF EXISTS `barberos`;
CREATE TABLE `barberos` (
  `id_barbero` int NOT NULL,
  `nombre` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` bigint NOT NULL,
  `contrasena` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `correo` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `estado_cuenta` varchar(200) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'ACTIVO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `barberos`
--

INSERT INTO `barberos` (`id_barbero`, `nombre`, `telefono`, `contrasena`, `correo`, `estado_cuenta`) VALUES
(555, 'Camilo Perez', 4577494, 'camilo@gmail.com', '$2b$04$ZYTB03FNRpAftSWLo8m/CeZ0fmv3g.CWBdwEAPQUxRj9u5g8WoiZu', 'ACTIVO'),
(78847, 'facundo', 32443, 'facu@gmail.com', '$2b$04$satmt1UR.L1L108HFwerqeI99qY7H8ak9NIckoX.gBkOku0WwZ3aC', 'ACTIVO'),
(1000414627, 'Freddy Giraldo', 2147483647, 'pacholindo@gmail.com', '$2b$04$LQtot4/Uj/nS54pPzsEwne/zwcHqlMXj2yuEli.cCRCTrKwzH/EQ6', 'ACTIVO'),
(1111111111, 'Coco Ramirez', 3015431236, 'coco@gmail.com', '$2b$04$dxp9yJ3VrUHr7YHgpjOTF.T2wxu1TlX2y1sWKd1aZoQtECqJHM7eO', 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificacion`
--

DROP TABLE IF EXISTS `calificacion`;
CREATE TABLE `calificacion` (
  `id_calificacion` int NOT NULL,
  `comentario` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `id_cliente` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `calificacion`
--

INSERT INTO `calificacion` (`id_calificacion`, `comentario`, `id_cliente`) VALUES
(1, 'muy buena', NULL),
(2, 'muy buena', NULL),
(3, 'muy buena', NULL),
(4, 'BUENA', NULL),
(5, 'Muy bueno', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL,
  `nombre` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` bigint NOT NULL,
  `contrasena` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `correo` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `estado_cuenta` varchar(10) COLLATE utf8mb4_general_ci DEFAULT 'ACTIVO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombre`, `telefono`, `contrasena`, `correo`, `estado_cuenta`) VALUES
(900, 'Dario Nohava', 849343, '$2b$04$ASm8mGiDbPk9.KKglGAXfOxw1dchE.oB56anXmMWGkQDnq3vFd91K', 'dario@gmail.com', 'ACTIVO'),
(989, 'Freddy Fernandez', 8994, '$2b$04$YUVRbeI76Vhq0WKSZ79houoxHOYSwSS8QVqxnADxe6Zb.4IQ84rxy', 'Llanta400@gmail.com', 'ACTIVO'),
(4677, 'Nuevo', 4644, '$2b$04$sqrDZIYyiPCpQJ6A0RlP/ejw96W70afPDTFjtWEjd9RsI.mSKA3dm', 'nuevo@gmail.com', 'ACTIVO'),
(7778, 'luna Frenandez', 0, '$2b$04$RXB7MB4y5EM5WPqFx1gdZeVninwkDpmVH2AB5Ar3OvdDcO6u7yt/.', 'lueuwj@gmail.com', 'ACTIVO'),
(7874, 'Lucas Calavacin', 674484, '$2b$04$Du1kgvAGjkTlYK6ypJFmeOY.hn/yXHihQGedRJHtc4.n9.vn1BZhK', 'lucas@gmail.com', 'ACTIVO'),
(20000, 'Angie', 378383, '$2b$04$K.UKQkxcUqVUDvHoWcTblu4O02MUmm.p6mRkNc5Tjnk/R12ns2sMy', 'angie@gmail.com', 'ACTIVO'),
(93737, 'Freddy Dos', 54893093, '$2b$04$qIwKtibYBUX2GuOuce68.ORQI2WWozRtBZ0cBjHGOl3xnhd0ifQmy', 'fredd@gmail.com', 'ACTIVO'),
(93783, 'Freddy Marido', 47348239, '$2b$04$3XwO4Sbkdrm20mIwiOTJfepjIonEdAqeEhRqozroGSqD6Cp0XQAte', 'fredicito@gmail.com', 'ACTIVO'),
(478777, 'Loro', 31573, '$2b$04$Xvtw1F2lQZdgbFb8pu4DBeJsO1Vrfj45TMtksUSQaDaP5Z1V.7wjG', 'loro@gmail.com', 'ACTIVO'),
(562727, 'Luz Mery', 57849843, '$2b$04$ntnL77OXzLv9pUtpMMxEje8o9xPGWpFSzjwV8ZiHRX.XHnvpol5qm', 'mery@gmail.com', 'ACTIVO'),
(786778, 'Pablo Vargas', 784, '$2b$04$FWDt8N/4abjITAsc7S10V.otluQfZTAu2dD/2I32oVxJHJLcOTgHa', 'pablo@gmail.com', 'ACTIVO'),
(789893, 'camilo', 465, '$2b$04$aN3V6Ayj.IT1Zpn9xsm0b.yGLHG6Vtw2SifQrCLcgOm/YrI1NTszi', 'camilo@gmail.com', 'ACTIVO'),
(3886363, 'Manuela', 447474, '$2b$04$gGcghbHx07Cl7ysEsvKdMus30CbfiZW/61095Rks/hPQA5/Rp1yR2', 'manuela@gmail.com', 'ACTIVO'),
(10405548, 'varon', 87666, '$2b$04$mZdl7sI9vwAKQx.zsS8YAexA8wqjEvhz7S1xkQGGni.PwnuAFo3jq', 'varon@gmail.com', 'ACTIVO'),
(49478747, 'Paulondra', 3015431236, '$2b$04$pXjQAbkudmPGHBH099.iSeU9slJuBHbMhgevG8vVXFT7yunAuV8KG', 'paualondra@gmail.com', 'ACTIVO'),
(1000414627, 'freddy', 1234567891, '$2b$04$qJ3bva16MH1ht1QpXVpmsuPYn9wfn8rYB8dZWpIuwqYVsPSJbc1.S', 'fre@gmail.com', 'ACTIVO'),
(1020405548, 'Paula Lopez', 3015431236, '$2b$04$jqrot2k.o16smpKsjT54Hu/IlGJoop20kX50yu.nsn8gtK9lwVxle', 'paul@gmail.com', 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cortes`
--

DROP TABLE IF EXISTS `cortes`;
CREATE TABLE `cortes` (
  `id_corte` int NOT NULL,
  `nombre` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `id_servicio` int NOT NULL,
  `url_imagen` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cortes`
--

INSERT INTO `cortes` (`id_corte`, `nombre`, `id_servicio`, `url_imagen`) VALUES
(1, 'Clásico', 1, 'https://res.cloudinary.com/dfuizwycd/image/upload/v1720465492/corte2_smcsld.png'),
(2, 'Degradado', 1, 'https://res.cloudinary.com/dfuizwycd/image/upload/v1720465472/corte1_mrwfwe.png'),
(3, 'Tijera', 1, 'https://res.cloudinary.com/dfuizwycd/image/upload/v1720465492/corte3_ati7bs.png'),
(4, 'Ducktail', 2, 'https://res.cloudinary.com/dfuizwycd/image/upload/v1720465472/corte5_ayiakl.png'),
(5, 'Clean', 2, 'https://res.cloudinary.com/dfuizwycd/image/upload/v1720465472/corte6_mi0ub6.png'),
(6, 'Stumbble (medium)', 2, 'https://res.cloudinary.com/dfuizwycd/image/upload/v1720465471/corte4_nfwkvd.png'),
(7, 'One line', 3, 'https://res.cloudinary.com/dfuizwycd/image/upload/v1720465472/corte7_c3iznr.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura_reserva`
--

DROP TABLE IF EXISTS `factura_reserva`;
CREATE TABLE `factura_reserva` (
  `id_factura_reserva` int NOT NULL,
  `id_reserva` int NOT NULL,
  `id_corte` int NOT NULL,
  `id_cliente` int DEFAULT NULL,
  `id_barbero` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `factura_reserva`
--

INSERT INTO `factura_reserva` (`id_factura_reserva`, `id_reserva`, `id_corte`, `id_cliente`, `id_barbero`) VALUES
(50, 73, 1, 989, 555),
(51, 74, 3, 989, 555),
(52, 75, 7, 989, 1000414627);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos` (
  `id_producto` int NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `stock` int NOT NULL,
  `precio` int NOT NULL,
  `url_imagen` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `stock`, `precio`, `url_imagen`) VALUES
(1, 'cera', 'Cera de gran calidad', 50, 10000, 'https://res.cloudinary.com/dfuizwycd/image/upload/v1720465117/producto3_g8ys4l.png'),
(2, 'Cuchillas afeitadoras', 'Gran paquete de 3', 30, 20000, 'https://res.cloudinary.com/dfuizwycd/image/upload/v1720465183/producto4_pg8t0y.png'),
(3, 'Gorras', 'Gorras de la marca amiri', 20, 30000, 'https://res.cloudinary.com/dfuizwycd/image/upload/v1720465183/producto5_wk4wre.png'),
(4, 'shampooo', 'shampoo anticaspa', 15, 40000, 'https://res.cloudinary.com/dfuizwycd/image/upload/v1720465171/producto1_wpyy1j.png'),
(5, 'acondicionador', 'Deja cabello sedoso', 40, 50000, 'https://res.cloudinary.com/dfuizwycd/image/upload/v1720465183/producto2_wipysh.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promociones`
--

DROP TABLE IF EXISTS `promociones`;
CREATE TABLE `promociones` (
  `id_promocion` int NOT NULL,
  `codigo` int NOT NULL,
  `descripcion` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_final` time NOT NULL,
  `estado` varchar(20) COLLATE utf8mb4_general_ci DEFAULT 'ACTIVO',
  `TIPO` varchar(10) COLLATE utf8mb4_general_ci DEFAULT 'CORRIENTE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `promociones`
--

INSERT INTO `promociones` (`id_promocion`, `codigo`, `descripcion`, `hora_inicio`, `hora_final`, `estado`, `TIPO`) VALUES
(1, 10, '20% de descuento maquina barbera', '12:30:20', '12:30:20', 'ACTIVO', 'CORRIENTE'),
(2, 20, '40% de descuento afeitadora', '11:30:20', '12:30:20', 'ACTIVO', 'VIP'),
(3, 30, '10% de descuento cuchilla', '10:30:20', '12:30:20', 'ACTIVO', 'CORRIENTE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publicaciones_barberos`
--

DROP TABLE IF EXISTS `publicaciones_barberos`;
CREATE TABLE `publicaciones_barberos` (
  `id_publicacion_barbero` int NOT NULL,
  `foto` blob NOT NULL,
  `estado` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_barbero` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `publicaciones_barberos`
--

INSERT INTO `publicaciones_barberos` (`id_publicacion_barbero`, `foto`, `estado`, `id_barbero`) VALUES
(2, 0x617364617364617364617364, 'activo', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_horarios`
--

DROP TABLE IF EXISTS `registro_horarios`;
CREATE TABLE `registro_horarios` (
  `id_registro_horario` int NOT NULL,
  `hora_inicial` time NOT NULL,
  `hora_final` time NOT NULL,
  `estado` varchar(20) COLLATE utf8mb4_general_ci DEFAULT 'ACTIVO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro_horarios`
--

INSERT INTO `registro_horarios` (`id_registro_horario`, `hora_inicial`, `hora_final`, `estado`) VALUES
(1, '07:00:00', '08:00:00', 'ACTIVO'),
(2, '09:00:00', '10:00:00', 'ACTIVO'),
(3, '10:00:00', '11:00:00', 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resenas`
--

DROP TABLE IF EXISTS `resenas`;
CREATE TABLE `resenas` (
  `id_resena` int NOT NULL,
  `comentario` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `id_cliente` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `resenas`
--

INSERT INTO `resenas` (`id_resena`, `comentario`, `id_cliente`) VALUES
(3, 'Me gusta mucho', 989),
(4, 'I like too much', 7778),
(5, 'Me gusta mucho', 7778),
(13, 'Me fascina', 989),
(16, 'Me gusta mucho la aplicacion', 562727),
(17, 'Muy linda', 989),
(18, 'Me gusta mucho la barberia', 989),
(19, 'Holaa', 989);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

DROP TABLE IF EXISTS `reservas`;
CREATE TABLE `reservas` (
  `id_reserva` int NOT NULL,
  `estado_reserva` varchar(20) COLLATE utf8mb4_general_ci DEFAULT 'ACTIVO',
  `id_servicio` int NOT NULL,
  `id_registro_horario` int NOT NULL,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id_reserva`, `estado_reserva`, `id_servicio`, `id_registro_horario`, `fecha`) VALUES
(73, 'REPROGRAMADO', 1, 1, '2024-07-13'),
(74, 'REPROGRAMADO', 1, 1, '2024-07-17'),
(75, 'REPROGRAMADO', 3, 1, '2024-07-26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

DROP TABLE IF EXISTS `servicios`;
CREATE TABLE `servicios` (
  `id_servicio` int NOT NULL,
  `nombre` varchar(200) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id_servicio`, `nombre`) VALUES
(1, 'Cabello'),
(2, 'Barba'),
(3, 'Cejas');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`id_administrador`);

--
-- Indices de la tabla `barberia`
--
ALTER TABLE `barberia`
  ADD PRIMARY KEY (`id_barberia`),
  ADD KEY `id_ubicacion` (`id_ubicacion`),
  ADD KEY `id_links` (`id_links`);

--
-- Indices de la tabla `barberos`
--
ALTER TABLE `barberos`
  ADD PRIMARY KEY (`id_barbero`);

--
-- Indices de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD PRIMARY KEY (`id_calificacion`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `cortes`
--
ALTER TABLE `cortes`
  ADD PRIMARY KEY (`id_corte`),
  ADD KEY `id_servicio` (`id_servicio`);

--
-- Indices de la tabla `factura_reserva`
--
ALTER TABLE `factura_reserva`
  ADD PRIMARY KEY (`id_factura_reserva`),
  ADD KEY `id_reserva` (`id_reserva`),
  ADD KEY `id_corte` (`id_corte`),
  ADD KEY `fk_factura_reserva_cliente` (`id_cliente`),
  ADD KEY `fk_factura_reserva_barbero` (`id_barbero`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `promociones`
--
ALTER TABLE `promociones`
  ADD PRIMARY KEY (`id_promocion`);

--
-- Indices de la tabla `publicaciones_barberos`
--
ALTER TABLE `publicaciones_barberos`
  ADD PRIMARY KEY (`id_publicacion_barbero`),
  ADD KEY `fk_publicaciones_barberos_cliente` (`id_barbero`);

--
-- Indices de la tabla `registro_horarios`
--
ALTER TABLE `registro_horarios`
  ADD PRIMARY KEY (`id_registro_horario`);

--
-- Indices de la tabla `resenas`
--
ALTER TABLE `resenas`
  ADD PRIMARY KEY (`id_resena`),
  ADD KEY `fk_resenas_cliente` (`id_cliente`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id_reserva`),
  ADD KEY `id_registro_horario` (`id_registro_horario`),
  ADD KEY `fk_reservas_id_servicio` (`id_servicio`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id_servicio`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administrador`
--
ALTER TABLE `administrador`
  MODIFY `id_administrador` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `barberia`
--
ALTER TABLE `barberia`
  MODIFY `id_barberia` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `barberos`
--
ALTER TABLE `barberos`
  MODIFY `id_barbero` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1111111112;

--
-- AUTO_INCREMENT de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  MODIFY `id_calificacion` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1020405549;

--
-- AUTO_INCREMENT de la tabla `cortes`
--
ALTER TABLE `cortes`
  MODIFY `id_corte` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `factura_reserva`
--
ALTER TABLE `factura_reserva`
  MODIFY `id_factura_reserva` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `promociones`
--
ALTER TABLE `promociones`
  MODIFY `id_promocion` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `publicaciones_barberos`
--
ALTER TABLE `publicaciones_barberos`
  MODIFY `id_publicacion_barbero` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `registro_horarios`
--
ALTER TABLE `registro_horarios`
  MODIFY `id_registro_horario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `resenas`
--
ALTER TABLE `resenas`
  MODIFY `id_resena` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id_reserva` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id_servicio` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD CONSTRAINT `id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`);

--
-- Filtros para la tabla `cortes`
--
ALTER TABLE `cortes`
  ADD CONSTRAINT `id_servicio` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`);

--
-- Filtros para la tabla `factura_reserva`
--
ALTER TABLE `factura_reserva`
  ADD CONSTRAINT `fk_factura_reserva_barbero` FOREIGN KEY (`id_barbero`) REFERENCES `barberos` (`id_barbero`),
  ADD CONSTRAINT `fk_factura_reserva_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `id_corte` FOREIGN KEY (`id_corte`) REFERENCES `cortes` (`id_corte`),
  ADD CONSTRAINT `id_reserva` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id_reserva`);

--
-- Filtros para la tabla `publicaciones_barberos`
--
ALTER TABLE `publicaciones_barberos`
  ADD CONSTRAINT `fk_publicaciones_barberos_cliente` FOREIGN KEY (`id_barbero`) REFERENCES `barberos` (`id_barbero`);

--
-- Filtros para la tabla `resenas`
--
ALTER TABLE `resenas`
  ADD CONSTRAINT `fk_resenas_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`);

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `fk_reservas_id_servicio` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

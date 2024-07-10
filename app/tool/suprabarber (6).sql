-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-06-2024 a las 03:53:34
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
CREATE DATABASE IF NOT EXISTS `suprabarber` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `suprabarber`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_CONTRASENA_CLIENTE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ACTUALIZAR_CONTRASENA_CLIENTE` (IN `_ID` INT(11), IN `_CONTRA` VARCHAR(100))   BEGIN

UPDATE usuarios SET contrasena = _CONTRA
WHERE identificacion = _ID AND roll = 'cliente';

END$$

DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_CORREO_CLIENTE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ACTUALIZAR_CORREO_CLIENTE` (IN `_ID` INT(11), IN `_CORREO` VARCHAR(255))   BEGIN

UPDATE usuarios SET correo_electronico = _CORREO
WHERE identificacion = _ID AND roll = 'cliente';

END$$

DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_NOMBRE_CLIENTE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ACTUALIZAR_NOMBRE_CLIENTE` (IN `_ID` INT(11), IN `_NOMBRE` VARCHAR(255))   BEGIN

UPDATE usuarios SET nombre = _NOMBRE
WHERE identificacion = _ID AND roll = 'cliente';

END$$

DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_TELEFONO_CLIENTE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ACTUALIZAR_TELEFONO_CLIENTE` (IN `_ID` INT(11), IN `_TEL` VARCHAR(20))   BEGIN

UPDATE usuarios SET telefono = _TEL
WHERE identificacion = _ID AND roll = 'cliente';

END$$

DROP PROCEDURE IF EXISTS `SP_BARBERO_CANCELA_CITA`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_BARBERO_CANCELA_CITA` (IN `_FECHA` DATE, IN `_HORA_INICIAL` TIME)   BEGIN
	UPDATE registro_horarios SET estado = 'Cancelado'
    WHERE fecha = _FECHA AND hora_inicial = _HORA_INICIAL ;


END$$

DROP PROCEDURE IF EXISTS `SP_BARBERO_ELIMINAR_FOTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_BARBERO_ELIMINAR_FOTO` (IN `_ID_BARBERO` INT(11))   BEGIN
	UPDATE publicaciones_barberos SET estado_estado ='INACTIVO' 
    WHERE id_barbero = _ID_BARBERO;

END$$

DROP PROCEDURE IF EXISTS `SP_BARBERO_PUBLICAR_FOTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_BARBERO_PUBLICAR_FOTO` (IN `_FOTO` BLOB)   BEGIN
	INSERT INTO publicaciones_barberos (foto)
    VALUES (_FOTO);
END$$

DROP PROCEDURE IF EXISTS `SP_BARBERO_REGISTRA_CORTES`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_BARBERO_REGISTRA_CORTES` (IN `_FOTO` BLOB, IN `_ESTADO` VARCHAR(10))   BEGIN
	INSERT INTO publicaciones_barberos (foto, estado)
    VALUES (_FOTO, _ESTADO);
END$$

DROP PROCEDURE IF EXISTS `SP_BARBERO_REGISTRA_HORARIO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_BARBERO_REGISTRA_HORARIO` (IN `_HORA_INICIAL` TIME, IN `_HORA_FINAL` TIME, IN `_ID_HORARIO` INT)   BEGIN
	INSERT INTO registro_horarios (hora_inicial, hora_final, id_horario)
    VALUES (_HORA_INICIAL, _HORA_FINAL, _ID_HORARIO);


END$$

DROP PROCEDURE IF EXISTS `SP_BARBERO_VISUALIZAR_CITA_CANCELADA`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_BARBERO_VISUALIZAR_CITA_CANCELADA` ()   BEGIN
	SELECT fecha, hora_inicial, hora_final
    WHERE estado = 'Cancelado';
END$$

DROP PROCEDURE IF EXISTS `SP_BARBERO_VISUALIZAR_CITA_REPROGRAMADA`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_BARBERO_VISUALIZAR_CITA_REPROGRAMADA` ()   BEGIN
 
	SELECT hora_inicial, hora_final, fecha FROM registro_horarios 
    WHERE estado = 'Reprogramada' ;

END$$

DROP PROCEDURE IF EXISTS `SP_BARBERO_VISUALIZAR_USUARIOS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_BARBERO_VISUALIZAR_USUARIOS` ()   BEGIN
	SELECT identificacion, nombre, contrasena, 			direccion, telefono, correo_electronico WHERE 		estado_cuenta = 'ACTIVO' AND roll = 'cliente' ;
END$$

DROP PROCEDURE IF EXISTS `SP_CAMBIAR_CONTRASENA_ADMIN`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CAMBIAR_CONTRASENA_ADMIN` (IN `_CONTRASENA` VARCHAR(255))   BEGIN
UPDATE administrador
SET contrasena = _CONTRASENA;

END$$

DROP PROCEDURE IF EXISTS `SP_CAMBIAR_PRECIO_CORTES`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CAMBIAR_PRECIO_CORTES` (IN `_PRECIO` INT(11))   BEGIN
UPDATE cortes 
SET precio = _PRECIO
WHERE id_corte = 1;

END$$

DROP PROCEDURE IF EXISTS `SP_CREAR_USUARIO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CREAR_USUARIO` (IN `_ID` INT(11), IN `_NOMBRE` VARCHAR(255), IN `_CONTRA` VARCHAR(100), IN `_DIRECCION` VARCHAR(255), IN `_TELEFONO` VARCHAR(20), IN `_CORREO` VARCHAR(255), IN `_ROLL` VARCHAR(10))   BEGIN

INSERT INTO usuarios(identificacion,nombre,contrasena,direccion,telefono,correo_electronico,roll)
VALUES(_ID, _NOMBRE, _CONTRA, _DIRECCION, _TELEFONO, _CORREO, _ROLL);

END$$

DROP PROCEDURE IF EXISTS `SP_DESACTIVAR_CUENTA`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DESACTIVAR_CUENTA` (IN `_CONTRA` INT)   BEGIN
UPDATE usuarios U 
SET U.estado_cuenta ='INACTIVO' 
WHERE U.roll = 'barbero' AND U.contrasena = _CONTRA;

END$$

DROP PROCEDURE IF EXISTS `SP_EDITAR_PERFIL_BARBERO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EDITAR_PERFIL_BARBERO` (IN `_IDENTIFICACION` INT, IN `_NOMBRE` VARCHAR(255), IN `_DIRECCION` VARCHAR(255), IN `_TELEFONO` VARCHAR(20), IN `_CORREO` VARCHAR(255), IN `_ID_USUARIO` INT)   BEGIN
UPDATE usuarios SET
identificacion =CASE WHEN _IDENTIFICACION = '' THEN identificacion ELSE _IDENTIFICACION END,
nombre = CASE WHEN _NOMBRE = '' THEN nombre ELSE _NOMBRE END,
direccion = CASE WHEN _DIRECCION = '' THEN direccion ELSE _DIRECCION END,
telefono = CASE WHEN _TELEFONO = '' THEN telefono ELSE _TELEFONO END,
correo_electronico = CASE WHEN _CORREO = '' THEN correo_electronico ELSE _CORREO END
WHERE id_usuario = _ID_USUARIO AND roll = 'barbero';
END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_LINK`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_LINK` (IN `_ID_LINK` INT(11))   BEGIN

DELETE FROM links
WHERE id_links = _ID_LINK;

END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_PROMOCION`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_PROMOCION` (IN `_ID_PROMOCION` INT(11))   BEGIN

DELETE FROM promociones 
WHERE id_promocion = _ID_PROMOCION;

END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_USUARIOS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_USUARIOS` (IN `_ID` INT(11))   BEGIN

UPDATE usuarios SET estado_cuenta = 'INACTIVO'
WHERE id_usuario = _ID;

END$$

DROP PROCEDURE IF EXISTS `SP_INSERTAR_BARBERO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_BARBERO` (IN `_IDENTIFICACION` INT, IN `_NOMBRE` VARCHAR(255), IN `_CONTRASENA` VARCHAR(100), IN `_DIRECCION` VARCHAR(255), IN `_TELEFONO` VARCHAR(20), IN `_CORREO` VARCHAR(255))   BEGIN
INSERT INTO usuarios (`identificacion`, `nombre`, `contrasena`, `direccion`, `telefono`, `correo_electronico`, `roll`) VALUES (_IDENTIFICACION,_NOMBRE,_CONTRASENA,_DIRECCION,_TELEFONO,_CORREO,'barbero');

INSERT INTO barberos (id_usuario)
VALUES ((SELECT id_usuario FROM usuarios ORDER BY id_usuario DESC LIMIT 1));

END$$

DROP PROCEDURE IF EXISTS `SP_INSERTAR_CALIFICACION`$$
CREATE DEFINER=`id21087577_suprabarber`@`%` PROCEDURE `SP_INSERTAR_CALIFICACION` (IN `_ESTRELLAS` INT(1), IN `_COMENTARIO` VARCHAR(200), IN `_ID_USUARIO` INT(11))   BEGIN

INSERT INTO calificacion(estrella, comentario, id_usuario)
VALUES (_ESTRELLAS, _COMENTARIO, _ID_USUARIO);

END$$

DROP PROCEDURE IF EXISTS `SP_INSERTAR_LINK`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_LINK` (IN `_RUTA` VARCHAR(200))   BEGIN

INSERT INTO links(ruta)
VALUES (_RUTA);

END$$

DROP PROCEDURE IF EXISTS `SP_INSERTAR_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_PRODUCTO` (IN `_NOMBRE` VARCHAR(255), IN `_DESCRIPCION` TEXT, IN `_STOCK` INT(11))   BEGIN

INSERT INTO productos(nombre, descripcion, stock)
VALUES (_NOMBRE, _DESCRIPCION, _STOCK);

END$$

DROP PROCEDURE IF EXISTS `SP_INSERTAR_PROMOCIONES`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_PROMOCIONES` (IN `_CODIGO` INT(50), IN `_DESCRIPCION` VARCHAR(100), IN `_HORA_INICIO` TIME, IN `_HORA_FINAL` TIME, IN `_TIPO` VARCHAR(10))   BEGIN

INSERT INTO promociones( codigo, descripcion, hora_inicio, hora_final, TIPO)
VALUES (_CODIGO, _DESCRIPCION, _HORA_INICIO, _HORA_FINAL, _TIPO);

END$$

DROP PROCEDURE IF EXISTS `SP_LOGUEAR_ADMIN`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LOGUEAR_ADMIN` (IN `_CORREO` VARCHAR(200))   BEGIN

SELECT A.usuario, A.contrasena
FROM administrador A 
WHERE A.usuario = _CORREO;

END$$

DROP PROCEDURE IF EXISTS `SP_LOGUEAR_USUARIO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LOGUEAR_USUARIO` (IN `_CORREO` VARCHAR(255))   BEGIN

SELECT U.nombre, U.contrasena
FROM usuarios U
WHERE U.correo_electronico = _CORREO;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_BARBEROS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_BARBEROS` ()   BEGIN
SELECT U.nombre, U.telefono, U.correo_electronico
FROM barberos B 
INNER JOIN usuarios U ON U.id_usuario = B.id_barbero;
END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_CALIFICACION`$$
CREATE DEFINER=`id21087577_suprabarber`@`%` PROCEDURE `SP_MOSTRAR_CALIFICACION` ()   BEGIN 
SELECT C.id_usuario ,C.estrella, C.comentario
FROM calificacion C;
END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_DISPONIBILADAD_BARBERO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_DISPONIBILADAD_BARBERO` (IN `_ID_BARBERO` INT(11))   BEGIN
SELECT ROW_NUMBER() OVER (ORDER BY RH.hora_inicial ASC) AS HORARIO,RH.hora_inicial, RH.hora_final
FROM registro_horarios AS RH
INNER JOIN horarios H ON RH.id_horario = H.id_horario
INNER JOIN barberos B ON H.id_barbero = B.id_barbero
INNER JOIN usuarios U ON B.id_usuario = U.id_usuario
WHERE b.id_barbero = _ID_BARBERO;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_PRODUCTOS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_PRODUCTOS` ()   BEGIN

SELECT P.nombre, P.descripcion
FROM productos P;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_PROMOCIONES`$$
CREATE DEFINER=`id21087577_suprabarber`@`%` PROCEDURE `SP_MOSTRAR_PROMOCIONES` ()   BEGIN
SELECT P.codigo, P.descripcion
FROM promociones P;
END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_PROMOCIONES_VIP`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_PROMOCIONES_VIP` ()   BEGIN
SELECT DISTINCT P.codigo, P.descripcion
FROM vips V
INNER JOIN promociones P ON V.id_promocion = P.id_promocion;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_UBICACION`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_UBICACION` ()   BEGIN

SELECT U.direccion
FROM barberia B 
INNER JOIN ubicacion U ON U.id_ubicacion = B.id_ubicacion;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_UN_USUARIO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_UN_USUARIO` (IN `_ID` INT(11))   BEGIN
SELECT U.nombre, U.correo_electronico, U.contrasena
FROM usuarios AS U
WHERE U.id_usuario = _ID;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_USUARIOS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_USUARIOS` ()   BEGIN
SELECT U.identificacion, U.nombre, U.contrasena, U.direccion, U.telefono, U.correo_electronico, U.roll
FROM usuarios AS U;
END$$

DROP PROCEDURE IF EXISTS `SP_REGISTRAR_USER`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REGISTRAR_USER` (IN `_ID` INT(11), IN `_NOMBRE` VARCHAR(255), IN `_TELEFONO` VARCHAR(20), IN `_CORREO` VARCHAR(255), IN `_CONTRA` VARCHAR(100), IN `_ROLL` VARCHAR(10))   BEGIN

INSERT INTO usuarios(identificacion, nombre, telefono, correo_electronico,contrasena, roll)
VALUES (_ID, _NOMBRE, _TELEFONO, _CORREO, _CONTRA, _ROLL);

END$$

DROP PROCEDURE IF EXISTS `SP_VERIFICAR_EXISTENCIA_DE_CUENTA`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VERIFICAR_EXISTENCIA_DE_CUENTA` (IN `_ID` INT(11), IN `_CORREO` VARCHAR(255))   BEGIN 

SELECT U.identificacion, U.nombre, U.correo_electronico
FROM usuarios U 
WHERE U.identificacion = _ID OR U.correo_electronico = _CORREO;

END$$

DROP PROCEDURE IF EXISTS `SP_VISUALIZAR_BARBEROS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VISUALIZAR_BARBEROS` ()   BEGIN
SELECT U.nombre, U.telefono, U.correo_electronico
FROM barberos B
INNER JOIN usuarios U ON U.id_usuario = B.id_barbero
WHERE U.estado_cuenta = 'ACTIVO' AND U.roll ='barbero';

END$$

DROP PROCEDURE IF EXISTS `SP_VISUALIZAR_TODOS_CLIENTES`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VISUALIZAR_TODOS_CLIENTES` ()   BEGIN

SELECT U.identificacion, U.nombre, U.telefono, U.correo_electronico
FROM clientes C
INNER JOIN usuarios U ON C.id_usuario = U.id_usuario
WHERE U.estado_cuenta = 'ACTIVO' AND U.roll ='cliente';
END$$

DROP PROCEDURE IF EXISTS `SP_VISUALIZAR_UN_CLIENTE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VISUALIZAR_UN_CLIENTE` (IN `_ID` INT(11))   BEGIN

SELECT U.identificacion, U.nombre, U.telefono, U.correo_electronico
FROM clientes C 
INNER JOIN usuarios U ON C.id_usuario = U.id_usuario
WHERE C.id_usuario = _ID;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

DROP TABLE IF EXISTS `administrador`;
CREATE TABLE `administrador` (
  `id_administrador` int(11) NOT NULL,
  `usuario` varchar(200) NOT NULL,
  `contrasena` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`id_administrador`, `usuario`, `contrasena`) VALUES
(1, 'admin', '$2b$04$ey.kuLsUwFo3TdIAUNVBuucInS1RqWSa6EWR/TZh6sijE4EVDqxxG');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `anuncios`
--

DROP TABLE IF EXISTS `anuncios`;
CREATE TABLE `anuncios` (
  `id_anuncio` int(11) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `estado` varchar(10) DEFAULT NULL,
  `id_producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `anuncios`
--

INSERT INTO `anuncios` (`id_anuncio`, `descripcion`, `estado`, `id_producto`) VALUES
(1, 'gran maquina de afeitar, comprala', 'inactivo', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barberia`
--

DROP TABLE IF EXISTS `barberia`;
CREATE TABLE `barberia` (
  `id_barberia` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `estado` varchar(10) NOT NULL,
  `id_ubicacion` int(11) NOT NULL,
  `id_links` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barberos`
--

DROP TABLE IF EXISTS `barberos`;
CREATE TABLE `barberos` (
  `id_barbero` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `barberos`
--

INSERT INTO `barberos` (`id_barbero`, `id_usuario`) VALUES
(11, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificacion`
--

DROP TABLE IF EXISTS `calificacion`;
CREATE TABLE `calificacion` (
  `id_calificacion` int(11) NOT NULL,
  `estrella` int(11) DEFAULT NULL,
  `comentario` varchar(200) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `calificacion`
--

INSERT INTO `calificacion` (`id_calificacion`, `estrella`, `comentario`, `id_usuario`) VALUES
(1, 5, 'muy buena', 1),
(2, 4, 'muy buena', 4),
(3, 3, 'muy buena', 5),
(4, 3, 'BUENA', 3),
(5, 1, 'Muy bueno', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `id_usuario`) VALUES
(2, 46),
(1, 68);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes_vip`
--

DROP TABLE IF EXISTS `clientes_vip`;
CREATE TABLE `clientes_vip` (
  `id_cliente_vip` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes_vip`
--

INSERT INTO `clientes_vip` (`id_cliente_vip`, `id_cliente`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cortes`
--

DROP TABLE IF EXISTS `cortes`;
CREATE TABLE `cortes` (
  `id_corte` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cortes`
--

INSERT INTO `cortes` (`id_corte`, `nombre`) VALUES
(1, 'Corte Clásico'),
(2, 'Corte Degradado'),
(3, 'Corte a Tijera'),
(4, 'Corte Militar'),
(5, 'Corte Undercut'),
(6, 'Corte Pompadour'),
(7, 'Corte Long Bob'),
(8, 'Corte Pixie'),
(9, 'Corte Bob'),
(10, 'Corte Mullet'),
(11, 'Corte Bowl'),
(12, 'Corte Caesar'),
(13, 'Corte Fade'),
(14, 'Corte Crop'),
(15, 'Corte Ivy League');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura_reserva`
--

DROP TABLE IF EXISTS `factura_reserva`;
CREATE TABLE `factura_reserva` (
  `id_factura_reserva` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_metodo_pago` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `factura_reserva`
--

INSERT INTO `factura_reserva` (`id_factura_reserva`, `id_usuario`, `id_metodo_pago`) VALUES
(1, 1, 1),
(2, 2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura_ventas`
--

DROP TABLE IF EXISTS `factura_ventas`;
CREATE TABLE `factura_ventas` (
  `id_factura_venta` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_usuario` int(11) NOT NULL,
  `id_metodo_pago` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `factura_ventas`
--

INSERT INTO `factura_ventas` (`id_factura_venta`, `fecha`, `id_usuario`, `id_metodo_pago`) VALUES
(1, '2024-03-05 00:00:00', 2, 1),
(2, '2024-03-06 00:00:00', 3, 2),
(3, '2024-03-07 00:00:00', 1, 4),
(4, '2024-03-08 00:00:00', 2, 3),
(5, '2024-03-09 00:00:00', 3, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

DROP TABLE IF EXISTS `horarios`;
CREATE TABLE `horarios` (
  `id_horario` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_barbero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`id_horario`, `fecha`, `id_barbero`) VALUES
(1, '2024-03-05 18:00:14', 11),
(2, '2024-03-05 18:00:14', 12),
(3, '2024-03-05 18:00:14', 13),
(4, '2024-03-05 18:00:14', 14),
(5, '2024-03-05 18:00:14', 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `links`
--

DROP TABLE IF EXISTS `links`;
CREATE TABLE `links` (
  `id_links` int(11) NOT NULL,
  `ruta` varchar(200) NOT NULL,
  `estado` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `links`
--

INSERT INTO `links` (`id_links`, `ruta`, `estado`) VALUES
(1, 'https/samuelelmaslindo.com', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodos_pago`
--

DROP TABLE IF EXISTS `metodos_pago`;
CREATE TABLE `metodos_pago` (
  `id_metodo_pago` int(11) NOT NULL,
  `pago` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `metodos_pago`
--

INSERT INTO `metodos_pago` (`id_metodo_pago`, `pago`) VALUES
(1, 'Tarjeta de crédito'),
(2, 'Transferencia bancaria'),
(3, 'PayPal'),
(4, 'Bitcoin'),
(5, 'Efectivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text NOT NULL,
  `stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `stock`) VALUES
(1, 'cera', 'Cera de gran calidad', 50),
(2, 'Cuchillas afeitadoras', 'Gran paquete de 3', 30),
(3, 'Gorras', 'Gorras de la marca amiri', 20),
(4, 'shampooo', 'shampoo anticaspa', 15),
(5, 'acondicionador', 'Deja cabello sedoso', 40),
(6, 'Locion para cabello', 'gran aroma masculino', 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promociones`
--

DROP TABLE IF EXISTS `promociones`;
CREATE TABLE `promociones` (
  `id_promocion` int(11) NOT NULL,
  `codigo` int(50) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_final` time NOT NULL,
  `estado` varchar(20) DEFAULT 'ACTIVO',
  `TIPO` varchar(10) DEFAULT 'CORRIENTE'
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
-- Estructura de tabla para la tabla `promociones_vip`
--

DROP TABLE IF EXISTS `promociones_vip`;
CREATE TABLE `promociones_vip` (
  `id_promocion_vip` int(11) NOT NULL,
  `id_promocion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `promociones_vip`
--

INSERT INTO `promociones_vip` (`id_promocion_vip`, `id_promocion`) VALUES
(1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publicaciones_barberos`
--

DROP TABLE IF EXISTS `publicaciones_barberos`;
CREATE TABLE `publicaciones_barberos` (
  `id_publicacion_barbero` int(11) NOT NULL,
  `foto` blob NOT NULL,
  `estado` varchar(10) DEFAULT NULL,
  `id_barbero` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `publicaciones_barberos`
--

INSERT INTO `publicaciones_barberos` (`id_publicacion_barbero`, `foto`, `estado`, `id_barbero`) VALUES
(2, 0x617364617364617364617364, 'activo', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_horarios`
--

DROP TABLE IF EXISTS `registro_horarios`;
CREATE TABLE `registro_horarios` (
  `id_registro_horario` int(11) NOT NULL,
  `hora_inicial` time NOT NULL,
  `hora_final` time NOT NULL,
  `estado` varchar(20) DEFAULT 'ACTIVO',
  `id_horario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro_horarios`
--

INSERT INTO `registro_horarios` (`id_registro_horario`, `hora_inicial`, `hora_final`, `estado`, `id_horario`) VALUES
(1, '07:00:00', '08:00:00', 'Activo', 1),
(2, '09:00:00', '10:00:00', 'Activo', 2),
(3, '11:00:00', '12:00:00', 'Activo', 3),
(4, '13:00:00', '14:00:00', 'Activo', 4),
(5, '15:00:00', '16:00:00', 'ACTIVO', 6),
(6, '06:00:00', '07:00:00', 'ACTIVO', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_productos`
--

DROP TABLE IF EXISTS `registro_productos`;
CREATE TABLE `registro_productos` (
  `id_registro_producto` int(11) NOT NULL,
  `cantidad_inicial` int(50) NOT NULL,
  `cantidad_final` int(50) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `valor` decimal(10,2) NOT NULL,
  `estado` varchar(100) DEFAULT 'ACTIVO',
  `id_producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro_productos`
--

INSERT INTO `registro_productos` (`id_registro_producto`, `cantidad_inicial`, `cantidad_final`, `fecha`, `valor`, `estado`, `id_producto`) VALUES
(1, 50, 50, '2024-03-05 17:44:19', 20.99, 'Disponible', 1),
(2, 30, 30, '2024-03-05 17:44:19', 35.50, 'Disponible', 2),
(3, 20, 20, '2024-03-05 17:44:19', 55.75, 'Disponible', 3),
(4, 15, 15, '2024-03-05 17:44:19', 45.00, 'Disponible', 4),
(5, 40, 40, '2024-03-05 17:44:19', 120.00, 'Disponible', 5),
(6, 25, 25, '2024-03-05 17:44:19', 15.99, 'Disponible', 6),
(7, 35, 35, '2024-03-05 17:44:19', 10.50, 'Disponible', 7),
(8, 45, 45, '2024-03-05 17:44:19', 30.25, 'Disponible', 8),
(9, 20, 20, '2024-03-05 17:44:19', 40.00, 'Disponible', 9),
(10, 50, 50, '2024-03-05 17:44:19', 5.99, 'Disponible', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

DROP TABLE IF EXISTS `reservas`;
CREATE TABLE `reservas` (
  `id_reserva` int(11) NOT NULL,
  `estado_reserva` varchar(20) DEFAULT 'ACTIVO',
  `id_factura_reserva` int(11) NOT NULL,
  `id_servicio` int(11) NOT NULL,
  `id_registro_horario` int(11) NOT NULL,
  `id_promocion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id_reserva`, `estado_reserva`, `id_factura_reserva`, `id_servicio`, `id_registro_horario`, `id_promocion`) VALUES
(4, 'Inactivo', 1, 1, 1, 1),
(5, 'Inactivo', 2, 2, 2, 2),
(6, 'Inactivo', 1, 3, 3, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

DROP TABLE IF EXISTS `servicios`;
CREATE TABLE `servicios` (
  `id_servicio` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `id_corte` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id_servicio`, `nombre`, `id_corte`) VALUES
(1, 'Corte de Pelo Clásico', 1),
(2, 'Degradado Clásico', 2),
(3, 'Corte a Tijera Moderno', 3),
(4, 'Corte Militar', 4),
(5, 'Undercut Estilizado', 5),
(6, 'Corte Pompadour', 6),
(7, 'Long Bob Elegante', 7),
(8, 'Pixie Chic', 8),
(9, 'Bob Asimétrico', 9),
(10, 'Mullet Retro', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion`
--

DROP TABLE IF EXISTS `ubicacion`;
CREATE TABLE `ubicacion` (
  `id_ubicacion` int(11) NOT NULL,
  `direccion` varchar(30) NOT NULL,
  `estado` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ubicacion`
--

INSERT INTO `ubicacion` (`id_ubicacion`, `direccion`, `estado`) VALUES
(1, 'Carrera #65 14-18', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `identificacion` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `contrasena` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo_electronico` varchar(255) NOT NULL,
  `estado_cuenta` varchar(10) DEFAULT 'ACTIVO',
  `tipo_cuenta` varchar(10) DEFAULT 'CORRIENTE',
  `roll` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `identificacion`, `nombre`, `contrasena`, `telefono`, `correo_electronico`, `estado_cuenta`, `tipo_cuenta`, `roll`) VALUES
(1, 1, 'Juan Perez', 'contrasena123', '1234567890', 'juan@example.com', 'ACTIVO', 'CORRIENTE', 'barbero'),
(46, 989, 'Andre London', '$2b$04$ejGmIb/H8bDxnuOGC2evIONRTRcfXnnBQU.t0BkAPCp4x2zU8c9ea', '33', 'llanta400@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(68, 6048, 'freddy Giraldo', '$2b$04$ZwibRY3p2T2pAe2lKtIlsuLWe4Lu5vFCfZJMwBooC6ySeHK30yo/y', '888', 'freddy1@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(69, 68678, 'freddy Giraldo', '$2b$04$ATfuZQrvc8rHDy1B168Iz.g6hIHkDtZt0zfNxRvyYohttMlGq2WDO', '3773', 'freddy1@gmail.com', 'ACTIVO', 'CORRIENTE', 'barbero'),
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
(91, 777, 'caribe', '$2b$04$TOlK/U3T9TQgAFmwMwfEAOShXbY.ZDTZvhnCGzdhSQWjUdwtWEneO', '67237623', 'caribe@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente'),
(93, 86788, 'loreno', '$2b$04$lPeUOFqhXmKLy1fVrKXUNO2l4QzOEBOZvaVqPantUXW6apg3FWoF.', '7867678', 'loreno@gmail.com', 'ACTIVO', 'CORRIENTE', 'barbero'),
(94, 9889654, 'lorena', '$2b$04$LEw4qS2/rzJ22MkiRnoTWuflrKLDGkCZTQD3.jDnCSDIRiDb7qjE6', '667363', 'lorenas@gmail.com', 'ACTIVO', 'CORRIENTE', 'cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

DROP TABLE IF EXISTS `ventas`;
CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `cantidad` int(10) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `id_registro_producto` int(11) NOT NULL,
  `id_factura_venta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_venta`, `cantidad`, `subtotal`, `id_registro_producto`, `id_factura_venta`) VALUES
(1, 5, 104.95, 1, 1),
(2, 3, 106.50, 2, 2),
(3, 2, 111.50, 3, 3),
(4, 1, 45.00, 4, 4),
(5, 4, 480.00, 5, 5);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`id_administrador`);

--
-- Indices de la tabla `anuncios`
--
ALTER TABLE `anuncios`
  ADD PRIMARY KEY (`id_anuncio`),
  ADD KEY `id_producto` (`id_producto`);

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
  ADD PRIMARY KEY (`id_barbero`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD PRIMARY KEY (`id_calificacion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `clientes_vip`
--
ALTER TABLE `clientes_vip`
  ADD PRIMARY KEY (`id_cliente_vip`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Indices de la tabla `cortes`
--
ALTER TABLE `cortes`
  ADD PRIMARY KEY (`id_corte`);

--
-- Indices de la tabla `factura_reserva`
--
ALTER TABLE `factura_reserva`
  ADD PRIMARY KEY (`id_factura_reserva`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_metodo_pago` (`id_metodo_pago`);

--
-- Indices de la tabla `factura_ventas`
--
ALTER TABLE `factura_ventas`
  ADD PRIMARY KEY (`id_factura_venta`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_metodo_pago` (`id_metodo_pago`);

--
-- Indices de la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`id_horario`),
  ADD KEY `id_barbero` (`id_barbero`);

--
-- Indices de la tabla `links`
--
ALTER TABLE `links`
  ADD PRIMARY KEY (`id_links`);

--
-- Indices de la tabla `metodos_pago`
--
ALTER TABLE `metodos_pago`
  ADD PRIMARY KEY (`id_metodo_pago`);

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
-- Indices de la tabla `promociones_vip`
--
ALTER TABLE `promociones_vip`
  ADD PRIMARY KEY (`id_promocion_vip`),
  ADD KEY `id_promocion` (`id_promocion`);

--
-- Indices de la tabla `publicaciones_barberos`
--
ALTER TABLE `publicaciones_barberos`
  ADD PRIMARY KEY (`id_publicacion_barbero`),
  ADD KEY `id_barbero` (`id_barbero`);

--
-- Indices de la tabla `registro_horarios`
--
ALTER TABLE `registro_horarios`
  ADD PRIMARY KEY (`id_registro_horario`),
  ADD KEY `id_horario` (`id_horario`);

--
-- Indices de la tabla `registro_productos`
--
ALTER TABLE `registro_productos`
  ADD PRIMARY KEY (`id_registro_producto`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id_reserva`),
  ADD KEY `id_factura_reserva` (`id_factura_reserva`),
  ADD KEY `id_servicio` (`id_servicio`),
  ADD KEY `id_registro_horario` (`id_registro_horario`),
  ADD KEY `id_promocion` (`id_promocion`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id_servicio`),
  ADD KEY `id_corte` (`id_corte`);

--
-- Indices de la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  ADD PRIMARY KEY (`id_ubicacion`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `identificacion` (`identificacion`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_registro_producto` (`id_registro_producto`),
  ADD KEY `id_factura_venta` (`id_factura_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administrador`
--
ALTER TABLE `administrador`
  MODIFY `id_administrador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `anuncios`
--
ALTER TABLE `anuncios`
  MODIFY `id_anuncio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `barberia`
--
ALTER TABLE `barberia`
  MODIFY `id_barberia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `barberos`
--
ALTER TABLE `barberos`
  MODIFY `id_barbero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  MODIFY `id_calificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `clientes_vip`
--
ALTER TABLE `clientes_vip`
  MODIFY `id_cliente_vip` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cortes`
--
ALTER TABLE `cortes`
  MODIFY `id_corte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `factura_reserva`
--
ALTER TABLE `factura_reserva`
  MODIFY `id_factura_reserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `factura_ventas`
--
ALTER TABLE `factura_ventas`
  MODIFY `id_factura_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `horarios`
--
ALTER TABLE `horarios`
  MODIFY `id_horario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `links`
--
ALTER TABLE `links`
  MODIFY `id_links` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `metodos_pago`
--
ALTER TABLE `metodos_pago`
  MODIFY `id_metodo_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `promociones`
--
ALTER TABLE `promociones`
  MODIFY `id_promocion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `promociones_vip`
--
ALTER TABLE `promociones_vip`
  MODIFY `id_promocion_vip` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `publicaciones_barberos`
--
ALTER TABLE `publicaciones_barberos`
  MODIFY `id_publicacion_barbero` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `registro_horarios`
--
ALTER TABLE `registro_horarios`
  MODIFY `id_registro_horario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `registro_productos`
--
ALTER TABLE `registro_productos`
  MODIFY `id_registro_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id_reserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id_servicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  MODIFY `id_ubicacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `clientes_vip`
--
ALTER TABLE `clientes_vip`
  ADD CONSTRAINT `clientes_vip_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`);

--
-- Filtros para la tabla `promociones_vip`
--
ALTER TABLE `promociones_vip`
  ADD CONSTRAINT `promociones_vip_ibfk_1` FOREIGN KEY (`id_promocion`) REFERENCES `promociones` (`id_promocion`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

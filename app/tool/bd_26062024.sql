-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-06-2024 a las 06:43:41
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

DROP PROCEDURE IF EXISTS `SP_ACTUALIZAR_CORREO_BARBERO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ACTUALIZAR_CORREO_BARBERO` (IN `_IDENTIFICACION` INT(11), IN `_CORREO` VARCHAR(255))   BEGIN

UPDATE usuarios SET correo_electronico = _CORREO
WHERE identificacion = _IDENTIFICACION AND roll = 'barbero';

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

DROP PROCEDURE IF EXISTS `SP_CANCELAR_CITA`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CANCELAR_CITA` (IN `_ID_RESERVA` INT)   BEGIN

UPDATE reservas SET estado_reserva = 'CANCELADO'
WHERE id_reserva = _ID_RESERVA;

END$$

DROP PROCEDURE IF EXISTS `SP_CREAR_CITA`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CREAR_CITA` (IN `_ID_HORARIO` INT(11), IN `_ID_SERVICIO` INT(11))   BEGIN

INSERT INTO reservas(id_servicio, id_registro_horario) VALUES (_ID_SERVICIO, _ID_HORARIO);
SELECT LAST_INSERT_ID() AS id_reserva;

END$$

DROP PROCEDURE IF EXISTS `SP_CREAR_FACTURA_CITA`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CREAR_FACTURA_CITA` (IN `_ID_USUARIO` INT(11), IN `_ID_RESERVA` INT(11), IN `_ID_CORTE` INT(11), IN `_ID_BARBERO` INT(11))   BEGIN

INSERT INTO factura_reserva(id_usuario, id_reserva, id_corte, id_barbero)
VALUES (_ID_USUARIO, _ID_RESERVA, _ID_CORTE, _ID_BARBERO);

END$$

DROP PROCEDURE IF EXISTS `SP_CREAR_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CREAR_PRODUCTO` (IN `_NOMBRE` VARCHAR(255), IN `_DESCRIPCION` VARCHAR(255))   BEGIN

INSERT INTO productos(nombre, descripcion)
VALUES (_NOMBRE, _DESCRIPCION);

END$$

DROP PROCEDURE IF EXISTS `SP_CREAR_SERVICIO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CREAR_SERVICIO` (IN `_NOMBRE` VARCHAR(200))   BEGIN
INSERT INTO servicios(nombre) VALUES(_NOMBRE);
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

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_CORTE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_CORTE` (IN `_ID` INT(11))   BEGIN

DELETE FROM cortes
WHERE id_corte = _ID;

END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_LINK`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_LINK` (IN `_ID_LINK` INT(11))   BEGIN

DELETE FROM links
WHERE id_links = _ID_LINK;

END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_PRODUCTO` (IN `_ID` INT(11))   BEGIN

DELETE FROM productos
WHERE id_producto = _ID;

END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_PROMOCION`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_PROMOCION` (IN `_ID_PROMOCION` INT(11))   BEGIN

DELETE FROM promociones 
WHERE id_promocion = _ID_PROMOCION;

END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_RESENAS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_RESENAS` (IN `_IDENTIFICACION` INT(11), IN `_ID_RESENA` INT(11))   BEGIN

DELETE FROM resenas
WHERE identificacion = _IDENTIFICACION AND id_resena = _ID_RESENA;


END$$

DROP PROCEDURE IF EXISTS `SP_ELIMINAR_SERVICIO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ELIMINAR_SERVICIO` (IN `_ID` INT(11))   BEGIN

DELETE FROM servicios 
WHERE id_servicio = _ID;

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_PRODUCTO` (IN `_NOMBRE` VARCHAR(255), IN `_DESCRIPCION` VARCHAR(255), IN `_STOCK` INT(11))   BEGIN

INSERT INTO productos(nombre, descripcion, stock)
VALUES (_NOMBRE, _DESCRIPCION, _STOCK);

END$$

DROP PROCEDURE IF EXISTS `SP_INSERTAR_PROMOCIONES`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_PROMOCIONES` (IN `_CODIGO` INT(50), IN `_DESCRIPCION` VARCHAR(100), IN `_HORA_INICIO` TIME, IN `_HORA_FINAL` TIME, IN `_TIPO` VARCHAR(10))   BEGIN

INSERT INTO promociones( codigo, descripcion, hora_inicio, hora_final, TIPO)
VALUES (_CODIGO, _DESCRIPCION, _HORA_INICIO, _HORA_FINAL, _TIPO);

END$$

DROP PROCEDURE IF EXISTS `SP_INSERTAR_RESENAS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERTAR_RESENAS` (IN `_IDENTIFICACION` INT(11), IN `_COMENTARIO` VARCHAR(255))   BEGIN
INSERT INTO resenas ( identificacion, comentario) VALUES (_IDENTIFICACION, _COMENTARIO);

END$$

DROP PROCEDURE IF EXISTS `SP_LOGUEAR_ADMIN`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LOGUEAR_ADMIN` (IN `_CORREO` VARCHAR(200))   BEGIN

SELECT A.usuario, A.contrasena
FROM administrador A 
WHERE A.usuario = _CORREO;

END$$

DROP PROCEDURE IF EXISTS `SP_LOGUEAR_USUARIO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_LOGUEAR_USUARIO` (IN `_CORREO` VARCHAR(255))   BEGIN

SELECT U.nombre, U.contrasena, U.identificacion
FROM usuarios U
WHERE U.correo_electronico = _CORREO AND u.estado_cuenta = 'ACTIVO';

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_BARBEROS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_BARBEROS` ()   BEGIN
SELECT U.identificacion,U.nombre, U.telefono, U.correo_electronico
FROM usuarios U 
WHERE U.estado_cuenta = 'ACTIVO' AND U.roll = 'barbero';
END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_CALIFICACION`$$
CREATE DEFINER=`id21087577_suprabarber`@`%` PROCEDURE `SP_MOSTRAR_CALIFICACION` ()   BEGIN 
SELECT C.id_usuario ,C.estrella, C.comentario
FROM calificacion C;
END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_CORTES`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_CORTES` ()   BEGIN

SELECT C.id_corte, C.nombre
FROM cortes C;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_CORTES_SERVICIO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_CORTES_SERVICIO` (IN `_ID_SERVICIO` INT(11))   BEGIN
SELECT C.id_corte ,C.nombre
FROM cortes C
WHERE id_servicio = _ID_SERVICIO;

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

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_RESENAS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_RESENAS` ()   BEGIN

SELECT R.id_resena,R.identificacion, U.nombre, R.comentario
FROM resenas R
INNER JOIN usuarios U ON u.identificacion = R.identificacion;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_SERVICIOS`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_SERVICIOS` ()   BEGIN

SELECT S.nombre, S.id_servicio
FROM servicios S;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_UBICACION`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_UBICACION` ()   BEGIN

SELECT U.direccion
FROM barberia B 
INNER JOIN ubicacion U ON U.id_ubicacion = B.id_ubicacion;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_UN_BARBERO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_UN_BARBERO` (IN `_IDENTIFICACION` INT(11))   BEGIN

SELECT U.identificacion,U.nombre, U.telefono, U.correo_electronico
FROM usuarios U 
WHERE U.identificacion = _IDENTIFICACION AND U.roll = 'barbero';

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_UN_CORTE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_UN_CORTE` (IN `_ID` INT(11))   BEGIN

SELECT C.nombre
FROM cortes C
WHERE C.id_corte = _ID;

END$$

DROP PROCEDURE IF EXISTS `SP_MOSTRAR_UN_PRODUCTO`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_MOSTRAR_UN_PRODUCTO` (IN `_ID` INT)   BEGIN

SELECT P.nombre, P.descripcion, P.stock
FROM productos P
WHERE P.id_producto = _ID;

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

DROP PROCEDURE IF EXISTS `SP_REPROGRAMAR_CITA`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_REPROGRAMAR_CITA` (IN `_ID_RESERVA` INT(11), IN `_ID_HORARIO` INT(11))   BEGIN

UPDATE reservas SET id_registro_horario = _ID_HORARIO, estado_reserva = 'REPROGRAMADO'
WHERE id_reserva = _ID_RESERVA;

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

SELECT U.identificacion, U.nombre, U.telefono, U.correo_electronico, u.roll
FROM usuarios U
WHERE U.estado_cuenta = 'ACTIVO' AND U.roll ='cliente';
END$$

DROP PROCEDURE IF EXISTS `SP_VISUALIZAR_UN_CLIENTE`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_VISUALIZAR_UN_CLIENTE` (IN `_ID` INT(11))   BEGIN

SELECT U.identificacion, U.nombre, U.telefono, U.correo_electronico, u.roll
FROM usuarios U
WHERE U.estado_cuenta = 'ACTIVO' AND U.roll ='cliente' AND U.identificacion = _ID;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

DROP TABLE IF EXISTS `administrador`;
CREATE TABLE IF NOT EXISTS `administrador` (
  `id_administrador` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(200) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  PRIMARY KEY (`id_administrador`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
CREATE TABLE IF NOT EXISTS `anuncios` (
  `id_anuncio` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(200) NOT NULL,
  `estado` varchar(10) DEFAULT NULL,
  `id_producto` int(11) NOT NULL,
  PRIMARY KEY (`id_anuncio`),
  KEY `id_producto` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
CREATE TABLE IF NOT EXISTS `barberia` (
  `id_barberia` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `estado` varchar(10) NOT NULL,
  `id_ubicacion` int(11) NOT NULL,
  `id_links` int(11) NOT NULL,
  PRIMARY KEY (`id_barberia`),
  KEY `id_ubicacion` (`id_ubicacion`),
  KEY `id_links` (`id_links`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barberos`
--

DROP TABLE IF EXISTS `barberos`;
CREATE TABLE IF NOT EXISTS `barberos` (
  `id_barbero` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_barbero`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
CREATE TABLE IF NOT EXISTS `calificacion` (
  `id_calificacion` int(11) NOT NULL AUTO_INCREMENT,
  `estrella` int(11) DEFAULT NULL,
  `comentario` varchar(200) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_calificacion`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
CREATE TABLE IF NOT EXISTS `clientes` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
CREATE TABLE IF NOT EXISTS `clientes_vip` (
  `id_cliente_vip` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL,
  PRIMARY KEY (`id_cliente_vip`),
  KEY `id_cliente` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
CREATE TABLE IF NOT EXISTS `cortes` (
  `id_corte` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `id_servicio` int(11) NOT NULL,
  PRIMARY KEY (`id_corte`),
  KEY `id_servicio` (`id_servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cortes`
--

INSERT INTO `cortes` (`id_corte`, `nombre`, `id_servicio`) VALUES
(1, 'Corte Clásico', 1),
(2, 'Corte Degradado', 1),
(3, 'Corte a Tijera', 1),
(4, 'Corte Militar', 2),
(5, 'Corte Undercut', 2),
(6, 'Corte Pompadour', 2),
(7, 'Corte Long Bob', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura_reserva`
--

DROP TABLE IF EXISTS `factura_reserva`;
CREATE TABLE IF NOT EXISTS `factura_reserva` (
  `id_factura_reserva` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_metodo_pago` int(11) NOT NULL,
  `id_reserva` int(11) NOT NULL,
  `id_corte` int(11) NOT NULL,
  `id_barbero` int(11) NOT NULL,
  PRIMARY KEY (`id_factura_reserva`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_metodo_pago` (`id_metodo_pago`),
  KEY `id_reserva` (`id_reserva`),
  KEY `id_corte` (`id_corte`),
  KEY `id_barbero` (`id_barbero`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `factura_reserva`
--

INSERT INTO `factura_reserva` (`id_factura_reserva`, `id_usuario`, `id_metodo_pago`, `id_reserva`, `id_corte`, `id_barbero`) VALUES
(3, 46, 1, 4, 1, 86788),
(4, 46, 0, 7, 2, 86788),
(5, 46, 0, 7, 1, 86788),
(6, 46, 0, 20, 2, 86788),
(7, 46, 0, 21, 2, 86788),
(8, 46, 0, 22, 2, 86788),
(9, 46, 0, 25, 2, 86788),
(10, 46, 0, 26, 2, 86788);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura_ventas`
--

DROP TABLE IF EXISTS `factura_ventas`;
CREATE TABLE IF NOT EXISTS `factura_ventas` (
  `id_factura_venta` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_usuario` int(11) NOT NULL,
  `id_metodo_pago` int(11) NOT NULL,
  PRIMARY KEY (`id_factura_venta`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_metodo_pago` (`id_metodo_pago`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
CREATE TABLE IF NOT EXISTS `horarios` (
  `id_horario` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_barbero` int(11) NOT NULL,
  PRIMARY KEY (`id_horario`),
  KEY `id_barbero` (`id_barbero`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
CREATE TABLE IF NOT EXISTS `links` (
  `id_links` int(11) NOT NULL AUTO_INCREMENT,
  `ruta` varchar(200) NOT NULL,
  `estado` varchar(10) NOT NULL,
  PRIMARY KEY (`id_links`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
CREATE TABLE IF NOT EXISTS `metodos_pago` (
  `id_metodo_pago` int(11) NOT NULL AUTO_INCREMENT,
  `pago` varchar(100) NOT NULL,
  PRIMARY KEY (`id_metodo_pago`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
CREATE TABLE IF NOT EXISTS `productos` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `stock` int(11) NOT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `descripcion`, `stock`) VALUES
(1, 'cera', 'Cera de gran calidad', 50),
(2, 'Cuchillas afeitadoras', 'Gran paquete de 3', 30),
(3, 'Gorras', 'Gorras de la marca amiri', 20),
(4, 'shampooo', 'shampoo anticaspa', 15),
(5, 'acondicionador', 'Deja cabello sedoso', 40),
(12, 'Cuchillas', 'Estra afiladas', 0),
(13, 'Parches', 'lindos', 2),
(14, 'Cuchillas', 'Afiladas', 36);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promociones`
--

DROP TABLE IF EXISTS `promociones`;
CREATE TABLE IF NOT EXISTS `promociones` (
  `id_promocion` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` int(50) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_final` time NOT NULL,
  `estado` varchar(20) DEFAULT 'ACTIVO',
  `TIPO` varchar(10) DEFAULT 'CORRIENTE',
  PRIMARY KEY (`id_promocion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
CREATE TABLE IF NOT EXISTS `promociones_vip` (
  `id_promocion_vip` int(11) NOT NULL AUTO_INCREMENT,
  `id_promocion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_promocion_vip`),
  KEY `id_promocion` (`id_promocion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
CREATE TABLE IF NOT EXISTS `publicaciones_barberos` (
  `id_publicacion_barbero` int(11) NOT NULL AUTO_INCREMENT,
  `foto` blob NOT NULL,
  `estado` varchar(10) DEFAULT NULL,
  `id_barbero` int(11) NOT NULL,
  PRIMARY KEY (`id_publicacion_barbero`),
  KEY `id_barbero` (`id_barbero`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
CREATE TABLE IF NOT EXISTS `registro_horarios` (
  `id_registro_horario` int(11) NOT NULL AUTO_INCREMENT,
  `hora_inicial` time NOT NULL,
  `hora_final` time NOT NULL,
  `estado` varchar(20) DEFAULT 'ACTIVO',
  `id_horario` int(11) NOT NULL,
  PRIMARY KEY (`id_registro_horario`),
  KEY `id_horario` (`id_horario`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
CREATE TABLE IF NOT EXISTS `registro_productos` (
  `id_registro_producto` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad_inicial` int(50) NOT NULL,
  `cantidad_final` int(50) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `valor` decimal(10,2) NOT NULL,
  `estado` varchar(100) DEFAULT 'ACTIVO',
  `id_producto` int(11) NOT NULL,
  PRIMARY KEY (`id_registro_producto`),
  KEY `id_producto` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Estructura de tabla para la tabla `resenas`
--

DROP TABLE IF EXISTS `resenas`;
CREATE TABLE IF NOT EXISTS `resenas` (
  `id_resena` int(11) NOT NULL AUTO_INCREMENT,
  `identificacion` int(11) NOT NULL,
  `comentario` varchar(255) NOT NULL,
  PRIMARY KEY (`id_resena`),
  KEY `identificacion` (`identificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `resenas`
--

INSERT INTO `resenas` (`id_resena`, `identificacion`, `comentario`) VALUES
(3, 989, 'Me gusta mucho'),
(4, 6048, 'I like too much'),
(5, 99, 'Me gusta mucho');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

DROP TABLE IF EXISTS `reservas`;
CREATE TABLE IF NOT EXISTS `reservas` (
  `id_reserva` int(11) NOT NULL AUTO_INCREMENT,
  `estado_reserva` varchar(20) DEFAULT 'ACTIVO',
  `id_servicio` int(11) NOT NULL,
  `id_registro_horario` int(11) NOT NULL,
  `id_promocion` int(11) NOT NULL,
  PRIMARY KEY (`id_reserva`),
  KEY `id_registro_horario` (`id_registro_horario`),
  KEY `id_promocion` (`id_promocion`),
  KEY `fk_reservas_id_servicio` (`id_servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id_reserva`, `estado_reserva`, `id_servicio`, `id_registro_horario`, `id_promocion`) VALUES
(4, 'Inactivo', 1, 1, 1),
(7, 'CANCELADO', 1, 1, 0),
(20, 'CANCELADO', 1, 0, 0),
(21, 'ACTIVO', 1, 4, 0),
(22, 'ACTIVO', 1, 4, 0),
(25, 'CANCELADO', 1, 4, 0),
(26, 'REPROGRAMADO', 1, 2, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

DROP TABLE IF EXISTS `servicios`;
CREATE TABLE IF NOT EXISTS `servicios` (
  `id_servicio` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  PRIMARY KEY (`id_servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id_servicio`, `nombre`) VALUES
(1, 'Cabello'),
(2, 'Barba'),
(3, 'Cejas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion`
--

DROP TABLE IF EXISTS `ubicacion`;
CREATE TABLE IF NOT EXISTS `ubicacion` (
  `id_ubicacion` int(11) NOT NULL AUTO_INCREMENT,
  `direccion` varchar(30) NOT NULL,
  `estado` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_ubicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

DROP TABLE IF EXISTS `ventas`;
CREATE TABLE IF NOT EXISTS `ventas` (
  `id_venta` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` int(10) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `id_registro_producto` int(11) NOT NULL,
  `id_factura_venta` int(11) NOT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `id_registro_producto` (`id_registro_producto`),
  KEY `id_factura_venta` (`id_factura_venta`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Filtros para la tabla `cortes`
--
ALTER TABLE `cortes`
  ADD CONSTRAINT `id_servicio` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`);

--
-- Filtros para la tabla `factura_reserva`
--
ALTER TABLE `factura_reserva`
  ADD CONSTRAINT `id_barbero` FOREIGN KEY (`id_barbero`) REFERENCES `usuarios` (`identificacion`),
  ADD CONSTRAINT `id_corte` FOREIGN KEY (`id_corte`) REFERENCES `cortes` (`id_corte`),
  ADD CONSTRAINT `id_reserva` FOREIGN KEY (`id_reserva`) REFERENCES `reservas` (`id_reserva`);

--
-- Filtros para la tabla `promociones_vip`
--
ALTER TABLE `promociones_vip`
  ADD CONSTRAINT `promociones_vip_ibfk_1` FOREIGN KEY (`id_promocion`) REFERENCES `promociones` (`id_promocion`);

--
-- Filtros para la tabla `resenas`
--
ALTER TABLE `resenas`
  ADD CONSTRAINT `resenas_ibfk_1` FOREIGN KEY (`identificacion`) REFERENCES `usuarios` (`identificacion`);

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `fk_reservas_id_servicio` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

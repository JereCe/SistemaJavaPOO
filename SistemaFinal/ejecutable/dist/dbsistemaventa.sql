-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-06-2023 a las 01:36:52
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbsistemaventa`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE `articulo` (
  `id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `activo` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `articulo`
--

INSERT INTO `articulo` (`id`, `categoria_id`, `codigo`, `nombre`, `precio_venta`, `stock`, `descripcion`, `imagen`, `activo`) VALUES
(3, 28, 'T664120', 'Tinta Epson Original T664 Negro', '9000.00', 15, '', 't664negro.jpg', b'1'),
(4, 28, '1050', 'Resma Papel A4 Ledesma', '20.40', 18, '', 'ledes_resma.jpg', b'1'),
(5, 29, 'r1100', 'Edifier R1100 ', '59000.00', 0, '• 42 Watts RMS\n• Tweeter de seda, woofer de 4\"\n• Tubo de sintonía frontal\n• Sólida constucción en MDF', '61Y-gCdogNL._AC_SX679_-600x571.jpg', b'1'),
(6, 30, '', 'RTX 2060 EVGA', '25451.00', 8, '', '4250812442123_800.jpg', b'1'),
(7, 26, 'Z690', 'Asus Strix Z690', '180000.00', 3, '', 'MOTHER-ASUS-ROG-STRIX-Z690F.jpg', b'1'),
(8, 27, '5481', 'Mouse Genius Inalambrico554', '1000.00', 56, '', 'mousegenius.jpg', b'1'),
(9, 27, '5414', 'teclado razer huntsman mini', '15000.00', 1, 'teclado mecanico', 'rzer_huntsman mini.jpg', b'1'),
(10, 27, '2487', 'Auricular Marshall Major IV', '50000.00', 2, 'Bluetooth', 'auriculares-marshall-major.jpg', b'1'),
(11, 27, '6748', 'Logitech C270', '13000.00', 4, '', 'Logitech-C270.png', b'1'),
(12, 27, '9/854', 'Mouse Logitech M317C', '1500.00', 6, 'inalambrico', 'Mouse-Logitech-M317C.jpg', b'1'),
(13, 27, '8746', 'Pendrive Kingston DataTraveler Exodia M 64Gb', '6000.00', 39, '', 'ktc-product-usb-dtxm-64gb-1-zm-lg.jpg', b'1'),
(14, 28, '987454', 'bateria havit', '500.00', 10, '', '', b'1'),
(16, 28, '5451', 'hdssdew', '5412.00', 10, '', '', b'1'),
(17, 28, '545451', 'ofkjoikjw', '2110.00', 20, '', '', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `activo` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `nombre`, `descripcion`, `activo`) VALUES
(26, 'mother', 'placa base computadora', b'1'),
(27, 'periferico', 'perifericos PC', b'1'),
(28, 'insumos', 'consumibles', b'1'),
(29, 'parlantes', 'sonido pc', b'1'),
(30, 'placa video', '', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ingreso`
--

CREATE TABLE `detalle_ingreso` (
  `id` int(11) NOT NULL,
  `ingreso_id` int(11) NOT NULL,
  `articulo_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `detalle_ingreso`
--

INSERT INTO `detalle_ingreso` (`id`, `ingreso_id`, `articulo_id`, `cantidad`, `precio`) VALUES
(1, 3, 10, 1, '50000.00'),
(2, 4, 9, 4, '15000.00'),
(3, 4, 3, 1, '9000.00'),
(4, 4, 12, 1, '8000.00'),
(5, 5, 10, 1, '50000.00'),
(6, 6, 7, 1, '180000.00'),
(7, 7, 10, 1, '50000.00'),
(8, 8, 7, 1, '180000.00'),
(9, 9, 7, 1, '180000.00'),
(10, 10, 6, 1, '250000.00'),
(11, 11, 3, 5, '9000.00'),
(12, 12, 12, 4, '8000.00'),
(13, 13, 10, 1, '50000.00');

--
-- Disparadores `detalle_ingreso`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockIngreso` AFTER INSERT ON `detalle_ingreso` FOR EACH ROW BEGIN
 UPDATE articulo SET stock = stock + NEW.cantidad 
 WHERE articulo.id = NEW.articulo_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `articulo_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`id`, `venta_id`, `articulo_id`, `cantidad`, `precio`, `descuento`) VALUES
(1, 1, 7, 1, '0.00', '180000.00'),
(2, 1, 5, 1, '0.00', '59000.00'),
(3, 1, 12, 1, '0.00', '1500.00'),
(4, 2, 10, 1, '50000.00', '0.00'),
(5, 2, 5, 1, '59000.00', '0.00'),
(6, 3, 4, 1, '20.40', '0.00'),
(7, 4, 13, 1, '6000.00', '0.00'),
(8, 5, 11, 1, '13000.00', '0.00'),
(9, 6, 9, 1, '15000.00', '0.00'),
(10, 7, 9, 1, '15000.00', '0.00'),
(11, 8, 9, 1, '15000.00', '0.00'),
(12, 9, 11, 1, '13000.00', '0.00'),
(13, 10, 7, 1, '180000.00', '0.00'),
(14, 10, 4, 1, '20.40', '0.00'),
(15, 10, 13, 1, '6000.00', '0.00'),
(16, 10, 10, 1, '50000.00', '0.00'),
(17, 11, 11, 1, '13000.00', '0.00');

--
-- Disparadores `detalle_venta`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockVenta` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
 UPDATE articulo SET stock = stock - NEW.cantidad 
 WHERE articulo.id = NEW.articulo_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso`
--

CREATE TABLE `ingreso` (
  `id` int(11) NOT NULL,
  `persona_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `ingresocol` varchar(45) DEFAULT 'aceptado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `ingreso`
--

INSERT INTO `ingreso` (`id`, `persona_id`, `usuario_id`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha`, `impuesto`, `total`, `estado`, `ingresocol`) VALUES
(3, 1, 1, 'Boleta', 'k', '1', '2023-06-10 16:21:52', '0.18', '50000.00', 'Aceptado', 'aceptado'),
(4, 1, 1, 'Boleta', 'k', '2', '2023-06-10 16:24:20', '0.18', '77000.00', 'Aceptado', 'aceptado'),
(5, 1, 1, 'Boleta', 'k', '54', '2023-06-10 16:30:28', '0.18', '50000.00', 'Anulado', 'aceptado'),
(6, 1, 1, 'Boleta', 'k', '45', '2023-06-10 16:37:06', '0.18', '180000.00', 'Aceptado', 'aceptado'),
(7, 1, 1, 'Factura', 'k', '87', '2023-06-10 16:37:35', '0.18', '50000.00', 'Aceptado', 'aceptado'),
(8, 1, 1, 'Boleta', 'e', '10', '2023-06-10 16:40:56', '0.18', '180000.00', 'Aceptado', 'aceptado'),
(9, 1, 1, 'Ticket', 'yh', '1', '2023-06-10 16:49:57', '0.18', '180000.00', 'Aceptado', 'aceptado'),
(10, 1, 1, 'Ticket', 'i', '8', '2023-06-10 16:58:44', '0.18', '250000.00', 'Aceptado', 'aceptado'),
(11, 1, 1, 'Boleta', 'w', '20', '2023-06-10 17:15:15', '0.18', '45000.00', 'Aceptado', 'aceptado'),
(12, 1, 1, 'Guia', '45', '10', '2023-06-10 17:40:00', '0.18', '32000.00', 'Anulado', 'aceptado'),
(13, 1, 1, 'Boleta', 's', '8', '2023-06-11 00:06:28', '0.18', '50000.00', 'Aceptado', 'aceptado');

--
-- Disparadores `ingreso`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockIngresoAnular` AFTER UPDATE ON `ingreso` FOR EACH ROW BEGIN
  UPDATE articulo a
    JOIN detalle_ingreso di
      ON di.articulo_id = a.id
     AND di.ingreso_id = new.id
     set a.stock = a.stock - di.cantidad;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `id` int(11) NOT NULL,
  `tipo_persona` varchar(20) NOT NULL,
  `nombre` varchar(70) NOT NULL,
  `tipo_documento` varchar(20) DEFAULT NULL,
  `num_documento` varchar(20) DEFAULT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `activo` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`id`, `tipo_persona`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `activo`) VALUES
(1, 'Proveedor', 'nucleo', 'CUIT', '361452785', 'mar del plata451', '223457841', 'claudio@nucleo.com.ar', b'1'),
(2, 'Cliente', 'juan', 'DNI', '36541814', 'pinamar', '02665474581', 'juan@gmail.com', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Administrador', 'Administrador del sistema'),
(2, 'Vendedor', 'Vendedor del sistema'),
(3, 'Almacenero', 'Almacenero del sistema');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `nombre` varchar(70) NOT NULL,
  `tipo_documento` varchar(20) DEFAULT NULL,
  `num_documento` varchar(20) DEFAULT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `clave` varchar(128) NOT NULL,
  `activo` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `rol_id`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `clave`, `activo`) VALUES
(1, 1, 'adm', 'DNI', '12515122', '', '', 'administrador@sistema.com', '86f65e28a754e1a71b2df9403615a6c436c32c42a75a10d02813961b86f1e428', b'1'),
(2, 3, 'almacen', 'DNI', '4878421', '', '', 'almacen@sistema.com', 'b20b0f63ce2ed361e8845d6bf2e59811aaa06ec96bcdb92f9bc0c5a25e83c9a6', b'1'),
(3, 2, 'vendedor', 'DNI', '565628', '', '', 'vendedor@sistema.com', 'e8827f3c0bcc90509b7d6841d446b163a671cac807a5f1bf41218667546ce80b', b'1'),
(4, 1, 'jere', 'DNI', '37671400', 'dasfasasd', '54584512515', 'californac@gmail.com', '0a83bca2c68ab4fd9c2134cc274dab2330ee6c86d06e9c6c293c4b4a30c4a60a', b'0');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `id` int(11) NOT NULL,
  `persona_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL DEFAULT 'aceptado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`id`, `persona_id`, `usuario_id`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha`, `impuesto`, `total`, `estado`) VALUES
(1, 1, 1, 'Boleta', 'e', '10', '2023-06-10 22:40:08', '0.18', '-240500.00', 'Aceptado'),
(2, 2, 1, 'Factura', 'f', '1', '2023-06-10 23:44:08', '0.18', '109000.00', 'Aceptado'),
(3, 2, 1, 'Boleta', 'e', '11', '2023-06-11 14:48:02', '0.18', '20.40', 'Aceptado'),
(4, 2, 1, 'Boleta', 'e', '12', '2023-06-11 14:49:27', '0.18', '6000.00', 'Aceptado'),
(5, 2, 1, 'Boleta', 'e', '13', '2023-06-11 14:50:54', '0.18', '13000.00', 'Aceptado'),
(6, 2, 1, 'Boleta', 'e', '14', '2023-06-11 14:53:00', '0.18', '15000.00', 'Aceptado'),
(7, 2, 1, 'Boleta', 'e', '15', '2023-06-11 14:56:42', '0.18', '15000.00', 'Aceptado'),
(8, 2, 1, 'Boleta', 'e', '16', '2023-06-11 14:58:16', '0.18', '15000.00', 'Aceptado'),
(9, 2, 1, 'Boleta', 'e', '17', '2023-06-11 15:07:45', '0.18', '13000.00', 'Aceptado'),
(10, 2, 1, 'Boleta', 'e', '18', '2023-06-11 15:12:22', '0.18', '236020.40', 'Aceptado'),
(11, 2, 1, 'Boleta', 'e', '19', '2023-06-11 15:17:31', '0.18', '13000.00', 'Aceptado');

--
-- Disparadores `venta`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockVentaAnular` AFTER UPDATE ON `venta` FOR EACH ROW BEGIN
  UPDATE articulo a
    JOIN detalle_venta dv
      ON dv.articulo_id = a.id
     AND dv.venta_id = new.id
     set a.stock = a.stock + dv.cantidad;
end
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  ADD KEY `fk_articulo_categoria_idx` (`categoria_id`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indices de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_detalle_ingreso_ingreso_idx` (`ingreso_id`),
  ADD KEY `fk_detalle_ingreso_articulo_idx` (`articulo_id`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_detalle_venta_venta_idx` (`venta_id`),
  ADD KEY `fk_detalle_venta_articulo_idx` (`articulo_id`);

--
-- Indices de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ingreso_persona_idx` (`persona_id`),
  ADD KEY `fk_ingreso_usuario_idx` (`usuario_id`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD KEY `fk_usuario_rol_idx` (`rol_id`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ingreso_persona_idx` (`persona_id`),
  ADD KEY `fk_ingreso_usuario_idx` (`usuario_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulo`
--
ALTER TABLE `articulo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `fk_articulo_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD CONSTRAINT `fk_detalle_ingreso_articulo` FOREIGN KEY (`articulo_id`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_detalle_ingreso_ingreso` FOREIGN KEY (`ingreso_id`) REFERENCES `ingreso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `fk_detalle_venta_articulo` FOREIGN KEY (`articulo_id`) REFERENCES `articulo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_detalle_venta_venta` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD CONSTRAINT `fk_ingreso_persona` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ingreso_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_rol` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fk_venta_persona` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_venta_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

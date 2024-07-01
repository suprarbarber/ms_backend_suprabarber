"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;
var _express = require("express");
var _controller = require("../controllers/controller.productos");
/**
 * Rutas de los productos
 * @module Rutas_producto
 */

/**
 * Esta es la ruta de los productos
 * @type {object}
 */
var rutaProducto = (0, _express.Router)();
rutaProducto.get("/producto", _controller.mostrarTodosProductos);
rutaProducto.get("/producto/:id", _controller.mostrarUnProducto);
rutaProducto.post("/producto", _controller.crearProductos);
rutaProducto["delete"]("/producto", _controller.eliminarProductos);
var _default = exports["default"] = rutaProducto;
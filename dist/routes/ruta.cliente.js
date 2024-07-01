"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;
var _express = require("express");
var _controller = require("../controllers/controller.cliente");
var _ouath = require("../middleware/ouath");
/**
 * Rutas del cliente
 * @module Rutas_cliente
 */

/**
 * Esta es la ruta de los clientes
 * @type {object}
 */
var rutaCliente = (0, _express.Router)();
rutaCliente.get("/cliente", _controller.mostrarTodosClientes);
rutaCliente.get("/cliente/:id", _controller.mostrarUnCliente);
// para atualizar datos
rutaCliente.put("/cliente/:id", _controller.actualizarDatos);
// para validar el token 
rutaCliente.post("/oauth", _ouath.verifyToken, _controller.validarToken);
var _default = exports["default"] = rutaCliente;
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

// para atualizar el telefono 
rutaCliente.put("/cliente", _controller.actualizarTelefono);
// para atualizar el nombre
rutaCliente.put("/cliente", _controller.actualizarNombre);
// para atualizar la contasena
rutaCliente.put("/cliente", _controller.actualizarContra);
// para atualizar el correo
rutaCliente.put("/cliente", _controller.actualizarCorreo);
// para eliminar la cuenta 
rutaCliente.put("/cliente", _controller.eliminarCuenta);

// para validar el token 
rutaCliente.post("/oauth", _ouath.verifyToken, _controller.validarToken);
var _default = exports["default"] = rutaCliente;
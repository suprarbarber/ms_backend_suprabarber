"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;
var _express = require("express");
var _controller = require("../controllers/controller.barbero");
/**
 * Rutas del barbero
 * @module Rutas_barbero
 */

/**
 * Esta es la ruta de los barberos
 * @type {object}
 */
var rutaBarbero = (0, _express.Router)();
rutaBarbero.get("/barbero", _controller.mostrarBarberos);
rutaBarbero.get("/barbero/:id", _controller.mostarUnBarbero);
rutaBarbero.put("/barbero", _controller.modificarCorreoBarbero);
var _default = exports["default"] = rutaBarbero;
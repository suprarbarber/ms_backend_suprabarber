"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;
var _express = require("express");
var _controller = require("../controllers/controller.rese\xF1as");
/**
 * Rutas de las reseñas
 * @module Rutas_reseñas
 */

/**
 * Esta es la ruta de las reseñas
 * @type {object}
 */
var rutaResena = (0, _express.Router)();
rutaResena.post("/resena", _controller.crearReseñas);
rutaResena.get("/resena", _controller.mostrarReseñas);
rutaResena["delete"]("/resena", _controller.eliminarReseñas);
var _default = exports["default"] = rutaResena;
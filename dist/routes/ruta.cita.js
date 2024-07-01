"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;
var _express = require("express");
var _controller = require("../controllers/controller.cita");
/**
 * Rutas de las citas
 * @module Rutas_cita
 */

/**
 * Esta es la ruta de las citas
 * @type {object}
 */
var rutaCita = (0, _express.Router)();
rutaCita.post("/cita", _controller.crearCita);
rutaCita.get("/cita", _controller.mostrarCita);
rutaCita.put("/cita", _controller.reprogramarCita);
rutaCita.put("/cita/:id", _controller.cancelarCita);
var _default = exports["default"] = rutaCita;
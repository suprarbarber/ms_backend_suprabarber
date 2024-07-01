"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;
var _express = require("express");
var _controller = require("../controllers/controller.turno");
/**
 * Rutas de los turnos
 * @module Rutas_turno
 */

/**
 * Esta es la ruta de los turnos
 * @type {object}
 */
var rutaTurno = (0, _express.Router)();
rutaTurno.get("/turno", _controller.verTurno);
var _default = exports["default"] = rutaTurno;
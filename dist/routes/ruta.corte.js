"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;
var _express = require("express");
var _controller = require("../controllers/controller.cortes");
/**
 * Rutas de los cortes
 * @module Rutas_corte
 */

/**
 * Esta es la ruta de los cortes
 * @type {object}
 */
var rutaCorte = (0, _express.Router)();
rutaCorte.get("/corte", _controller.mostrarCortes);
rutaCorte.get("/corte/:id", _controller.mostrarUnCorte);
rutaCorte.post("/corte", _controller.crearCorte);
rutaCorte["delete"]("/corte", _controller.eliminarCorte);
var _default = exports["default"] = rutaCorte;
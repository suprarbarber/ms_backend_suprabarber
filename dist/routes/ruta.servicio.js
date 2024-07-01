"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;
var _express = require("express");
var _controller = require("../controllers/controller.servicios");
/**
 * Rutas de los servicios
 * @module Rutas_servicio
 */

/**
 * Esta es la ruta de los servicios
 * @type {object}
 */
var rutaServicio = (0, _express.Router)();
rutaServicio.get("/servicio", _controller.mostrarTodosServicios);
rutaServicio.post("/servicio", _controller.crearServicio);
rutaServicio["delete"]("/servicio", _controller.eliminarServicio);
var _default = exports["default"] = rutaServicio;
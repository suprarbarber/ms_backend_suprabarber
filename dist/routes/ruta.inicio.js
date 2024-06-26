"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;
var _express = require("express");
var _controller = require("../controllers/controller.inicio");
var _validacion = require("../middleware/validacion.registro");
var rutaInicio = (0, _express.Router)();
rutaInicio.post("/registro", (0, _validacion.validacionDatos)(), _controller.registro);
rutaInicio.post("/login", _controller.loguear);
var _default = exports["default"] = rutaInicio;
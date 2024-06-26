"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;
var _express = require("express");
var _controller = require("../controllers/controller.productos");
var rutaProducto = (0, _express.Router)();
rutaProducto.get("/producto", _controller.mostrarTodosProductos);
var _default = exports["default"] = rutaProducto;
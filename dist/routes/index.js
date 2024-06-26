"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;
var _express = require("express");
var _ruta = _interopRequireDefault(require("./ruta.inicio"));
var _ruta2 = _interopRequireDefault(require("./ruta.cliente"));
var _ruta3 = _interopRequireDefault(require("./ruta.producto"));
function _interopRequireDefault(e) { return e && e.__esModule ? e : { "default": e }; }
//swagger

var ruta = (0, _express.Router)();
ruta.use("/", _ruta["default"]);
ruta.use("/", _ruta2["default"]);
ruta.use("/", _ruta3["default"]);
var _default = exports["default"] = ruta;
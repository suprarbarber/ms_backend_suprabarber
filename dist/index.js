"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");
var _app = _interopRequireDefault(require("./app"));
var _msj = require("./message/msj");
_app["default"].listen(_app["default"].get("port"), function () {
  console.log(_msj.campo + _msj.msjindex + _app["default"].get("port"));
});
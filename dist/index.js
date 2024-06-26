"use strict";

var _app = _interopRequireDefault(require("./app"));
var _msj = require("./message/msj");
function _interopRequireDefault(e) { return e && e.__esModule ? e : { "default": e }; }
_app["default"].listen(_app["default"].get("port"), function () {
  console.log(_msj.campo + _msj.msjindex + _app["default"].get("port"));
});
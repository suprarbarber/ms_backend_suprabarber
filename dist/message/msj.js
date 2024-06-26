"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.msjindex = exports.campo = exports.Success = exports.Error = void 0;
var Error = exports.Error = function Error(req, res) {
  var status = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : 400;
  var msj = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : "";
  res.status(status).json({
    error: true,
    status: status,
    body: msj
  });
};
var Success = exports.Success = function Success(req, res) {
  var status = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : 200;
  var msj = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : "";
  res.status(status).json({
    error: false,
    status: status,
    body: msj
  });
};
var campo = exports.campo = "Backend ";
var msjindex = exports.msjindex = "ejecutandose en http://localhost:";
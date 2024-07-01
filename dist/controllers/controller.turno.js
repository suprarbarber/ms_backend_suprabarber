"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");
Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.verTurno = void 0;
var _regenerator = _interopRequireDefault(require("@babel/runtime/regenerator"));
var _asyncToGenerator2 = _interopRequireDefault(require("@babel/runtime/helpers/asyncToGenerator"));
var _db = require("../config/db.mysql");
var _msj = require("../message/msj");
/**
 * Controlado del turno
 * @module Controlador_turno
 */

/**
 * Esta funcion es para mostrar los turno
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML                                                       
 */
var verTurno = exports.verTurno = /*#__PURE__*/function () {
  var _ref = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee(req, res) {
    var respuesta;
    return _regenerator["default"].wrap(function _callee$(_context) {
      while (1) switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return _db.db.query("CALL SP_MOSTRAR_TURNO()");
        case 3:
          respuesta = _context.sent;
          (0, _msj.Success)(req, res, 200, respuesta[0][0]);
          _context.next = 10;
          break;
        case 7:
          _context.prev = 7;
          _context.t0 = _context["catch"](0);
          (0, _msj.Error)(req, res, 400, _context.t0);
        case 10:
        case "end":
          return _context.stop();
      }
    }, _callee, null, [[0, 7]]);
  }));
  return function verTurno(_x, _x2) {
    return _ref.apply(this, arguments);
  };
}();
"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");
Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.mostrarBarberos = exports.mostarUnBarbero = exports.modificarCorreoBarbero = void 0;
var _regenerator = _interopRequireDefault(require("@babel/runtime/regenerator"));
var _asyncToGenerator2 = _interopRequireDefault(require("@babel/runtime/helpers/asyncToGenerator"));
var _db = require("../config/.db.mysql");
var _msj = require("../message/msj");
/**
 * Controladores de los barberos
 * @module Controladores_barberos
 */

/**
 * Esta funcion es para mostrar los barberos
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
var mostrarBarberos = exports.mostrarBarberos = /*#__PURE__*/function () {
  var _ref = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee(req, res) {
    var respuesta;
    return _regenerator["default"].wrap(function _callee$(_context) {
      while (1) switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return _db.db.query("CALL SP_MOSTRAR_BARBEROS()");
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
  return function mostrarBarberos(_x, _x2) {
    return _ref.apply(this, arguments);
  };
}();
/**
 * Esta funcion es para mostrar un barbero
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
var mostarUnBarbero = exports.mostarUnBarbero = /*#__PURE__*/function () {
  var _ref2 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee2(req, res) {
    var id, respuesta;
    return _regenerator["default"].wrap(function _callee2$(_context2) {
      while (1) switch (_context2.prev = _context2.next) {
        case 0:
          id = req.params['id'];
          _context2.prev = 1;
          _context2.next = 4;
          return _db.db.query("CALL SP_MOSTRAR_UN_BARBERO('".concat(id, "')"));
        case 4:
          respuesta = _context2.sent;
          (0, _msj.Success)(req, res, 200, respuesta[0][0]);
          _context2.next = 11;
          break;
        case 8:
          _context2.prev = 8;
          _context2.t0 = _context2["catch"](1);
          (0, _msj.Error)(req, res, 400, _context2.t0);
        case 11:
        case "end":
          return _context2.stop();
      }
    }, _callee2, null, [[1, 8]]);
  }));
  return function mostarUnBarbero(_x3, _x4) {
    return _ref2.apply(this, arguments);
  };
}();
/**
 * Esta funcion es para modificar el correo de un barbero
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
var modificarCorreoBarbero = exports.modificarCorreoBarbero = /*#__PURE__*/function () {
  var _ref3 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee3(req, res) {
    var _req$body, id, nuevoCorreo, respuesta;
    return _regenerator["default"].wrap(function _callee3$(_context3) {
      while (1) switch (_context3.prev = _context3.next) {
        case 0:
          _req$body = req.body, id = _req$body.id, nuevoCorreo = _req$body.nuevoCorreo;
          _context3.prev = 1;
          _context3.next = 4;
          return _db.db.query("CALL SP_ACTUALIZAR_CORREO_BARBERO('".concat(id, "', '").concat(nuevoCorreo, "')"));
        case 4:
          respuesta = _context3.sent;
          if (respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "Fue modificado correctamente");
          } else {
            (0, _msj.Error)(req, res, 400, "No se pudo modificar");
          }
          _context3.next = 11;
          break;
        case 8:
          _context3.prev = 8;
          _context3.t0 = _context3["catch"](1);
          (0, _msj.Error)(req, res, 400, _context3.t0);
        case 11:
        case "end":
          return _context3.stop();
      }
    }, _callee3, null, [[1, 8]]);
  }));
  return function modificarCorreoBarbero(_x5, _x6) {
    return _ref3.apply(this, arguments);
  };
}();
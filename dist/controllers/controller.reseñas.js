"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");
Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.mostrarReseñas = exports.eliminarReseñas = exports.crearReseñas = void 0;
var _regenerator = _interopRequireDefault(require("@babel/runtime/regenerator"));
var _asyncToGenerator2 = _interopRequireDefault(require("@babel/runtime/helpers/asyncToGenerator"));
var _db = require("../config/db.mysql");
var _msj = require("../message/msj");
/**
 * Controladores de las reseñas
 * @module Controladores_reseñas
 */

/**
 * Esta funcion es para crear las reseñas
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
var crearReseñas = exports.crearReseñas = /*#__PURE__*/function () {
  var _ref = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee(req, res) {
    var _req$body, id, comentario, respuesta;
    return _regenerator["default"].wrap(function _callee$(_context) {
      while (1) switch (_context.prev = _context.next) {
        case 0:
          _req$body = req.body, id = _req$body.id, comentario = _req$body.comentario;
          _context.prev = 1;
          _context.next = 4;
          return _db.db.query("CALL SP_CREAR_RESENA('".concat(id, "', '").concat(comentario, "')"));
        case 4:
          respuesta = _context.sent;
          if (respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "Fue agregado correctamente");
          } else {
            (0, _msj.Error)(req, res, 400, "No se pudo agregar");
          }
          _context.next = 11;
          break;
        case 8:
          _context.prev = 8;
          _context.t0 = _context["catch"](1);
          (0, _msj.Error)(req, res, 400, _context.t0);
        case 11:
        case "end":
          return _context.stop();
      }
    }, _callee, null, [[1, 8]]);
  }));
  return function crearReseñas(_x, _x2) {
    return _ref.apply(this, arguments);
  };
}();

/**
 * Esta funcion es para mostrar las reseñas
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
var mostrarReseñas = exports.mostrarReseñas = /*#__PURE__*/function () {
  var _ref2 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee2(req, res) {
    var respuesta;
    return _regenerator["default"].wrap(function _callee2$(_context2) {
      while (1) switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          _context2.next = 3;
          return _db.db.query("CALL SP_MOSTRAR_RESENAS()");
        case 3:
          respuesta = _context2.sent;
          (0, _msj.Success)(req, res, 200, respuesta[0][0]);
          _context2.next = 10;
          break;
        case 7:
          _context2.prev = 7;
          _context2.t0 = _context2["catch"](0);
          (0, _msj.Error)(req, res, 400, _context2.t0);
        case 10:
        case "end":
          return _context2.stop();
      }
    }, _callee2, null, [[0, 7]]);
  }));
  return function mostrarReseñas(_x3, _x4) {
    return _ref2.apply(this, arguments);
  };
}();

/**
 * Esta funcion es para eliminar las reseñas
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
var eliminarReseñas = exports.eliminarReseñas = /*#__PURE__*/function () {
  var _ref3 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee3(req, res) {
    var _req$body2, id, id_resena, respuesta;
    return _regenerator["default"].wrap(function _callee3$(_context3) {
      while (1) switch (_context3.prev = _context3.next) {
        case 0:
          _req$body2 = req.body, id = _req$body2.id, id_resena = _req$body2.id_resena;
          _context3.prev = 1;
          _context3.next = 4;
          return _db.db.query("CALL SP_ELIMINAR_RESENAS('".concat(id, "', '").concat(id_resena, "')"));
        case 4:
          respuesta = _context3.sent;
          if (respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "Fue eliminado correctamente");
          } else {
            (0, _msj.Error)(req, res, 400, "No se pudo eliminar");
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
  return function eliminarReseñas(_x5, _x6) {
    return _ref3.apply(this, arguments);
  };
}();
"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");
Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.reprogramarCita = exports.mostrarCita = exports.crearCita = exports.cancelarCita = void 0;
var _regenerator = _interopRequireDefault(require("@babel/runtime/regenerator"));
var _asyncToGenerator2 = _interopRequireDefault(require("@babel/runtime/helpers/asyncToGenerator"));
var _db = require("../config/.db.mysql");
var _msj = require("../message/msj");
/**
 * Controladores de las citas
 * @module Controladores_citas
 */

/**
 * Esta funcion es para crear una cita
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
var crearCita = exports.crearCita = /*#__PURE__*/function () {
  var _ref = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee(req, res) {
    var _req$body, id_turno, id_servicio, id, id_corte, id_barbero, id_fecha, fecha, respuesta, id_reserva, respuesta2;
    return _regenerator["default"].wrap(function _callee$(_context) {
      while (1) switch (_context.prev = _context.next) {
        case 0:
          _req$body = req.body, id_turno = _req$body.id_turno, id_servicio = _req$body.id_servicio, id = _req$body.id, id_corte = _req$body.id_corte, id_barbero = _req$body.id_barbero, id_fecha = _req$body.id_fecha; // console.log(id_fecha);
          fecha = "2024-07-".concat(id_fecha, "T05:00:00.000Z");
          _context.prev = 2;
          _context.next = 5;
          return _db.db.query("CALL SP_CREAR_CITA('".concat(id_turno, "', '").concat(id_servicio, "','").concat(fecha, "')"));
        case 5:
          respuesta = _context.sent;
          id_reserva = respuesta[0][0][0].id_reserva;
          _context.next = 9;
          return _db.db.query("CALL SP_CREAR_FACTURA_CITA('".concat(id_reserva, "','").concat(id_corte, "','").concat(id, "','").concat(id_barbero, "')"));
        case 9:
          respuesta2 = _context.sent;
          if (respuesta2[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "Cita reservada exitosamente");
          } else {
            (0, _msj.Error)(req, res, 400, "No se pudo reservar");
          }
          _context.next = 16;
          break;
        case 13:
          _context.prev = 13;
          _context.t0 = _context["catch"](2);
          (0, _msj.Error)(req, res, 400, _context.t0);
        case 16:
        case "end":
          return _context.stop();
      }
    }, _callee, null, [[2, 13]]);
  }));
  return function crearCita(_x, _x2) {
    return _ref.apply(this, arguments);
  };
}();

/**
 * Esta funcion es para mostrar las citas
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
var mostrarCita = exports.mostrarCita = /*#__PURE__*/function () {
  var _ref2 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee2(req, res) {
    var id, respuesta;
    return _regenerator["default"].wrap(function _callee2$(_context2) {
      while (1) switch (_context2.prev = _context2.next) {
        case 0:
          id = req.query['id'];
          _context2.prev = 1;
          _context2.next = 4;
          return _db.db.query("CALL SP_MOSTRAR_CITAS('".concat(id, "')"));
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
  return function mostrarCita(_x3, _x4) {
    return _ref2.apply(this, arguments);
  };
}();

/**
 * Esta funcion es para reprogramar una cita
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */

var reprogramarCita = exports.reprogramarCita = /*#__PURE__*/function () {
  var _ref3 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee3(req, res) {
    var _req$body2, id_reserva, id_turno, id_fecha, fecha, respuesta;
    return _regenerator["default"].wrap(function _callee3$(_context3) {
      while (1) switch (_context3.prev = _context3.next) {
        case 0:
          _req$body2 = req.body, id_reserva = _req$body2.id_reserva, id_turno = _req$body2.id_turno, id_fecha = _req$body2.id_fecha;
          fecha = "2024-07-".concat(id_fecha, "T05:00:00.000Z");
          _context3.prev = 2;
          _context3.next = 5;
          return _db.db.query("CALL SP_REPROGRAMAR_CITA('".concat(id_reserva, "', '").concat(id_turno, "','").concat(fecha, "')"));
        case 5:
          respuesta = _context3.sent;
          if (respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "Su cita ha sido reprogramada");
          } else {
            (0, _msj.Error)(req, res, 400, "No se pudo reprogramar la cita");
          }
          _context3.next = 12;
          break;
        case 9:
          _context3.prev = 9;
          _context3.t0 = _context3["catch"](2);
          (0, _msj.Error)(req, res, 400, _context3.t0);
        case 12:
        case "end":
          return _context3.stop();
      }
    }, _callee3, null, [[2, 9]]);
  }));
  return function reprogramarCita(_x5, _x6) {
    return _ref3.apply(this, arguments);
  };
}();

/**
 * Esta funcion es para cancelar una cita
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML                                                       
 */

var cancelarCita = exports.cancelarCita = /*#__PURE__*/function () {
  var _ref4 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee4(req, res) {
    var id_reserva, respuesta;
    return _regenerator["default"].wrap(function _callee4$(_context4) {
      while (1) switch (_context4.prev = _context4.next) {
        case 0:
          id_reserva = req.params['id'];
          _context4.prev = 1;
          _context4.next = 4;
          return _db.db.query("CALL SP_CANCELAR_CITA('".concat(id_reserva, "')"));
        case 4:
          respuesta = _context4.sent;
          if (respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "Su cita ha sido cancelada");
          } else {
            (0, _msj.Error)(req, res, 400, "No se pudo cancelar la cita");
          }
          _context4.next = 11;
          break;
        case 8:
          _context4.prev = 8;
          _context4.t0 = _context4["catch"](1);
          (0, _msj.Error)(req, res, 400, _context4.t0);
        case 11:
        case "end":
          return _context4.stop();
      }
    }, _callee4, null, [[1, 8]]);
  }));
  return function cancelarCita(_x7, _x8) {
    return _ref4.apply(this, arguments);
  };
}();
"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");
Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.mostrarUnCorte = exports.mostrarCortes = exports.eliminarCorte = exports.crearCorte = void 0;
var _regenerator = _interopRequireDefault(require("@babel/runtime/regenerator"));
var _asyncToGenerator2 = _interopRequireDefault(require("@babel/runtime/helpers/asyncToGenerator"));
var _db = require("../config/db.mysql");
var _msj = require("../message/msj");
/**
 * Controladores de los cortes
 * @module Controladores_cortes
 */

/**
 * Esta funcion sirve para mostrar todos los cortes
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var mostrarCortes = exports.mostrarCortes = /*#__PURE__*/function () {
  var _ref = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee(req, res) {
    var id, respuesta, _respuesta;
    return _regenerator["default"].wrap(function _callee$(_context) {
      while (1) switch (_context.prev = _context.next) {
        case 0:
          id = req.query["id"];
          if (!id) {
            _context.next = 14;
            break;
          }
          _context.prev = 2;
          _context.next = 5;
          return _db.db.query("CALL SP_MOSTRAR_CORTES_SERVICIO('".concat(id, "')"));
        case 5:
          respuesta = _context.sent;
          (0, _msj.Success)(req, res, 200, respuesta[0][0]);
          _context.next = 12;
          break;
        case 9:
          _context.prev = 9;
          _context.t0 = _context["catch"](2);
          (0, _msj.Error)(req, res, 400, _context.t0);
        case 12:
          _context.next = 24;
          break;
        case 14:
          _context.prev = 14;
          _context.next = 17;
          return _db.db.query("CALL SP_MOSTRAR_CORTES()");
        case 17:
          _respuesta = _context.sent;
          (0, _msj.Success)(req, res, 200, _respuesta[0][0]);
          _context.next = 24;
          break;
        case 21:
          _context.prev = 21;
          _context.t1 = _context["catch"](14);
          (0, _msj.Error)(req, res, 400, _context.t1);
        case 24:
        case "end":
          return _context.stop();
      }
    }, _callee, null, [[2, 9], [14, 21]]);
  }));
  return function mostrarCortes(_x, _x2) {
    return _ref.apply(this, arguments);
  };
}();

/**
 * Esta funcion sirve para mostrar un corte
 * @param {object} req captura es peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var mostrarUnCorte = exports.mostrarUnCorte = /*#__PURE__*/function () {
  var _ref2 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee2(req, res) {
    var id, respuesta;
    return _regenerator["default"].wrap(function _callee2$(_context2) {
      while (1) switch (_context2.prev = _context2.next) {
        case 0:
          id = req.params['id'];
          _context2.prev = 1;
          _context2.next = 4;
          return _db.db.query("CALL SP_MOSTRAR_UN_CORTE('".concat(id, "')"));
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
  return function mostrarUnCorte(_x3, _x4) {
    return _ref2.apply(this, arguments);
  };
}();

/**
 * Esta funcion sirve para crear los cortes
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var crearCorte = exports.crearCorte = /*#__PURE__*/function () {
  var _ref3 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee3(req, res) {
    var _req$body, nombre, id_servicio, respuesta;
    return _regenerator["default"].wrap(function _callee3$(_context3) {
      while (1) switch (_context3.prev = _context3.next) {
        case 0:
          _req$body = req.body, nombre = _req$body.nombre, id_servicio = _req$body.id_servicio;
          _context3.prev = 1;
          _context3.next = 4;
          return _db.db.query("CALL SP_CREAR_CORTE('".concat(nombre, "', '").concat(id_servicio, "')"));
        case 4:
          respuesta = _context3.sent;
          // condicional de la respuesta que traiga
          if (respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "El corte ha sido creado");
          } else {
            (0, _msj.Error)(req, res, 400, "No se pudo crear el corte");
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
  return function crearCorte(_x5, _x6) {
    return _ref3.apply(this, arguments);
  };
}();
/**
 * Esta funcion sirve para eliminar los cortes
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var eliminarCorte = exports.eliminarCorte = /*#__PURE__*/function () {
  var _ref4 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee4(req, res) {
    var id, respuesta;
    return _regenerator["default"].wrap(function _callee4$(_context4) {
      while (1) switch (_context4.prev = _context4.next) {
        case 0:
          id = req.body.id;
          _context4.prev = 1;
          _context4.next = 4;
          return _db.db.query("CALL SP_ELIMINAR_CORTE('".concat(id, "')"));
        case 4:
          respuesta = _context4.sent;
          // condicional de la respuesta que traiga
          if (respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "El servicio ha sido eliminado");
          } else {
            (0, _msj.Error)(req, res, 400, "No se pudo eliminar el corte");
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
  return function eliminarCorte(_x7, _x8) {
    return _ref4.apply(this, arguments);
  };
}();
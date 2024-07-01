"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");
Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.validarToken = exports.mostrarUnCliente = exports.mostrarTodosClientes = exports.actualizarDatos = void 0;
var _regenerator = _interopRequireDefault(require("@babel/runtime/regenerator"));
var _asyncToGenerator2 = _interopRequireDefault(require("@babel/runtime/helpers/asyncToGenerator"));
var _db = require("../config/db.mysql");
var _msj = require("../message/msj");
var _bcrypt = _interopRequireDefault(require("bcrypt"));
/**
 * Controladores de los clientes
 * @module Controladores_clientes
 */

/**
 * Esta funcion sirve para mostrar todos los clientes
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var mostrarTodosClientes = exports.mostrarTodosClientes = /*#__PURE__*/function () {
  var _ref = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee(req, res) {
    var respuesta;
    return _regenerator["default"].wrap(function _callee$(_context) {
      while (1) switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return _db.db.query("CALL SP_MOSTRAR_TODOS_CLIENTES()");
        case 3:
          respuesta = _context.sent;
          //se envia la respuesta de la solicitud
          (0, _msj.Success)(req, res, 200, respuesta[0][0]);
          _context.next = 10;
          break;
        case 7:
          _context.prev = 7;
          _context.t0 = _context["catch"](0);
          //mensaje json de error
          (0, _msj.Error)(req, res, 400, "Huvo un error intentalo más tarde");
        case 10:
        case "end":
          return _context.stop();
      }
    }, _callee, null, [[0, 7]]);
  }));
  return function mostrarTodosClientes(_x, _x2) {
    return _ref.apply(this, arguments);
  };
}();

/**
 * Esta funcion sirve para mostrar un cliente
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var mostrarUnCliente = exports.mostrarUnCliente = /*#__PURE__*/function () {
  var _ref2 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee2(req, res) {
    var id, respuesta;
    return _regenerator["default"].wrap(function _callee2$(_context2) {
      while (1) switch (_context2.prev = _context2.next) {
        case 0:
          //se trae el dato de la url
          id = req.params['id'];
          _context2.prev = 1;
          _context2.next = 4;
          return _db.db.query("CALL SP_MOSTRAR_UN_CLIENTE('".concat(id, "')"));
        case 4:
          respuesta = _context2.sent;
          //se envia la respuesta de la solicitud
          (0, _msj.Success)(req, res, 200, respuesta[0][0]);
          _context2.next = 11;
          break;
        case 8:
          _context2.prev = 8;
          _context2.t0 = _context2["catch"](1);
          //mensaje json de error
          (0, _msj.Error)(req, res, 400, "Huvo un error intentalo más tarde");
        case 11:
        case "end":
          return _context2.stop();
      }
    }, _callee2, null, [[1, 8]]);
  }));
  return function mostrarUnCliente(_x3, _x4) {
    return _ref2.apply(this, arguments);
  };
}();

/**
 * Esta funcion sirve para actualizar los datos de un cliente
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var actualizarDatos = exports.actualizarDatos = /*#__PURE__*/function () {
  var _ref3 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee3(req, res) {
    var _req$body, nombre, correo, telefono, contrasena, id, respuesta, _respuesta, _respuesta2, repp, compare, _respuesta3;
    return _regenerator["default"].wrap(function _callee3$(_context3) {
      while (1) switch (_context3.prev = _context3.next) {
        case 0:
          // Se traen los datos del body
          _req$body = req.body, nombre = _req$body.nombre, correo = _req$body.correo, telefono = _req$body.telefono, contrasena = _req$body.contrasena;
          id = req.params['id']; // Asegúrate de obtener el ID de los parámetros de la ruta
          _context3.prev = 2;
          if (!nombre) {
            _context3.next = 12;
            break;
          }
          _context3.next = 6;
          return _db.db.query("CALL SP_ACTUALIZAR_NOMBRE_CLIENTE('".concat(id, "', '").concat(nombre, "')"));
        case 6:
          respuesta = _context3.sent;
          if (!(respuesta[0].affectedRows == 1)) {
            _context3.next = 11;
            break;
          }
          return _context3.abrupt("return", (0, _msj.Success)(req, res, 200, "Su nombre ha sido actualizado"));
        case 11:
          return _context3.abrupt("return", (0, _msj.Error)(req, res, 400, "No se pudo actualizar el nombre"));
        case 12:
          if (!correo) {
            _context3.next = 21;
            break;
          }
          _context3.next = 15;
          return _db.db.query("CALL SP_ACTUALIZAR_CORREO_CLIENTE('".concat(id, "', '").concat(correo, "')"));
        case 15:
          _respuesta = _context3.sent;
          if (!(_respuesta[0].affectedRows == 1)) {
            _context3.next = 20;
            break;
          }
          return _context3.abrupt("return", (0, _msj.Success)(req, res, 200, "Su correo ha sido actualizado"));
        case 20:
          return _context3.abrupt("return", (0, _msj.Error)(req, res, 400, "No se pudo actualizar el correo"));
        case 21:
          if (!telefono) {
            _context3.next = 30;
            break;
          }
          _context3.next = 24;
          return _db.db.query("CALL SP_ACTUALIZAR_TELEFONO_CLIENTE('".concat(id, "', '").concat(telefono, "')"));
        case 24:
          _respuesta2 = _context3.sent;
          if (!(_respuesta2[0].affectedRows == 1)) {
            _context3.next = 29;
            break;
          }
          return _context3.abrupt("return", (0, _msj.Success)(req, res, 200, "Su telefono ha sido actualizado"));
        case 29:
          return _context3.abrupt("return", (0, _msj.Error)(req, res, 400, "No se pudo actualizar el telefono"));
        case 30:
          if (!contrasena) {
            _context3.next = 48;
            break;
          }
          _context3.next = 33;
          return _db.db.query("CALL SP_VERIFICAR_CUENTA_CLIENTE('".concat(id, "')"));
        case 33:
          repp = _context3.sent;
          if (!(repp[0][0] != 0)) {
            _context3.next = 48;
            break;
          }
          _context3.next = 37;
          return _bcrypt["default"].compare(contrasena, repp[0][0][0].contrasena);
        case 37:
          compare = _context3.sent;
          if (compare) {
            _context3.next = 40;
            break;
          }
          return _context3.abrupt("return", (0, _msj.Error)(req, res, 400, "Clave errada"));
        case 40:
          _context3.next = 42;
          return _db.db.query("CALL SP_DESACTIVAR_CUENTA_CLIENTE('".concat(id, "')"));
        case 42:
          _respuesta3 = _context3.sent;
          if (!(_respuesta3[0].affectedRows == 1)) {
            _context3.next = 47;
            break;
          }
          return _context3.abrupt("return", (0, _msj.Success)(req, res, 200, "Su cuenta ha sido desactivada"));
        case 47:
          return _context3.abrupt("return", (0, _msj.Error)(req, res, 400, "No se pudo desactivar su cuenta"));
        case 48:
          _context3.next = 53;
          break;
        case 50:
          _context3.prev = 50;
          _context3.t0 = _context3["catch"](2);
          // Manejo general de errores
          (0, _msj.Error)(req, res, 500, _context3.t0.message);
        case 53:
        case "end":
          return _context3.stop();
      }
    }, _callee3, null, [[2, 50]]);
  }));
  return function actualizarDatos(_x5, _x6) {
    return _ref3.apply(this, arguments);
  };
}();

/**
 * Esta funcion sirve para verificar si el token es valido
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var validarToken = exports.validarToken = function validarToken(req, res) {
  (0, _msj.Success)(req, res, 200, "El token es valido");
};
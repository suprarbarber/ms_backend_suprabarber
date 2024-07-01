"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");
Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.mostrarUnProducto = exports.mostrarTodosProductos = exports.eliminarProductos = exports.crearProductos = void 0;
var _regenerator = _interopRequireDefault(require("@babel/runtime/regenerator"));
var _asyncToGenerator2 = _interopRequireDefault(require("@babel/runtime/helpers/asyncToGenerator"));
var _db = require("../config/db.mysql");
var _msj = require("../message/msj");
/**
 * Controladores de los productos
 * @module Controladores_productos
 */

/**
 * Esta funcion sirve para mostrar todos los productos
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var mostrarTodosProductos = exports.mostrarTodosProductos = /*#__PURE__*/function () {
  var _ref = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee(req, res) {
    var respuesta;
    return _regenerator["default"].wrap(function _callee$(_context) {
      while (1) switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return _db.db.query("CALL SP_MOSTRAR_PRODUCTOS()");
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
  return function mostrarTodosProductos(_x, _x2) {
    return _ref.apply(this, arguments);
  };
}();
/**
 * Esta funcion sirve para mostrar un producto
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var mostrarUnProducto = exports.mostrarUnProducto = /*#__PURE__*/function () {
  var _ref2 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee2(req, res) {
    var id, respuesta;
    return _regenerator["default"].wrap(function _callee2$(_context2) {
      while (1) switch (_context2.prev = _context2.next) {
        case 0:
          id = req.params['id'];
          _context2.prev = 1;
          _context2.next = 4;
          return _db.db.query("CALL SP_MOSTRAR_UN_PRODUCTO('".concat(id, "')"));
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
  return function mostrarUnProducto(_x3, _x4) {
    return _ref2.apply(this, arguments);
  };
}();
/**
 * Esta funcion sirve para crear todos los productos
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var crearProductos = exports.crearProductos = /*#__PURE__*/function () {
  var _ref3 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee3(req, res) {
    var _req$body, nombre, descripcion, stock, respuesta;
    return _regenerator["default"].wrap(function _callee3$(_context3) {
      while (1) switch (_context3.prev = _context3.next) {
        case 0:
          _req$body = req.body, nombre = _req$body.nombre, descripcion = _req$body.descripcion, stock = _req$body.stock;
          _context3.prev = 1;
          _context3.next = 4;
          return _db.db.query("CALL SP_INSERTAR_PRODUCTO('".concat(nombre, "','").concat(descripcion, "','").concat(stock, "')"));
        case 4:
          respuesta = _context3.sent;
          if (respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "Producto creado correctamente");
          } else {
            (0, _msj.Error)(req, res, 400, "No se pudo crear el producto");
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
  return function crearProductos(_x5, _x6) {
    return _ref3.apply(this, arguments);
  };
}();
/**
 * Esta funcion sirve para eliminar todos los productos
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var eliminarProductos = exports.eliminarProductos = /*#__PURE__*/function () {
  var _ref4 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee4(req, res) {
    var id, respuesta;
    return _regenerator["default"].wrap(function _callee4$(_context4) {
      while (1) switch (_context4.prev = _context4.next) {
        case 0:
          id = req.body.id;
          _context4.prev = 1;
          _context4.next = 4;
          return _db.db.query("CALL SP_ELIMINAR_PRODUCTO('".concat(id, "')"));
        case 4:
          respuesta = _context4.sent;
          if (respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "Producto creado correctamente");
          } else {
            (0, _msj.Error)(req, res, 400, "No se pudo crear el producto");
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
  return function eliminarProductos(_x7, _x8) {
    return _ref4.apply(this, arguments);
  };
}();
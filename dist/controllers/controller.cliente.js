"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");
Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.validarToken = exports.mostrarUnCliente = exports.mostrarTodosClientes = exports.eliminarCuenta = exports.actualizarTelefono = exports.actualizarNombre = exports.actualizarCorreo = exports.actualizarContra = void 0;
var _regenerator = _interopRequireDefault(require("@babel/runtime/regenerator"));
var _asyncToGenerator2 = _interopRequireDefault(require("@babel/runtime/helpers/asyncToGenerator"));
var _db = require("../config/.db.mysql");
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
 * Esta funcion sirve para actualizar el telefono de un cliente
 * @param {object} req captura es peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var actualizarTelefono = exports.actualizarTelefono = /*#__PURE__*/function () {
  var _ref3 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee3(req, res) {
    var _req$body, id, telefono, respuesta;
    return _regenerator["default"].wrap(function _callee3$(_context3) {
      while (1) switch (_context3.prev = _context3.next) {
        case 0:
          //se traen los datos del body
          _req$body = req.body, id = _req$body.id, telefono = _req$body.telefono;
          _context3.prev = 1;
          _context3.next = 4;
          return _db.db.query("CALL SP_ACTUALIZAR_TELEFONO_CLIENTE('".concat(id, "','").concat(telefono, "')"));
        case 4:
          respuesta = _context3.sent;
          // condicional de si trajo una respuesta 
          if (respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "Su telefono ha sido actualizado");
          } else {
            (0, _msj.Error)(req, res, 400, "No se pudo actualizar el dato");
          }
          _context3.next = 11;
          break;
        case 8:
          _context3.prev = 8;
          _context3.t0 = _context3["catch"](1);
          // mensaje error vacio 
          (0, _msj.Error)(req, res, 400, _context3.t0);
        case 11:
        case "end":
          return _context3.stop();
      }
    }, _callee3, null, [[1, 8]]);
  }));
  return function actualizarTelefono(_x5, _x6) {
    return _ref3.apply(this, arguments);
  };
}();

/**
 * Esta funcion sirve para actualizar el nombre de un cliente
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var actualizarNombre = exports.actualizarNombre = /*#__PURE__*/function () {
  var _ref4 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee4(req, res) {
    var _req$body2, id, nombre, respuesta;
    return _regenerator["default"].wrap(function _callee4$(_context4) {
      while (1) switch (_context4.prev = _context4.next) {
        case 0:
          //se traen los datos del body
          _req$body2 = req.body, id = _req$body2.id, nombre = _req$body2.nombre;
          _context4.prev = 1;
          _context4.next = 4;
          return _db.db.query("CALL SP_ACTUALIZAR_NOMBRE_CLIENTE('".concat(id, "','").concat(nombre, "')"));
        case 4:
          respuesta = _context4.sent;
          // condicional de la respuesta que traiga 
          if (respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "Su nombre ha sido actualizado");
          } else {
            (0, _msj.Error)(req, res, 400, "No se pudo actualizar el dato");
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
  return function actualizarNombre(_x7, _x8) {
    return _ref4.apply(this, arguments);
  };
}();

/**
 * Esta funcion sirve para actualizar la contrasena de un cliente
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var actualizarContra = exports.actualizarContra = /*#__PURE__*/function () {
  var _ref5 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee5(req, res) {
    var _req$body3, id, contra, clavesincifrar, hash, claveCifrada, respuesta;
    return _regenerator["default"].wrap(function _callee5$(_context5) {
      while (1) switch (_context5.prev = _context5.next) {
        case 0:
          //se traen los datos del body
          _req$body3 = req.body, id = _req$body3.id, contra = _req$body3.contra;
          clavesincifrar = contra;
          _context5.prev = 2;
          _context5.next = 5;
          return _bcrypt["default"].hash(clavesincifrar, 2);
        case 5:
          hash = _context5.sent;
          // se encipto la contrasena }
          claveCifrada = hash; //se llama la base de datos con el p.a y se mandan los datos
          _context5.next = 9;
          return _db.db.query("CALL SP_ACTUALIZAR_CONTRASENA_CLIENTE('".concat(id, "','").concat(claveCifrada, "')"));
        case 9:
          respuesta = _context5.sent;
          // condicional de la respuesta que traiga 
          if (respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "Su contraseña ha sido actualizado");
          } else {
            (0, _msj.Error)(req, res, 400, "No se pudo actualizar el dato");
          }
          _context5.next = 16;
          break;
        case 13:
          _context5.prev = 13;
          _context5.t0 = _context5["catch"](2);
          (0, _msj.Error)(req, res, 400, _context5.t0);
        case 16:
        case "end":
          return _context5.stop();
      }
    }, _callee5, null, [[2, 13]]);
  }));
  return function actualizarContra(_x9, _x10) {
    return _ref5.apply(this, arguments);
  };
}();

/**
 * Esta funcion sirve para actualizar el correo de un cliente
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var actualizarCorreo = exports.actualizarCorreo = /*#__PURE__*/function () {
  var _ref6 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee6(req, res) {
    var _req$body4, id, correo, respuesta;
    return _regenerator["default"].wrap(function _callee6$(_context6) {
      while (1) switch (_context6.prev = _context6.next) {
        case 0:
          //se traen los datos del body
          _req$body4 = req.body, id = _req$body4.id, correo = _req$body4.correo;
          _context6.prev = 1;
          _context6.next = 4;
          return _db.db.query("CALL SP_ACTUALIZAR_CORREO_CLIENTE( '".concat(id, "' , '").concat(correo, "' )"));
        case 4:
          respuesta = _context6.sent;
          // condicional de la respuesta que traiga 
          if (respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "Su correo ha sido actualizado");
          } else {
            (0, _msj.Error)(req, res, 400, "No se pudo actualizar el dato");
          }
          _context6.next = 11;
          break;
        case 8:
          _context6.prev = 8;
          _context6.t0 = _context6["catch"](1);
          (0, _msj.Error)(req, res, 400, _context6.t0);
        case 11:
        case "end":
          return _context6.stop();
      }
    }, _callee6, null, [[1, 8]]);
  }));
  return function actualizarCorreo(_x11, _x12) {
    return _ref6.apply(this, arguments);
  };
}();

/**
 * Esta funcion sirve para eliminar la cuenta de un cliente
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
var eliminarCuenta = exports.eliminarCuenta = /*#__PURE__*/function () {
  var _ref7 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee7(req, res) {
    var id, respuesta;
    return _regenerator["default"].wrap(function _callee7$(_context7) {
      while (1) switch (_context7.prev = _context7.next) {
        case 0:
          //se traen los datos del body
          id = req.body.id;
          _context7.prev = 1;
          _context7.next = 4;
          return _db.db.query("CALL SP_ELIMINAR_USUARIOS( '".concat(id, "')"));
        case 4:
          respuesta = _context7.sent;
          // condicional de la respuesta que traiga 
          if (respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "Su cuenta ha sido eliminada");
          } else {
            (0, _msj.Error)(req, res, 400, "No se pudo eliminar su cuenta");
          }
          _context7.next = 11;
          break;
        case 8:
          _context7.prev = 8;
          _context7.t0 = _context7["catch"](1);
          (0, _msj.Error)(req, res, 400, _context7.t0);
        case 11:
        case "end":
          return _context7.stop();
      }
    }, _callee7, null, [[1, 8]]);
  }));
  return function eliminarCuenta(_x13, _x14) {
    return _ref7.apply(this, arguments);
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
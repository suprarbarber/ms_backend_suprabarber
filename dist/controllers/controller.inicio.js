"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");
Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.registro = exports.loguear = void 0;
var _regenerator = _interopRequireDefault(require("@babel/runtime/regenerator"));
var _asyncToGenerator2 = _interopRequireDefault(require("@babel/runtime/helpers/asyncToGenerator"));
var _db = require("../config/db.mysql");
var _msj = require("../message/msj");
var _bcrypt = _interopRequireDefault(require("bcrypt"));
var _jsonwebtoken = _interopRequireDefault(require("jsonwebtoken"));
var _dotenv = require("dotenv");
/**
 * Controladores de los apartados del home
 * @module Controladores_home
 */

(0, _dotenv.config)();

/**
 * Esta funcion sirve para registrar los usuarios
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */

var registro = exports.registro = /*#__PURE__*/function () {
  var _ref = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee(req, res) {
    var _req$body, id, nombre, telefono, correo, roll, contrasena, clave, repp, hash, claveCifrada, respuesta, _hash, _claveCifrada, _respuesta;
    return _regenerator["default"].wrap(function _callee$(_context) {
      while (1) switch (_context.prev = _context.next) {
        case 0:
          _req$body = req.body, id = _req$body.id, nombre = _req$body.nombre, telefono = _req$body.telefono, correo = _req$body.correo, roll = _req$body.roll;
          contrasena = req.body.contrasena;
          clave = contrasena;
          _context.prev = 3;
          if (!(roll == "cliente")) {
            _context.next = 20;
            break;
          }
          _context.next = 7;
          return _db.db.query("CALL SP_VERIFICAR_EXISTENCIA_DE_CUENTA('".concat(id, "', '").concat(correo, "')"));
        case 7:
          repp = _context.sent;
          if (!(repp[0][0] != 0)) {
            _context.next = 11;
            break;
          }
          (0, _msj.Error)(req, res, 402, "El usuario ya existe");
          return _context.abrupt("return");
        case 11:
          _context.next = 13;
          return _bcrypt["default"].hash(clave, 2);
        case 13:
          hash = _context.sent;
          claveCifrada = hash;
          _context.next = 17;
          return _db.db.query("CALL SP_REGISTRAR_CLIENTE('".concat(id, "', '").concat(nombre, "',\n            '").concat(telefono, "', '").concat(correo, "', '").concat(claveCifrada, "')"));
        case 17:
          respuesta = _context.sent;
          console.log(respuesta[0]);
          if (respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "Se ha registrado correctamente");
          } else {
            (0, _msj.Error)(req, res, 400, "Error, intentalo de nuevo más tarde");
          }
        case 20:
          if (!(roll == "barbero")) {
            _context.next = 30;
            break;
          }
          _context.next = 23;
          return _bcrypt["default"].hash(clave, 2);
        case 23:
          _hash = _context.sent;
          _claveCifrada = _hash;
          _context.next = 27;
          return _db.db.query("CALL SP_REGISTRAR_BARBERO('".concat(id, "', '").concat(nombre, "',\n            '").concat(telefono, "', '").concat(correo, "', '").concat(_claveCifrada, "')"));
        case 27:
          _respuesta = _context.sent;
          console.log(_respuesta[0]);
          if (_respuesta[0].affectedRows == 1) {
            (0, _msj.Success)(req, res, 200, "Se ha registrado correctamente");
          } else {
            (0, _msj.Error)(req, res, 400, "Error, intentalo de nuevo más tarde");
          }
        case 30:
          _context.next = 35;
          break;
        case 32:
          _context.prev = 32;
          _context.t0 = _context["catch"](3);
          (0, _msj.Error)(req, res, 401, _context.t0);
        case 35:
        case "end":
          return _context.stop();
      }
    }, _callee, null, [[3, 32]]);
  }));
  return function registro(_x, _x2) {
    return _ref.apply(this, arguments);
  };
}();

/**
 * Esta funcion sirve para loguear los usuarios
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */

var loguear = exports.loguear = /*#__PURE__*/function () {
  var _ref2 = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee2(req, res) {
    var _req$body2, correo, contrasena, repp, compare, respuesta, match, pyload, token, id;
    return _regenerator["default"].wrap(function _callee2$(_context2) {
      while (1) switch (_context2.prev = _context2.next) {
        case 0:
          _req$body2 = req.body, correo = _req$body2.correo, contrasena = _req$body2.contrasena;
          if (!(correo === '' && contrasena === '')) {
            _context2.next = 6;
            break;
          }
          (0, _msj.Error)(req, res, 401, "No hay datos");
          return _context2.abrupt("return");
        case 6:
          if (!(correo === '')) {
            _context2.next = 11;
            break;
          }
          (0, _msj.Error)(req, res, 401, "Falta el correo");
          return _context2.abrupt("return");
        case 11:
          if (!(contrasena === '')) {
            _context2.next = 14;
            break;
          }
          (0, _msj.Error)(req, res, 401, "Falta el contra");
          return _context2.abrupt("return");
        case 14:
          _context2.prev = 14;
          _context2.next = 17;
          return _db.db.query("CALL SP_LOGUEAR_ADMIN('".concat(correo, "')"));
        case 17:
          repp = _context2.sent;
          if (!(repp[0][0] != 0)) {
            _context2.next = 25;
            break;
          }
          _context2.next = 21;
          return _bcrypt["default"].compare(contrasena, repp[0][0][0].contrasena);
        case 21:
          compare = _context2.sent;
          // mensaje de clave errada 
          if (!compare) {
            (0, _msj.Error)(req, res, 401, "Clave errada");
          }
          (0, _msj.Success)(req, res, 200, "Acceso no perimitido");
          return _context2.abrupt("return");
        case 25:
          _context2.next = 27;
          return _db.db.query("CALL SP_LOGUEAR_USUARIO('".concat(correo, "')"));
        case 27:
          respuesta = _context2.sent;
          console.log(respuesta[0]);
          //para decir si el usuario no existe
          if (!(respuesta[0][0] == 0)) {
            _context2.next = 32;
            break;
          }
          (0, _msj.Error)(req, res, 405, "Correo Errado");
          return _context2.abrupt("return");
        case 32:
          if (!(respuesta[0][0] == 0)) {
            _context2.next = 35;
            break;
          }
          (0, _msj.Error)(req, res, 405, "Correo Errado");
          return _context2.abrupt("return");
        case 35:
          _context2.next = 37;
          return _bcrypt["default"].compare(contrasena, respuesta[0][0][0].contrasena);
        case 37:
          match = _context2.sent;
          if (match) {
            _context2.next = 41;
            break;
          }
          (0, _msj.Error)(req, res, 406, "Contraseña errada");
          return _context2.abrupt("return");
        case 41:
          console.log(3);

          //token
          pyload = {
            "correo": correo
          };
          token = _jsonwebtoken["default"].sign(pyload, process.env.TOKEN_PRIVATEKEY, {
            expiresIn: process.env.TOKEN_EXPIRES_IN
          });
          id = respuesta[0][0][0].id_cliente;
          (0, _msj.Success)(req, res, 200, {
            token: token,
            id: id
          });
          return _context2.abrupt("return");
        case 49:
          _context2.prev = 49;
          _context2.t0 = _context2["catch"](14);
          (0, _msj.Error)(req, res, 500, JSON.stringify({
            message: "Error en el servidor, por favor intentar más tarde"
          }));
        case 52:
        case "end":
          return _context2.stop();
      }
    }, _callee2, null, [[14, 49]]);
  }));
  return function loguear(_x3, _x4) {
    return _ref2.apply(this, arguments);
  };
}();
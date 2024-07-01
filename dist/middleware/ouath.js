"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");
Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.verifyToken = void 0;
var _regenerator = _interopRequireDefault(require("@babel/runtime/regenerator"));
var _asyncToGenerator2 = _interopRequireDefault(require("@babel/runtime/helpers/asyncToGenerator"));
var _jsonwebtoken = _interopRequireDefault(require("jsonwebtoken"));
var _dotenv = require("dotenv");
var _msj = require("../message/msj.js");
(0, _dotenv.config)();

/**
 * Esta funcion sirve para validar si el token es correcto
 * @param {object} req captura es la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @param {object} next da la instrucion de seguir con la siguiente función
 */
var verifyToken = exports.verifyToken = /*#__PURE__*/function () {
  var _ref = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee(req, res, next) {
    var token, validar;
    return _regenerator["default"].wrap(function _callee$(_context) {
      while (1) switch (_context.prev = _context.next) {
        case 0:
          token = req.headers["x-access-token"];
          try {
            validar = _jsonwebtoken["default"].verify(token, process.env.TOKEN_PRIVATEKEY);
            next();
          } catch (err) {
            (0, _msj.Error)(req, res, 401, err);
          }
        case 2:
        case "end":
          return _context.stop();
      }
    }, _callee);
  }));
  return function verifyToken(_x, _x2, _x3) {
    return _ref.apply(this, arguments);
  };
}();
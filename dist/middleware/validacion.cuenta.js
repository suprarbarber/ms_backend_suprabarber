"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");
Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.validarCuenta = void 0;
var _regenerator = _interopRequireDefault(require("@babel/runtime/regenerator"));
var _asyncToGenerator2 = _interopRequireDefault(require("@babel/runtime/helpers/asyncToGenerator"));
var _msj = require("../message/msj");
var _db = require("../config/db.mysql");
/**
 * Esta funcion sirve para validar si la cuenta ya existe
 * @param {object} req captura es la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @param {object} next da la instrucion de seguir con la siguiente funcion
 */
var validarCuenta = exports.validarCuenta = /*#__PURE__*/function () {
  var _ref = (0, _asyncToGenerator2["default"])( /*#__PURE__*/_regenerator["default"].mark(function _callee(req, res, next) {
    var _req$body, id, correo, repp;
    return _regenerator["default"].wrap(function _callee$(_context) {
      while (1) switch (_context.prev = _context.next) {
        case 0:
          _req$body = req.body, id = _req$body.id, correo = _req$body.correo;
          _context.prev = 1;
          _context.next = 4;
          return _db.db.query("CALL SP_VERIFICAR_EXISTENCIA_DE_CUENTA('".concat(id, "', '").concat(correo, "')"));
        case 4:
          repp = _context.sent;
          if (!repp[0][0] == 0) {
            (0, _msj.Error)(req, res, 401, "El usuario ya existe, no");
            console.log(repp[0][0]);
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
  return function validarCuenta(_x, _x2, _x3) {
    return _ref.apply(this, arguments);
  };
}();
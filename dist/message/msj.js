"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.msjindex = exports.campo = exports.Success = exports.Error = void 0;
/**
 * Esta funcion sirve para mostrar el mensaje en json de error
 * @param {object} req captura es la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @returns {void}
 */
var Error = exports.Error = function Error(req, res) {
  var status = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : 400;
  var msj = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : "";
  res.status(status).json({
    error: true,
    status: status,
    body: msj
  });
};

/**
 * Esta funcion sirve para mostrar el mensaje en json de exito
 * @param {object} req captura es la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @returns {void}
 */
var Success = exports.Success = function Success(req, res) {
  var status = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : 200;
  var msj = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : "";
  res.status(status).json({
    error: false,
    status: status,
    body: msj
  });
};

/**
 * Mensaje donde va el campo
 * @type {string}
 */
var campo = exports.campo = "Backend ";

/**
 * Mensaje del index.js
 * @type {string}
 */
var msjindex = exports.msjindex = "ejecutandose en http://localhost:";
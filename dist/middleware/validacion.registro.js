"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.validacionDatos = void 0;
var _expressValidator = require("express-validator");
var _msj = require("../message/msj");
/**
 * Esta es una funcion que sirve para validar los datos enviados
 * @returns {void}
 */
var validacionDatos = exports.validacionDatos = function validacionDatos() {
  return [
  // validacion del id 
  (0, _expressValidator.check)('id').isNumeric().trim().notEmpty().withMessage('El campo identificacion está vacio'),
  // validacion del nombre 
  (0, _expressValidator.check)('nombre').notEmpty().withMessage('El campo nombre está vacio'),
  //validacion del telefono
  (0, _expressValidator.check)('telefono').trim().notEmpty().withMessage('el campo telefono está vacio'),
  // valiadacion del correo 
  (0, _expressValidator.check)('correo').isEmail().withMessage('Correo invalido'),
  //validacion de la contaseña
  (0, _expressValidator.check)('contrasena').isLength({
    min: 5
  }).withMessage('La contrasena debe tener minimo 5 caracteres'),
  //validacion del roll
  (0, _expressValidator.check)('roll').notEmpty(), function (req, res, next) {
    var errors = (0, _expressValidator.validationResult)(req);
    if (!errors.isEmpty()) {
      var checkerror = errors.array().map(function (error) {
        return error.msg;
      });
      (0, _msj.Error)(req, res, 400, checkerror);
      return;
    }
    next();
  }];
};
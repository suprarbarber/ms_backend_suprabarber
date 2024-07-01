"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");
var _swaggerAutogen = _interopRequireDefault(require("swagger-autogen"));
var _dotenv = require("dotenv");
(0, _dotenv.config)();
var port = process.env.PORT;
var doc = {
  info: {
    title: 'SUPRABARBER',
    description: 'aplicacion de reserva de citas de una barbería'
  },
  host: 'localhost' + port + "/api"
};
var outputFile = './swagger-output.json';
var routes = ['../routes/index.js', '../routes/ruta.cliente.js'];

/* NOTE: If you are using the express Router, you must pass in the 'routes' only the
root file where the route starts, such as index.js, app.js, routes.js, etc ... */

(0, _swaggerAutogen["default"])()(outputFile, routes, doc);
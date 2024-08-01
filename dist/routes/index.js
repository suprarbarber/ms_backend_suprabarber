"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");
Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;
var _express = require("express");
var _ruta = _interopRequireDefault(require("./ruta.inicio"));
var _ruta2 = _interopRequireDefault(require("./ruta.cliente"));
var _ruta3 = _interopRequireDefault(require("./ruta.producto"));
var _ruta4 = _interopRequireDefault(require("./ruta.servicio"));
var _ruta5 = _interopRequireDefault(require("./ruta.corte"));
var _ruta6 = _interopRequireDefault(require("./ruta.rese\xF1a"));
var _ruta7 = _interopRequireDefault(require("./ruta.barbero"));
var _ruta8 = _interopRequireDefault(require("./ruta.cita"));
var _swaggerUiExpress = _interopRequireDefault(require("swagger-ui-express"));
var _swaggerOutput = _interopRequireDefault(require("../tool/swagger-output.json"));
var _ruta9 = _interopRequireDefault(require("./ruta.turno"));
var _fs = _interopRequireDefault(require("fs"));
var _path = _interopRequireDefault(require("path"));
/**
 * Rutas del index
 * @module Rutas_index
 */

// swagger

// para ver base de datos 

var _dirname = _path["default"].resolve();

/**
 * Esta son las rutas de mi proyecto
 * @type {object}
 */
var ruta = (0, _express.Router)();
ruta.use("/", _ruta["default"]);
ruta.use("/", _ruta2["default"]);
ruta.use("/", _ruta3["default"]);
ruta.use("/", _ruta4["default"]);
ruta.use("/", _ruta5["default"]);
ruta.use("/", _ruta6["default"]);
ruta.use("/", _ruta7["default"]);
ruta.use("/", _ruta8["default"]);
ruta.use("/", _ruta9["default"]);
ruta.use("/doc", _swaggerUiExpress["default"].serve, _swaggerUiExpress["default"].setup(_swaggerOutput["default"]));
ruta.get('/db', function (req, res) {
  var filePath = _path["default"].join(_dirname, 'app', 'tool', 'bd_26062024.sql'); // Ruta del archivo
  console.log('File path:', filePath); // Imprime la ruta del archivo
  _fs["default"].readFile(filePath, 'utf8', function (err, data) {
    if (err) {
      console.error('Error reading file:', err); // Agrega un mensaje de error en la consola
      res.status(500).send('Error reading file.');
    } else {
      res.type('text/plain');
      res.send(data);
    }
  });
});
var _default = exports["default"] = ruta;
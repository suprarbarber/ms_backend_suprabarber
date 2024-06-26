"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;
var _dotenv = require("dotenv");
var _express = _interopRequireDefault(require("express"));
var _routes = _interopRequireDefault(require("./routes"));
var _morgan = _interopRequireDefault(require("morgan"));
var _cors = _interopRequireDefault(require("cors"));
function _interopRequireDefault(e) { return e && e.__esModule ? e : { "default": e }; }
(0, _dotenv.config)();
var app = (0, _express["default"])();

//middleware
app.use((0, _cors["default"])());
app.use((0, _morgan["default"])('dev'));
app.use(_express["default"].json());
app.use(_express["default"].urlencoded({
  extended: true
}));

//puerto
app.set("port", process.env.PORT || 3000);

//rutas
app.use("/api", _routes["default"]);
var _default = exports["default"] = app;
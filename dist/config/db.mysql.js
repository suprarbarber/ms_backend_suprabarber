"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.db = void 0;
var _promise = require("mysql2/promise");
var _dotenv = require("dotenv");
(0, _dotenv.config)();

/**
 * Sirve para conectarme ami base de datos
 * @type {object}
 */
var db = exports.db = (0, _promise.createPool)({
  host: process.env.MYSQL_HOST,
  user: process.env.MYSQL_USER,
  port: process.env.MYSQL_PORT,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_DB
});
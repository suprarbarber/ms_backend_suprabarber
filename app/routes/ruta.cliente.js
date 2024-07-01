/**
 * Rutas del cliente
 * @module Rutas_cliente
 */

import { Router } from "express";
import {  actualizarDatos, mostrarTodosClientes, mostrarUnCliente, validarToken} from "../controllers/controller.cliente";
import { verifyToken } from "../middleware/ouath";

/**
 * Esta es la ruta de los clientes
 * @type {object}
 */
const rutaCliente = Router();

rutaCliente.get("/cliente", mostrarTodosClientes);
rutaCliente.get("/cliente/:id", mostrarUnCliente);
// para atualizar datos
rutaCliente.put("/cliente/:id", actualizarDatos);
// para validar el token 
rutaCliente.post("/oauth", verifyToken ,validarToken)

export default rutaCliente;
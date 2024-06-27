/**
 * Rutas de los productos
 * @module Rutas_producto
 */

import { Router } from "express";
import { crearProductos, eliminarProductos, mostrarTodosProductos, mostrarUnProducto } from "../controllers/controller.productos";

/**
 * Esta es la ruta de los productos
 * @type {object}
 */
const rutaProducto = Router();

rutaProducto.get("/producto" , mostrarTodosProductos);
rutaProducto.get("/producto/:id" , mostrarUnProducto);
rutaProducto.post("/producto" , crearProductos);
rutaProducto.delete("/producto" , eliminarProductos);

export default rutaProducto;
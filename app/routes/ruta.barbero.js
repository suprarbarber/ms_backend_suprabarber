/**
 * Rutas del barbero
 * @module Rutas_barbero
 */

import { Router } from "express";
import { modificarCorreoBarbero, mostarUnBarbero, mostrarBarberos } from "../controllers/controller.barbero";

/**
 * Esta es la ruta de los barberos
 * @type {object}
 */
const rutaBarbero = Router();

rutaBarbero.get("/barbero", mostrarBarberos);
rutaBarbero.get("/barbero/:id", mostarUnBarbero);
rutaBarbero.put("/barbero", modificarCorreoBarbero);



export default rutaBarbero;
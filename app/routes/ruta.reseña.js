/**
 * Rutas de las reseñas
 * @module Rutas_reseñas
 */

import { Router } from 'express'
import { crearReseñas, eliminarReseñas, mostrarReseñas } from '../controllers/controller.reseñas';

/**
 * Esta es la ruta de las reseñas
 * @type {object}
 */
const rutaResena = Router();

rutaResena.post("/resena", crearReseñas);
rutaResena.get("/resena", mostrarReseñas);
rutaResena.delete("/resena", eliminarReseñas);

export default rutaResena

import { Router } from 'express'
import { crearReseñas, eliminarReseñas, mostrarReseñas } from '../controllers/controller.reseñas';

/**
 * Esta es la ruta de las reseñas
 * @type {object}
 */
const rutaReseña = Router();

rutaReseña.post("/resena", crearReseñas);
rutaReseña.get("/resena", mostrarReseñas);
rutaReseña.delete("/resena", eliminarReseñas);

export default rutaReseña

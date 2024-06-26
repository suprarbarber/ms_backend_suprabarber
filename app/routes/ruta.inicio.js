import { Router } from "express";
import { loguear, registro } from "../controllers/controller.inicio";
import { validacionDatos } from "../middleware/validacion.registro";

/**
 * Esta es la ruta de las vistas iniciales
 * @type {object}
 */
const rutaInicio = Router();

rutaInicio.post("/registro" , validacionDatos() ,registro);
rutaInicio.post("/login", loguear)

export default rutaInicio;
import { Router } from "express";
import { loguear, registro } from "../controllers/controller.inicio";
import { validacionDatos } from "../middleware/validacion.registro";
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
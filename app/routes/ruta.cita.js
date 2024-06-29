/**
 * Rutas de las citas
 * @module Rutas_cita
 */

import { Router } from "express";
import { cancelarCita, crearCita, mostrarCita, reprogramarCita } from "../controllers/controller.cita";

/**
 * Esta es la ruta de las citas
 * @type {object}
 */
const rutaCita = Router();

rutaCita.post("/cita", crearCita)
rutaCita.get("/cita", mostrarCita)
rutaCita.put("/cita", reprogramarCita)
rutaCita.put("/cita/:id", cancelarCita)

export default rutaCita;
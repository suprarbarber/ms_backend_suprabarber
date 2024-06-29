/**
 * Rutas de los turnos
 * @module Rutas_turno
 */

import { Router } from "express";
import { verTurno } from "../controllers/controller.turno";

/**
 * Esta es la ruta de los turnos
 * @type {object}
 */
const rutaTurno = Router();

rutaTurno.get("/turno", verTurno);

export default rutaTurno;
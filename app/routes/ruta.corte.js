/**
 * Rutas de los cortes
 * @module Rutas_corte
 */

import { Router } from "express";
import { crearCorte, eliminarCorte, mostrarCortes, mostrarUnCorte } from "../controllers/controller.cortes";

/**
 * Esta es la ruta de los cortes
 * @type {object}
 */
const rutaCorte = Router();

rutaCorte.get("/corte", mostrarCortes)
rutaCorte.get("/corte/:id", mostrarUnCorte)
rutaCorte.post("/corte", crearCorte)
rutaCorte.delete("/corte", eliminarCorte)

export default rutaCorte;
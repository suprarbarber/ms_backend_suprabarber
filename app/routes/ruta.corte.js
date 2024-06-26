import { Router } from "express";
import { crearCorte, eliminarCorte, mostrarCortesServicio, mostrarTodosCortes, mostrarUnCorte } from "../controllers/controller.cortes";

/**
 * Esta es la ruta de los cortes
 * @type {object}
 */
const rutaCorte = Router();

// rutaCorte.get("/corte", mostrarTodosCortes)
rutaCorte.get("/corte", mostrarCortesServicio)
rutaCorte.get("/corte/:id", mostrarUnCorte)
rutaCorte.post("/corte", crearCorte)
rutaCorte.delete("/corte", eliminarCorte)

export default rutaCorte;
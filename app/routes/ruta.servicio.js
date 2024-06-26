import { Router } from "express";
import { crearServicio, eliminarServicio, mostrarTodosServicios } from "../controllers/controller.servicios";

/**
 * Esta es la ruta de los servicio
 * @type {object}
 */
const rutaServicio = Router();

rutaServicio.get("/servicio", mostrarTodosServicios)
rutaServicio.post("/servicio", crearServicio)
rutaServicio.delete("/servicio", eliminarServicio)

export default rutaServicio;
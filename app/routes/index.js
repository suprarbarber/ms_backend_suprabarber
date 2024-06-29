/**
 * Rutas del index
 * @module Rutas_index
 */

import { Router } from "express";
import rutaInicio from "./ruta.inicio";
import rutaCliente from "./ruta.cliente";
import rutaProducto from "./ruta.producto";
import rutaServicio from "./ruta.servicio";
import rutaCorte from "./ruta.corte";
import rutaResena from "./ruta.reseña";
import rutaBarbero from "./ruta.barbero";
import rutaCita from "./ruta.cita";
// swagger
import swaggerUi from "swagger-ui-express";
import swaggerFile from "../tool/swagger-output.json"
import rutaTurno from "./ruta.turno";


/**
 * Esta son las rutas de mi proyecto
 * @type {object}
 */
const ruta = Router();

ruta.use("/", rutaInicio);
ruta.use("/", rutaCliente);
ruta.use("/", rutaProducto);
ruta.use("/", rutaServicio);
ruta.use("/", rutaCorte);
ruta.use("/", rutaResena);
ruta.use("/", rutaBarbero);
ruta.use("/", rutaCita);
ruta.use("/", rutaTurno);

ruta.use("/doc", swaggerUi.serve, swaggerUi.setup(swaggerFile));


export default ruta;
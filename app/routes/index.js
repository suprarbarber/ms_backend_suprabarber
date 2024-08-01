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
// para ver base de datos 
import fs from 'fs';
import path from 'path';

const __dirname = path.resolve();


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

ruta.get('/db', (req, res) => {
    const filePath = path.join(__dirname, 'app','tool', 'bd_26062024.sql'); // Ruta del archivo
    console.log('File path:', filePath); // Imprime la ruta del archivo
    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err); // Agrega un mensaje de error en la consola
            res.status(500).send('Error reading file.');
        } else {
            res.type('text/plain');
            res.send(data);
        }
    });
});


export default ruta;
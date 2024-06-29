/**
 * Controlado del turno
 * @module Controlador_turno
 */

import { db } from "../config/.db.mysql";
import { Error, Success } from "../message/msj";


/**
 * Esta funcion es para mostrar los turno
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML                                                       
 */
const verTurno = async(req,res) => {
    try {
        const respuesta = await db.query(`CALL SP_MOSTRAR_TURNO()`);

        Success(req, res, 200, respuesta[0][0])
    } catch (error) {
        Error(req, res, 400, error)
    }
}

export { verTurno }
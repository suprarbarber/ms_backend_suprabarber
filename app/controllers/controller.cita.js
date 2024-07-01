/**
 * Controladores de las citas
 * @module Controladores_citas
 */

import { db } from "../config/db.mysql";
import { Error, Success } from "../message/msj";


/**
 * Esta funcion es para crear una cita
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
const crearCita = async(req, res) => {
    const {id_turno, id_servicio, id, id_corte, id_barbero, id_fecha } = req.body;
    // console.log(id_fecha);
    const fecha = `2024-07-${id_fecha}`

    console.log();
    
    try {
        const respuesta = await db.query(`CALL SP_CREAR_CITA('${id_turno}', '${id_servicio}','${fecha}')`);
        const id_reserva = respuesta[0][0][0].id_reserva;

        const respuesta2 = await db.query(`CALL SP_CREAR_FACTURA_CITA('${id_reserva}','${id_corte}','${id}','${id_barbero}')`)

        if(respuesta2[0].affectedRows == 1){
            Success(req, res, 200, "Cita reservada exitosamente")
        }else{
            Error(req, res, 400, "No se pudo reservar")
        }
        
    } catch (error) {
        Error(req, res, 400, error)
    }
}

/**
 * Esta funcion es para mostrar las citas
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
const mostrarCita = async(req, res) => {
    const id = req.query['id'];
    try {
        const respuesta = await db.query(`CALL SP_MOSTRAR_CITAS('${id}')`);

        Success(req, res, 200, respuesta[0][0])
        
    } catch (error) {
        Error(req, res, 400, error)
    }
}


/**
 * Esta funcion es para reprogramar una cita
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */

const reprogramarCita = async(req, res) => {
    const {id_reserva, id_turno, id_fecha} = req.body;
    const fecha = `2024-07-${id_fecha}T05:00:00.000Z`

    try {
        const respuesta = await db.query(`CALL SP_REPROGRAMAR_CITA('${id_reserva}', '${id_turno}','${fecha}')`);

        if(respuesta[0].affectedRows == 1){
            Success(req, res, 200, "Su cita ha sido reprogramada")
        }else{
            Error(req, res, 400, "No se pudo reprogramar la cita")
        }
    } catch (error) {
        Error(req, res, 400, error)
    }
}


/**
 * Esta funcion es para cancelar una cita
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML                                                       
 */

const cancelarCita = async(req, res) => {
    const id_reserva = req.params['id'];
    
    try {
        const respuesta = await db.query(`CALL SP_CANCELAR_CITA('${id_reserva}')`);

        if(respuesta[0].affectedRows == 1){
            Success(req, res, 200, "Su cita ha sido cancelada")
        }else{
            Error(req, res, 400, "No se pudo cancelar la cita")
        }
    } catch (error) {
        Error(req, res, 400, error)
    }
}



export {crearCita, reprogramarCita, cancelarCita, mostrarCita}
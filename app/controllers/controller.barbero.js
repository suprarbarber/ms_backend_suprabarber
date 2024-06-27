/**
 * Controladores de los barberos
 * @module Controladores_barberos
 */

import { db } from "../config/.db.mysql";
import { Error, Success } from "../message/msj";


/**
 * Esta funcion es para mostrar los barberos
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
const mostrarBarberos = async(req, res) => {
    try {
        const respuesta = await db.query(`CALL SP_MOSTRAR_BARBEROS()`);

        Success(req, res, 200, respuesta[0][0])
        
    } catch (error) {
        Error(req, res, 400, error)
    }
}
/**
 * Esta funcion es para mostrar un barbero
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
const mostarUnBarbero = async(req, res) => {
    let id = req.params['id'];
    
    try {
        const respuesta = await db.query(`CALL SP_MOSTRAR_UN_BARBERO('${id}')`);

        Success(req, res, 200, respuesta[0][0])
        
    } catch (error) {
        Error(req, res, 400, error)
    }
}
/**
 * Esta funcion es para modificar el correo de un barbero
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
const modificarCorreoBarbero = async(req, res) => {
    const {id, nuevoCorreo} = req.body
    try {
        const respuesta = await db.query(`CALL SP_ACTUALIZAR_CORREO_BARBERO('${id}', '${nuevoCorreo}')`);

        if(respuesta[0].affectedRows == 1){
            Success(req, res, 200, "Fue modificado correctamente")
        }else{
            Error(req, res, 400, "No se pudo modificar")
        }
        
    } catch (error) {
        Error(req, res, 400, error)
    }
}

export {mostrarBarberos, mostarUnBarbero ,modificarCorreoBarbero}
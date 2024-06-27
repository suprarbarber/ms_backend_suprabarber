/**
 * Controladores de las reseñas
 * @module Controladores_reseñas
 */

import { db } from "../config/.db.mysql";
import { Error, Success } from "../message/msj";

/**
 * Esta funcion es para crear las reseñas
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
const crearReseñas = async(req, res) => {
    const {id, comentario} = req.body

    try {
        const respuesta = await db.query(`CALL SP_INSERTAR_RESENAS('${id}', '${comentario}')`);

        if(respuesta[0].affectedRows == 1){
            Success(req, res, 200, "Fue agregado correctamente")
        }else{
            Error(req, res, 400, "No se pudo agregar")
        }
    } catch (error) {
        Error(req, res, 400, error)
    }
}

/**
 * Esta funcion es para mostrar las reseñas
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
const mostrarReseñas = async(req, res) => {
    try {
        const respuesta = await db.query(`CALL SP_MOSTRAR_RESENAS()`);

        Success(req, res, 200, respuesta[0][0])
        
    } catch (error) {
        Error(req, res, 400, error)
    }
}

/**
 * Esta funcion es para eliminar las reseñas
 * @param {*} req captura peticiones en HTML
 * @param {*} res envia respuestas en HTML
 */
const eliminarReseñas = async(req, res) => {
    const {id, id_resena} = req.body
    try {
        const respuesta = await db.query(`CALL SP_ELIMINAR_RESENAS('${id}', '${id_resena}')`);

        if(respuesta[0].affectedRows == 1){
            Success(req, res, 200, "Fue eliminado correctamente")
        }else{
            Error(req, res, 400, "No se pudo eliminar")
        }
        
    } catch (error) {
        Error(req, res, 400, error)
    }
}

export {crearReseñas, mostrarReseñas, eliminarReseñas}
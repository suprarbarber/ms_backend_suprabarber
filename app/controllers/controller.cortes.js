/**
 * Controladores de los cortes
 * @module Controladores_cortes
 */

import { db } from "../config/.db.mysql"
import { Success, Error } from "../message/msj"

/**
 * Esta funcion sirve para mostrar todos los cortes
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @returns 
 */
const mostrarCortes = async(req, res) => {
    const id = req.query["id"];

    if(id){
        try {
            const respuesta = await db.query(`CALL SP_MOSTRAR_CORTES_SERVICIO('${id}')`)
            Success(req, res, 200, respuesta[0][0])
        
        } catch (error) {
            Error(req, res, 400, error)
        }

    }else{
        try {
            const respuesta = await db.query(`CALL SP_MOSTRAR_CORTES()`)
    
            Success(req, res, 200, respuesta[0][0])
    
        } catch (error) {
            Error(req, res, 400, error)
        }
    }
    
}


/**
 * Esta funcion sirve para mostrar un corte
 * @param {object} req captura es peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @returns 
 */
const mostrarUnCorte = async(req, res) => {
    const id = req.params['id'];

    try {
        const respuesta = await db.query(`CALL SP_MOSTRAR_UN_CORTE('${id}')`)

        Success(req, res, 200, respuesta[0][0])

    } catch (error) {
        Error(req, res, 400, error)
    }
}

/**
 * Esta funcion sirve para crear los cortes
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @returns 
 */
const crearCorte = async(req, res) => {
    const {nombre, id_servicio} = req.body

    try {
        const respuesta = await db.query(`CALL SP_CREAR_CORTE('${nombre}', '${id_servicio}')`)

        // condicional de la respuesta que traiga
        if(respuesta[0].affectedRows == 1){
            Success(req, res, 200, "El corte ha sido creado")
        }else{
            Error(req, res,400, "No se pudo crear el corte")
        }
    } catch (error) {
        Error(req, res, 400, error)
    }

}
/**
 * Esta funcion sirve para eliminar los cortes
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @returns 
 */
const eliminarCorte = async(req, res) => {
    const {id} = req.body

    try {
        const respuesta = await db.query(`CALL SP_ELIMINAR_CORTE('${id}')`)

        // condicional de la respuesta que traiga
        if(respuesta[0].affectedRows == 1){
            Success(req, res, 200, "El servicio ha sido eliminado")
        }else{
            Error(req, res,400, "No se pudo eliminar el corte")
        }
    } catch (error) {
        Error(req, res, 400, error)
    }

}

export { mostrarCortes, mostrarUnCorte,crearCorte, eliminarCorte};
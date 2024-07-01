/**
 * Controladores de los servicios
 * @module Controladores_servicios
 */

import { db } from "../config/db.mysql"
import { Success, Error } from "../message/msj"

/**
 * Esta funcion sirve para mostrar los servicios
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
const mostrarTodosServicios = async(req, res) => {
    try {
        const respuesta = await db.query(`CALL SP_MOSTRAR_SERVICIOS()`)

        Success(req, res, 200, respuesta[0][0])

    } catch (error) {
        Error(req, res, 400, error)
    }
}

/**
 * Esta funcion sirve para crear los servicios
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
const crearServicio = async(req, res) => {
    const {nombre} = req.body

    try {
        const respuesta = await db.query(`CALL SP_CREAR_SERVICIO('${nombre}')`)

        // condicional de la respuesta que traiga 
        if(respuesta[0].affectedRows == 1){
            Success(req, res, 200, "El servicio ha sido creado")
        }else{
            Error(req, res,400, "No se pudo crear el servicio")
        }
    } catch (error) {
        Error(req, res, 400, error)
    }

}
/**
 * Esta funcion sirve para eliminar servicios
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
const eliminarServicio = async(req, res) => {
    const {id} = req.body
    try {
        const respuesta = await db.query(`CALL SP_ELIMINAR_SERVICIO('${id}')`)

        // condicional de la respuesta que traiga 
        if(respuesta[0].affectedRows == 1){
            Success(req, res, 200, "El servicio ha sido eliminado")
        }else{
            Error(req, res,400, "No se pudo eliminar el servicio")
        }
    } catch (error) {
        Error(req, res, 400, error)
    }

}


export { mostrarTodosServicios, eliminarServicio, crearServicio};
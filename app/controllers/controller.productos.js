/**
 * Controladores de los productos
 * @module Controladores_productos
 */

import { db } from "../config/.db.mysql"
import { Success, Error } from "../message/msj"

/**
 * Esta funcion sirve para mostrar todos los productos
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @returns 
 */
const mostrarTodosProductos = async(req, res) => {
    try {
        const respuesta = await db.query(`CALL SP_MOSTRAR_PRODUCTOS()`)

        Success(req, res, 200, respuesta[0][0])

    } catch (error) {
        Error(req, res, 400, error)
    }
}
/**
 * Esta funcion sirve para mostrar un producto
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @returns 
 */
const mostrarUnProducto = async(req, res) => {
    const id = req.params['id'];

    try {
        const respuesta = await db.query(`CALL SP_MOSTRAR_UN_PRODUCTO('${id}')`)

        Success(req, res, 200, respuesta[0][0])

    } catch (error) {
        Error(req, res, 400, error)
    }
}
/**
 * Esta funcion sirve para crear todos los productos
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @returns 
 */
const crearProductos = async(req, res) => {
    const {nombre, descripcion, stock} = req.body
    try {
        const respuesta = await db.query(`CALL SP_INSERTAR_PRODUCTO('${nombre}','${descripcion}','${stock}')`);

        if (respuesta[0].affectedRows == 1) {
            Success(req, res, 200, "Producto creado correctamente")
        }else{
            Error(req, res, 400, "No se pudo crear el producto")
        }
    } catch (error) {
        Error(req, res, 400, error)
    }
}
/**
 * Esta funcion sirve para eliminar todos los productos
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @returns 
 */
const eliminarProductos = async(req, res) => {
    const {id} = req.body
    try {
        const respuesta = await db.query(`CALL SP_ELIMINAR_PRODUCTO('${id}')`);

        if (respuesta[0].affectedRows == 1) {
            Success(req, res, 200, "Producto creado correctamente")
        }else{
            Error(req, res, 400, "No se pudo crear el producto")
        }
    } catch (error) {
        Error(req, res, 400, error)
    }
}




export { mostrarTodosProductos, crearProductos, eliminarProductos, mostrarUnProducto };
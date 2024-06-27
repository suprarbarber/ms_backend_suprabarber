/**
 * Controladores de los clientes
 * @module Controladores_clientes
 */

import { db } from "../config/.db.mysql"
import { Error, Success } from "../message/msj"
import bcrypt from "bcrypt";

/**
 * Esta funcion sirve para mostrar todos los clientes
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
const mostrarTodosClientes = async(req, res) => {
    try {
        //se llama la base de datos con el procedimiento almacenado
        const respuesta = await db.query(`CALL SP_VISUALIZAR_TODOS_CLIENTES()`)

        //se envia la respuesta de la solicitud
        Success(req, res, 200, respuesta[0][0])
    } catch (error) {
        //mensaje json de error
        Error(req, res, 400, "Huvo un error intentalo más tarde")
    }
}

/**
 * Esta funcion sirve para mostrar un cliente
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
const mostrarUnCliente = async(req,res) => {
    //se trae el dato de la url
    let id = req.params['id'];

    try {
        //se llama la base de datos con el procedimiento almacenado mas el dato
        const respuesta = await db.query(`CALL SP_VISUALIZAR_UN_CLIENTE('${id}')`)

        //se envia la respuesta de la solicitud
        Success(req, res, 200, respuesta[0][0])
    } catch (error) {
        //mensaje json de error
        Error(req, res, 400, "Huvo un error intentalo más tarde")
    }
}

/**
 * Esta funcion sirve para actualizar el telefono de un cliente
 * @param {object} req captura es peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
const actualizarTelefono = async(req, res) => {
    //se traen los datos del body
    const {id, telefono} = req.body

    try {
        //se llamala base de datos con el procedimiento almacenado
        const respuesta = await db.query(`CALL SP_ACTUALIZAR_TELEFONO_CLIENTE('${id}','${telefono}')`);

        // condicional de si trajo una respuesta 
        if(respuesta[0].affectedRows == 1){
            Success(req, res, 200, "Su telefono ha sido actualizado")
        }else{
            Error(req, res, 400, "No se pudo actualizar el dato")
        }
    } catch (error) {
        // mensaje error vacio 
        Error(req, res, 400, error)
    }
}

/**
 * Esta funcion sirve para actualizar el nombre de un cliente
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
const actualizarNombre = async(req, res) => {
    //se traen los datos del body
    const {id, nombre} = req.body

    try {
        //se llama la base de datos con el p.a y se mandan los datos
        const respuesta = await db.query(`CALL SP_ACTUALIZAR_NOMBRE_CLIENTE('${id}','${nombre}')`);

        // condicional de la respuesta que traiga 
        if(respuesta[0].affectedRows == 1){
            Success(req, res, 200, "Su nombre ha sido actualizado")
        }else{
            Error(req, res,400, "No se pudo actualizar el dato")
        }
    } catch (error) {
        Error(req, res, 400, error)
    }
}

/**
 * Esta funcion sirve para actualizar la contrasena de un cliente
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
const actualizarContra = async(req, res) => {
    //se traen los datos del body
    const {id, contra} = req.body
    const clavesincifrar = contra


    try {
        const hash = await bcrypt.hash(clavesincifrar, 2)
        // se encipto la contrasena }
        const claveCifrada = hash;

        //se llama la base de datos con el p.a y se mandan los datos
        const respuesta = await db.query(`CALL SP_ACTUALIZAR_CONTRASENA_CLIENTE('${id}','${claveCifrada}')`);

        // condicional de la respuesta que traiga 
        if(respuesta[0].affectedRows == 1){
            Success(req, res, 200, "Su contraseña ha sido actualizado")
        }else{
            Error(req, res,400, "No se pudo actualizar el dato")
        }
    } catch (error) {
        Error(req, res, 400, error)
    }
}

/**
 * Esta funcion sirve para actualizar el correo de un cliente
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
const actualizarCorreo = async(req, res) => {
    //se traen los datos del body
    const {id, correo} = req.body

    try {
        //se llama la base de datos con el p.a y se mandan los datos
        const respuesta = await db.query(`CALL SP_ACTUALIZAR_CORREO_CLIENTE( '${id}' , '${correo}' )`);

        // condicional de la respuesta que traiga 
        if(respuesta[0].affectedRows == 1){
            Success(req, res, 200, "Su correo ha sido actualizado")
        }else{
            Error(req, res,400, "No se pudo actualizar el dato")
        }
    } catch (error) {
        Error(req, res, 400, error)
    }
}

/**
 * Esta funcion sirve para eliminar la cuenta de un cliente
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
const eliminarCuenta = async(req, res) => {
//se traen los datos del body
const {id} = req.body

try {
    //se llama la base de datos con el p.a y se mandan los datos
    const respuesta = await db.query(`CALL SP_ELIMINAR_USUARIOS( '${id}')`);

    // condicional de la respuesta que traiga 
    if(respuesta[0].affectedRows == 1){
        Success(req, res, 200, "Su cuenta ha sido eliminada")
    }else{
        Error(req, res,400, "No se pudo eliminar su cuenta")
    }
} catch (error) {
    Error(req, res, 400, error)
}
}

/**
 * Esta funcion sirve para verificar si el token es valido
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
const validarToken = (req, res) => {
    Success(req, res, 200, "El token es valido")
}

export {mostrarTodosClientes, 
    mostrarUnCliente, 
    actualizarTelefono, 
    actualizarNombre, 
    actualizarContra, 
    actualizarCorreo,
    eliminarCuenta,
    validarToken
}
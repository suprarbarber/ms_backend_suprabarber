/**
 * Controladores de los clientes
 * @module Controladores_clientes
 */

import { db } from "../config/db.mysql"
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
        const respuesta = await db.query(`CALL SP_MOSTRAR_TODOS_CLIENTES()`)

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
        const respuesta = await db.query(`CALL SP_MOSTRAR_UN_CLIENTE('${id}')`)

        //se envia la respuesta de la solicitud
        Success(req, res, 200, respuesta[0][0])
    } catch (error) {
        //mensaje json de error
        Error(req, res, 400, "Huvo un error intentalo más tarde")
    }
}


/**
 * Esta funcion sirve para actualizar los datos de un cliente
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
const actualizarDatos = async (req, res) => {
    
    // Se traen los datos del body
    const {  nombre, correo, telefono, contrasena} = req.body;
    const id  = req.params['id']; // Asegúrate de obtener el ID de los parámetros de la ruta

    try {
        if (nombre) {
            const respuesta = await db.query(`CALL SP_ACTUALIZAR_NOMBRE_CLIENTE('${id}', '${nombre}')`);
            
            if (respuesta[0].affectedRows == 1) {
                return Success(req, res, 200, "Su nombre ha sido actualizado");
            } else {
                return Error(req, res, 400, "No se pudo actualizar el nombre");
            }
        }

        if (correo) {

            const respuesta = await db.query(`CALL SP_ACTUALIZAR_CORREO_CLIENTE('${id}', '${correo}')`);
            
            if (respuesta[0].affectedRows == 1) {
                return Success(req, res, 200, "Su correo ha sido actualizado");
            } else {
                return Error(req, res, 400, "No se pudo actualizar el correo");
            }
        }

        if (telefono) {
            const respuesta = await db.query(`CALL SP_ACTUALIZAR_TELEFONO_CLIENTE('${id}', '${telefono}')`);

            if (respuesta[0].affectedRows == 1) {
                return Success(req, res, 200, "Su telefono ha sido actualizado");
            } else {
                return Error(req, res, 400, "No se pudo actualizar el telefono");
            }
        }
        
        if(contrasena){
            const repp = await db.query(`CALL SP_VERIFICAR_CUENTA_CLIENTE('${id}')`)

            if(repp[0][0] != 0){
                // se comparan las contraseñas 
                const compare = await bcrypt.compare(contrasena, repp[0][0][0].contrasena)

                // mensaje de clave errada 
                if(!compare){
                    return Error(req, res,400, "Clave errada")
                }
        
                const respuesta = await db.query(`CALL SP_DESACTIVAR_CUENTA_CLIENTE('${id}')`);

                if (respuesta[0].affectedRows == 1) {
                    return Success(req, res, 200, "Su cuenta ha sido desactivada");
                } else {
                    return Error(req, res, 400, "No se pudo desactivar su cuenta");
                }
            }
    
        }


    } catch (error) {
        // Manejo general de errores
        Error(req, res, 500, error.message);
    }
};


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
    actualizarDatos,
    validarToken
}
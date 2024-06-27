/**
 * Controladores de los apartados del home
 * @module Controladores_home
 */

import { db } from "../config/.db.mysql"
import { Success, Error } from "../message/msj"
import bcrypt, { compare } from "bcrypt";
import jwt from "jsonwebtoken";
import { config } from "dotenv";
config()

/**
 * Esta funcion sirve para registrar los usuarios
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */

 const registro = async(req,res) => {
    const {id, nombre, telefono, correo, roll} = req.body
    const { contrasena } = req.body
    const clave = contrasena;
    
    try {

        // verificacion de la cuenta 
        const repp = await db.query(`CALL SP_VERIFICAR_EXISTENCIA_DE_CUENTA('${id}', '${correo}')`);

        if(repp[0][0] != 0){
            Error(req, res, 401, "El usuario ya existe")
            return;
        }

        // encriptacion de la clave 
        const hash = await bcrypt.hash(clave, 2)
        const claveCifrada = hash;

        const respuesta = await db.query(`CALL SP_REGISTRAR_USER('${id}', '${nombre}',
        '${telefono}', '${correo}', '${claveCifrada}', '${roll}')`);

        console.log(respuesta[0]);

        if(respuesta[0].affectedRows == 1){

            Success(req, res, 200, "Se ha registrado correctamente")
            
        }else{
            Error(req, res, 400, "Error, intentalo de nuevo más tarde")
        }

    } catch (error) {
        Error(req, res, 401, error)
    }
}

/**
 * Esta funcion sirve para loguear los usuarios
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 */
        
 const loguear = async(req, res) => {
    const { correo, contrasena} = req.body;
    
    try{

        const repp = await db.query(`CALL SP_LOGUEAR_ADMIN('${correo}')`)

        if(repp[0][0] != 0){
            // se comparan las contraseñas 
            const compare = await bcrypt.compare(contrasena, repp[0][0][0].contrasena)

            // mensaje de clave errada 
            if(!compare){
                Error(req, res,400, "Clave errada")
            }
    
            Success(req, res, 200, "Acceso no perimitido");
            return;
        }

        const respuesta = await db.query(`CALL SP_LOGUEAR_USUARIO('${correo}')`)
        console.log(respuesta[0]);
        //para decir si el usuario no existe
        if (respuesta[0][0] == 0){
            Error(req, res, 400, "El usuario no existe todavia ")
            return;
        }
            
        //para compara las dos claves encriptadas
        const match = await bcrypt.compare(contrasena, respuesta[0][0][0].contrasena)
            
        if(!match){
            Error(req, res, 401, "Contraseña errada")
            return;
        }
        console.log(3);
        
        //token
        let pyload = {
            "correo" : correo
        };
        
        let token = jwt.sign (
            pyload,
            process.env.TOKEN_PRIVATEKEY,
            {
                expiresIn : process.env.TOKEN_EXPIRES_IN
            }
        )
        let id = respuesta[0][0][0].identificacion;

        Success(req, res, 200, {token , id});
        return;
                
    }catch(err){
        Error(req, res, 500, JSON.stringify({message : "Error en el servidor, por favor intentar más tarde"}));
    }
}

export {registro, loguear}
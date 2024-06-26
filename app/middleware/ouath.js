import jwt from "jsonwebtoken";
import { config } from "dotenv";
import { Error } from "../message/msj.js";
config();


/**
 * Esta funcion sirve para validar si el token es correcto
 * @param {object} req captura es la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @param {object} next da la instrucion de seguir con la siguiente funcion
 */
const verifyToken = async(req, res, next) => {

    const token = req.headers["x-access-token"];

    try {
        const validar =  jwt.verify(token, process.env.TOKEN_PRIVATEKEY);
        next();
    } catch (err) {
        Error(req, res, 401, err)
        
    }
}

export { verifyToken };
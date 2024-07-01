import { Error } from "../message/msj";
import { db } from "../config/db.mysql";

/**
 * Esta funcion sirve para validar si la cuenta ya existe
 * @param {object} req captura es la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @param {object} next da la instrucion de seguir con la siguiente funcion
 */
const validarCuenta = async(req, res, next) => {
    const {id, correo} = req.body;

    try {
        const repp = await db.query(`CALL SP_VERIFICAR_EXISTENCIA_DE_CUENTA('${id}', '${correo}')`);

        if(!repp[0][0] == 0){
            Error(req, res, 401, "El usuario ya existe")
            console.log(repp[0][0]);
        }

    } catch (error) {
        Error(req, res, 400, error)
    }
}
export { validarCuenta };
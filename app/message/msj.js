/**
 * Esta funcion sirve para mostrar el mensaje en json de error
 * @param {object} req captura es la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @returns 
 */
const Error = (req, res, status = 400, msj = "") => {
    res.status(status).json({
        error : true,
        status : status,
        body : msj
    })
} 

/**
 * Esta funcion sirve para mostrar el mensaje en json de exito
 * @param {object} req captura es la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @returns 
 */
const Success = (req, res, status = 200, msj = "") => {
    res.status(status).json({
        error : false,
        status : status,
        body : msj
    })
} 

const campo = "Backend ";
const msjindex = "ejecutandose en http://localhost:";

export {Error, Success, campo, msjindex}
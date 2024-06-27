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

/**
 * Mensaje donde va el campo
 * @type {string}
 */
const campo = "Backend ";

/**
 * Mensaje del index.js
 * @type {string}
 */
const msjindex = "ejecutandose en http://localhost:";

export {Error, Success, campo, msjindex}
import { db } from "../config/.db.mysql"
import { Success, Error } from "../message/msj"



/**
 * Esta funcion sirve para crear una tarjeta
 * @param {object} req captura la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @returns 
 */
const crearTarjeta = async(req, res) => {
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
 * Esta funcion sirve para eliminar una tarjeta
 * @param {object} req captura es la peticio en HTML
 * @param {object} res envia peticiones en HTML
 * @returns 
 */
const eliminarTarjeta = async(req, res) => {
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




export { crearProductos, eliminarProductos};
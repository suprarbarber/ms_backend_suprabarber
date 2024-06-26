import { Router } from "express";
import { actualizarContra, 
    actualizarCorreo, 
    actualizarNombre, 
    actualizarTelefono, 
    eliminarCuenta, 
    mostrarTodosClientes, 
    mostrarUnCliente, 
    validarToken} from "../controllers/controller.cliente";
import { verifyToken } from "../middleware/ouath";

/**
 * Esta es la ruta de los clientes
 * @type {object}
 */
const rutaCliente = Router();

rutaCliente.get("/cliente", mostrarTodosClientes);

rutaCliente.get("/cliente/:id", mostrarUnCliente);


// para atualizar el telefono 
rutaCliente.put("/cliente", actualizarTelefono);
// para atualizar el nombre
rutaCliente.put("/cliente", actualizarNombre);
// para atualizar la contasena
rutaCliente.put("/cliente", actualizarContra);
// para atualizar el correo
rutaCliente.put("/cliente", actualizarCorreo);
// para eliminar la cuenta 
rutaCliente.put("/cliente", eliminarCuenta)

// para validar el token 
rutaCliente.post("/oauth", verifyToken ,validarToken)

export default rutaCliente;
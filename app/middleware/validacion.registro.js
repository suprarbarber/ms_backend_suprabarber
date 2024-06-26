import { check, validationResult } from "express-validator";
import { Error } from "../message/msj"

/**
 * Esta es una funcion que sirve para validar los campos
 * @returns 
 */
const validacionDatos = () => {

    return [
        
        // validacion del id 
        check('id').isNumeric().trim().notEmpty().withMessage('El campo identificacion está vacio'),
        // validacion del nombre 
        check('nombre').notEmpty().withMessage('El campo nombre está vacio'),
        //validacion del telefono
        check('telefono').trim().notEmpty().withMessage('el campo telefono está vacio'),
        // valiadacion del correo 
        check('correo').isEmail().withMessage('Correo invalido'),
        //validacion de la contaseña
        check('contrasena').isLength({ min : 5}).withMessage('Debe tener minimo 5 caracteres'),
        //validacion del roll
        check('roll').notEmpty(),


        (req, res, next) => {
            
            const errors = validationResult(req);

            if(!errors.isEmpty()){
                const checkerror = errors.array().map(error => error.msg)

                Error(req, res, 400, checkerror);
                return;
            }
            next();

        }
    ]


}

export { validacionDatos };

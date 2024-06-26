import swaggerAutogen from 'swagger-autogen';
import { config } from 'dotenv';
config()

let port = process.env.PORT;

const doc = {
  info: {
    title: 'SUPRABARBER',
    description: 'aplicacion de reserva de citas de una barbería'
  },
  host: 'localhost' + port + "/api"
};

const outputFile = './swagger-output.json';
const routes = ['../routes/index.js', '../routes/ruta.cliente.js'];

/* NOTE: If you are using the express Router, you must pass in the 'routes' only the
root file where the route starts, such as index.js, app.js, routes.js, etc ... */ 

swaggerAutogen()(outputFile, routes, doc);
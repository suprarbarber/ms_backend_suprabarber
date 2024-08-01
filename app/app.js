import { config } from "dotenv";
config();
import express from "express";
import ruta from "./routes";
import morgan from "morgan";
import cors from "cors";

/**
 * Esta es la ruta de mi proyecto
 * @type {object}
 */
const app = express();

//middleware
app.use(cors());
app.use(morgan('dev'))
app.use(express.json());
app.use(express.urlencoded({extended : true}))

//puerto
app.set("port", process.env.PORT || 3000)

//rutas
app.use("/api", ruta);



export default app;
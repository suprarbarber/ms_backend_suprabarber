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

app.use(cors({
    origin: 'https://automatic-enigma-xqqvrxv4w67fv74w-7000.app.github.dev/api/login', // Cambia esto por la URL de tu frontend
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization']
}));

app.use(morgan('dev'))
app.use(express.json());
app.use(express.urlencoded({extended : true}))

//puerto
app.set("port", process.env.PORT || 3000)

//rutas
app.use("/api", ruta);


export default app;
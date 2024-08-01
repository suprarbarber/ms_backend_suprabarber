import app from "./app";
import { campo, msjindex } from "./message/msj";

app.listen( app.get("port"), '0.0.0.0', () => {
    console.log(campo + msjindex + app.get("port"));
})


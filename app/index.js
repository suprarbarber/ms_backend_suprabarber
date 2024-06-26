import app from "./app";
import { campo, msjindex } from "./message/msj";

app.listen(app.get("port"), () => {
    console.log(campo + msjindex + app.get("port"));
})
import config from "./config/config.ts";
import app from "./index.ts";

app.listen(config.port, () => {
    console.log(`Server is running on port ${config.port}`);
});
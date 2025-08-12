import { Pool } from "pg";
import { DB_CONFIGS } from "../shared/constant.ts";


const pool = new Pool({
    user: DB_CONFIGS.user,
    host: DB_CONFIGS.host,
    database: DB_CONFIGS.database,
    password: DB_CONFIGS.password,
    port: DB_CONFIGS.port,
});

export default pool;
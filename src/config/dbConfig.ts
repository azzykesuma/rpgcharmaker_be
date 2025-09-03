import { Pool } from "pg";
import { DB_CONFIGS } from "../shared/constant";

const pool = new Pool({
  user: DB_CONFIGS.user,
  host: DB_CONFIGS.host,
  database: DB_CONFIGS.database,
  password: DB_CONFIGS.password,
  port: DB_CONFIGS.port,
});

console.log("Database Configurations:", {
  user: DB_CONFIGS.user,
  host: DB_CONFIGS.host,
  database: DB_CONFIGS.database,
  port: DB_CONFIGS.port,
});

export default pool;

import dotenv from "dotenv";

dotenv.config();

export const JWT_SECRET_KEY = process.env.JWT_SECRET_KEY;
export const REFRESH_SECRET_KEY = process.env.REFRESH_SECRET_KEY;

// database envs
export const DB_CONFIGS = {
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: Number(process.env.DB_PORT),
}

// cloud
export const CLOUD_STORAGE_CONFIGS = {
    APIKEY: process.env.CLOUDINARY_API_KEY,
    SECRET: process.env.CLOUDINARY_API_SECRET,
    CLOUD_NAME: process.env.CLOUDINARY_CLOUD_NAME,
}
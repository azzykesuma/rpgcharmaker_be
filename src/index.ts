import express from "express";
import cors from "cors";
import authRouter from "./feature/auth/routes/authRoutes.ts";

const app = express();
app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: true }));

app.use("/api/auth", authRouter);

export default app;
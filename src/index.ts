import express from "express";
import cors from "cors";
import authRouter from "./feature/auth/routes/authRoutes.ts";
import elementTypesRouter from "./feature/elementTypes/routes/elementTypesRoutes.ts";

const app = express();
app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: true }));

app.use("/api/auth", authRouter);
app.use("/api/element-types", elementTypesRouter);

export default app;
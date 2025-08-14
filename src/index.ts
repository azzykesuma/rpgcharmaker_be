import express from "express";
import cors from "cors";
import authRouter from "./feature/auth/routes/authRoutes.ts";
import elementTypesRouter from "./feature/elementTypes/routes/elementTypesRoutes.ts";
import weaponTypesRouter from "./feature/weaponTypes/routes/weaponTypesRouter.ts";
import weaponRouter from "./feature/weapon/route/weaponRoutes.ts";
import resistanceRouter from "./feature/resistance/routes/resistanceRoutes.ts";
import weaknessRouter from "./feature/weakness/routes/weaknessRouter.ts";
import enemyRouter from "./feature/enemy/routes/enemyRoutes.ts";

const app = express();
app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: true }));

app.use("/api/auth", authRouter);
app.use("/api/element-types", elementTypesRouter);
app.use("/api/weapon-types", weaponTypesRouter);    
app.use("/api/weapon", weaponRouter);
app.use("/api/resistance", resistanceRouter);
app.use("/api/weakness", weaknessRouter);
app.use("/api/enemy", enemyRouter);

export default app;
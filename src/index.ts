import express from "express";
import cors from "cors";
import authRouter from "./feature/auth/routes/authRoutes";
import elementTypesRouter from "./feature/elementTypes/routes/elementTypesRoutes";
import weaponTypesRouter from "./feature/weaponTypes/routes/weaponTypesRouter";
import weaponRouter from "./feature/weapon/route/weaponRoutes";
import resistanceRouter from "./feature/resistance/routes/resistanceRoutes";
import weaknessRouter from "./feature/weakness/routes/weaknessRouter";
import enemyRouter from "./feature/enemy/routes/enemyRoutes";
import masterClassRouter from "./feature/master_class/routes/masterClassRoutes";

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
app.use("/api/master-class", masterClassRouter);

export default app;

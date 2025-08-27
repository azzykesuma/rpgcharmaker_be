import express, { NextFunction, Request, Response } from "express";
import cors from "cors";
import authRouter from "./feature/auth/routes/authRoutes";
import elementTypesRouter from "./feature/elementTypes/routes/elementTypesRoutes";
import weaponTypesRouter from "./feature/weaponTypes/routes/weaponTypesRouter";
import weaponRouter from "./feature/weapon/route/weaponRoutes";
import resistanceRouter from "./feature/resistance/routes/resistanceRoutes";
import weaknessRouter from "./feature/weakness/routes/weaknessRouter";
import enemyRouter from "./feature/enemy/routes/enemyRoutes";
import masterClassRouter from "./feature/master_class/routes/masterClassRoutes";
import { HttpError } from "./shared/utils/httpError";
import logger from "./shared/utils/logger";
import playerRouter from "./feature/player/routes/playerRoutes";

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
app.use("/api/player", playerRouter);

app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
  logger.error(err.stack);

  // Default to a 500 status code and a generic message
  let statusCode = 500;
  let message = "Internal Server Error";

  // If the error is a custom HttpError, use its status code and message
  if (err instanceof HttpError) {
    statusCode = err.statusCode || 500;
    message = err.message;
  }

  // Send the final response to the client
  res.status(statusCode).json({
    error: message,
    statusCode,
  });
});

export default app;

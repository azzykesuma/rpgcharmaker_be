import express from "express";
import "reflect-metadata";

import { authController } from "../../../shared/dependencyContainer/container";
import jwtAuthMiddleware from "../../../shared/middleware/JwtAuthMiddleware";

const authRouter = express.Router();

authRouter.post("/login", authController.login.bind(authController));
authRouter.post("/register", authController.register.bind(authController));
authRouter.post(
  "/logout",
  jwtAuthMiddleware,
  authController.logout.bind(authController),
);
authRouter.post(
  "/refresh-token",
  jwtAuthMiddleware,
  authController.refreshToken.bind(authController),
);

export default authRouter;

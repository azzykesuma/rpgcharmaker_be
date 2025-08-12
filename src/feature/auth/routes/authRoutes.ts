import express from "express";

import { AuthService } from "../application/AuthService.ts";
import pool from "../../../config/dbConfig.ts";
import { SessionRepository } from "../infrastructure/repositories/SessionRepository.ts";
import { RefreshTokenRepository } from "../infrastructure/repositories/RefreshTokenRepository.ts";
import AuthController from "../interface/auth.controller.ts";
import { AuthRepository } from "../infrastructure/repositories/AuthRepository.ts";
import jwtAuthMiddleware from "../../../shared/middleware/JwtAuthMiddleware.ts";

const authRouter = express.Router();
const authRepository = new AuthRepository(pool);
const sessionRepository = new SessionRepository(pool);
const refreshTokenRepository = new RefreshTokenRepository(pool);
const authService = new AuthService(
  authRepository,
  sessionRepository,
  refreshTokenRepository
);
const authController = new AuthController(authService);

authRouter.post("/login", authController.login.bind(authController));
authRouter.post("/register", authController.register.bind(authController));
authRouter.post(
  "/logout",
  jwtAuthMiddleware,
  authController.logout.bind(authController)
);
authRouter.post(
  "/refresh-token",
  jwtAuthMiddleware,
  authController.refreshToken.bind(authController)
);

export default authRouter;

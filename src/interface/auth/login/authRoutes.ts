import express from "express";
import AuthController from "./auth.controller.ts";
import { AuthService } from "../../../application/auth/AuthService.ts";
import { AuthRepository } from "../../../infrastructure/postgres/repositories/AuthRepository.ts";
import pool from "../../../config/dbConfig.ts";
import { SessionRepository } from "../../../infrastructure/postgres/repositories/SessionRepository.ts";
import { RefreshTokenRepository } from "../../../infrastructure/postgres/repositories/RefreshTokenRepository.ts";
import jwtAuthMiddleware from "../../middleware/JwtAuthMiddleware.ts";


const authRouter = express.Router();
const authRepository = new AuthRepository(pool);
const sessionRepository = new SessionRepository(pool);
const refreshTokenRepository = new RefreshTokenRepository(pool);
const authService = new AuthService(authRepository, sessionRepository, refreshTokenRepository);
const authController = new AuthController(authService);

authRouter.post("/login", authController.login.bind(authController));
authRouter.post("/register", authController.register.bind(authController));
authRouter.post("/logout", jwtAuthMiddleware, authController.logout.bind(authController));
authRouter.post("/refresh-token", authController.refreshToken.bind(authController));

export default authRouter;
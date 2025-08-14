import { AuthRepository } from "../../feature/auth/infrastructure/repositories/AuthRepository.ts";
import { SessionRepository } from "../../feature/auth/infrastructure/repositories/SessionRepository.ts";
import { RefreshTokenRepository } from "../../feature/auth/infrastructure/repositories/RefreshTokenRepository.ts";
import pool from "../../config/dbConfig.ts";
import { AuthService } from "../../feature/auth/application/AuthService.ts";
import AuthController from "../../feature/auth/interface/auth.controller.ts";

// auth dependencies
const authRepository = new AuthRepository(pool);
const sessionRepository = new SessionRepository(pool);
const refreshTokenRepository = new RefreshTokenRepository(pool);

const authService = new AuthService(authRepository, sessionRepository, refreshTokenRepository);
const authController = new AuthController(authService);

// todo : implement other dependencies

export {
    authController,
    authService,
    authRepository,
    sessionRepository,
    refreshTokenRepository
};
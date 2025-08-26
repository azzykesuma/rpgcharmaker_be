import { AuthRepository } from "../../feature/auth/infrastructure/repositories/AuthRepository";
import { SessionRepository } from "../../feature/auth/infrastructure/repositories/SessionRepository";
import { RefreshTokenRepository } from "../../feature/auth/infrastructure/repositories/RefreshTokenRepository";
import pool from "../../config/dbConfig";
import { AuthService } from "../../feature/auth/application/AuthService";
import AuthController from "../../feature/auth/interface/auth.controller";

// auth dependencies
const authRepository = new AuthRepository(pool);
const sessionRepository = new SessionRepository(pool);
const refreshTokenRepository = new RefreshTokenRepository(pool);

const authService = new AuthService(
  authRepository,
  sessionRepository,
  refreshTokenRepository,
);
const authController = new AuthController(authService);

// todo : implement other dependencies

export {
  authController,
  authService,
  authRepository,
  sessionRepository,
  refreshTokenRepository,
};

import type { TCreateUserPayload, UserRepository } from "../../domain/User.ts";
import jwt from "jsonwebtoken";
import { compareHashPassword } from "../../interface/shared/utils/compareHashPassword.ts";
import { JWT_SECRET_KEY, REFRESH_SECRET_KEY } from "../../interface/shared/constant.ts";
import logger from "../../interface/shared/utils/logger.ts";
import bcrypt from "bcrypt";
import { HttpError } from "../../interface/shared/utils/httpError.ts";
import { SessionRepository } from "../../infrastructure/postgres/repositories/SessionRepository.ts";
import { RefreshTokenRepository } from "../../infrastructure/postgres/repositories/RefreshTokenRepository.ts";
export class AuthService {
    private readonly userRepository: UserRepository;
    private readonly sessionRepository: SessionRepository;
    private readonly refreshTokenRepository: RefreshTokenRepository;

    constructor(userRepository: UserRepository, sessionRepository: SessionRepository, refreshTokenRepository: RefreshTokenRepository) {
        this.userRepository = userRepository;
        this.sessionRepository = sessionRepository;
        this.refreshTokenRepository = refreshTokenRepository;
    }

    async login(username: string, password: string, userAgent: string): Promise<{ accessToken: string, refreshToken: string }> {

        logger.info(`[AuthService] Attempting login for username: ${username}`);

        const user = await this.userRepository.findByUsername(username);
        if (!user) {
            logger.warn(`[AuthService] Login failed: User not found for username: ${username}`);
            throw new Error("User not found");
        }
        logger.info(`[AuthService] User found for username: ${username}, verifying password...`);

        const isPasswordValid = await compareHashPassword(password, user.player_password);
        if (!isPasswordValid) {
            logger.warn(`Login failed: Invalid credentials for username: ${username}`);
            throw new Error("Invalid credentials");
        }
        logger.info(`Password valid for username: ${username}`);

        if(!JWT_SECRET_KEY || !REFRESH_SECRET_KEY) {
            logger.error("JWT secret key or refresh secret key is not defined");
            throw new Error("JWT secret key is not defined");
        }

        logger.info(`Generating access and refresh tokens for user id: ${user.user_id}`);

        const token = jwt.sign({ id: user.user_id, username: user.player_name }, JWT_SECRET_KEY, { expiresIn: "15min" });
        const refreshToken = jwt.sign({ id: user.user_id, username: user.player_name }, REFRESH_SECRET_KEY, { expiresIn: "30d" });

        await this.sessionRepository.createSession(user.user_id, token, userAgent);
        await this.refreshTokenRepository.createRefreshToken(user.user_id, refreshToken);

        return {
            accessToken: token,
            refreshToken: refreshToken,
        }
    }

    async logout(token: string) {
        const tokenData = await this.refreshTokenRepository.findRefreshToken(token);
        console.log(tokenData);
        if (!tokenData) {
            throw new HttpError("Invalid refresh token or session not found", 401);
        }
        await this.refreshTokenRepository.deleteRefreshToken(tokenData.token);
        await this.sessionRepository.updateLogoutTime(tokenData.user_id);
        return {
            message: "Logged out successfully",
        }
    }

    async refreshToken(token: string) {
        const tokenData = await this.refreshTokenRepository.findRefreshToken(token);
        if (!tokenData) {
            throw new HttpError("Invalid refresh token", 401);
        }
        if (!REFRESH_SECRET_KEY || !JWT_SECRET_KEY) {
            throw new HttpError("Refresh secret key is not defined", 500);
        }
        const decoded = jwt.verify(token, REFRESH_SECRET_KEY) as { id: string, username: string };
        const newAccessToken = jwt.sign({ id: decoded.id, username: decoded.username }, JWT_SECRET_KEY, { expiresIn: '15m' });
        
        return {
            accessToken: newAccessToken,
            refreshToken: token,
        }
    }

    async register(payload: TCreateUserPayload) {
        const { player_name, player_password } = payload;
        const saltRounds = 10;
        const hashedPassword = await bcrypt.hash(player_password, saltRounds);
        payload = { player_name, player_password: hashedPassword };

        // check if user already exists
        const existingUser = await this.userRepository.findByUsername(player_name);
        if (existingUser) {
            throw new HttpError("User already exists", 400);
        }

        const user = await this.userRepository.create(payload);
        return user;
    }
}

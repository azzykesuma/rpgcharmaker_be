import type { UserRepository } from "../../domain/User.ts";
import jwt from "jsonwebtoken";
import { compareHashPassword } from "../../shared/lib/compareHashPassword.ts";
import { JWT_SECRET_KEY, REFRESH_SECRET_KEY } from "../../shared/constant/constant.ts";
import logger from "../../shared/lib/logger.ts";

export class AuthService {
    private readonly userRepository: UserRepository;

    constructor(userRepository: UserRepository) {
        this.userRepository = userRepository;
    }

    async login(username: string, password: string): Promise<{ accessToken: string, refreshToken: string }> {

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

        return {
            accessToken: token,
            refreshToken: refreshToken,
        }
    }
}

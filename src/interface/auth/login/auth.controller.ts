import type { Request, Response } from "express";

import logger from "../../../shared/lib/logger.ts";
import { handleResponse } from "../../../shared/lib/responseHandler.ts";
import { AuthService } from "../../../application/auth/AuthService.ts";


class AuthController {
    private readonly authService: AuthService;

    constructor(authService: AuthService) {
        this.authService = authService;
    }

    async login(req: Request, res: Response) {
        const { username, password } = req.body;
        logger.info(`[AuthController] Login request received for username: ${username}`);
        try {
            const { accessToken, refreshToken } = await this.authService.login(username, password);
            handleResponse(res, {
                data: { accessToken, refreshToken },
                statusCode: 200,
            });
        } catch (error: unknown) {
            if(error instanceof Error) {
                logger.error(`[AuthController] ${error.message}`);
                handleResponse(res, {
                    error: error.message || "Internal server error",
                    statusCode: 401, // Use 401 for invalid credentials
                });
            } else {
                logger.error("Unknown error occurred");
                handleResponse(res, {
                    error: "Internal server error",
                    statusCode: 500,
                });
            }
        }
    }
}
export default AuthController;
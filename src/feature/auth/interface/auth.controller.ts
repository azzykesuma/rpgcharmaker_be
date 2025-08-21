import { HttpError } from "../../../shared/utils/httpError.ts";
import logger from "../../../shared/utils/logger.ts";
import { handleResponse } from "../../../shared/utils/responseHandler.ts";
import type { AuthService } from "../application/AuthService.ts";
import type { Request, Response } from "express";

class AuthController {
  private readonly authService: AuthService;

  constructor(authService: AuthService) {
    this.authService = authService;
  }

  async login(req: Request, res: Response) {
    const { username, password } = req.body;
    logger.info(
      `[AuthController] Login request received for username: ${username}`,
    );
    const userAgent = req.headers["user-agent"] || "";
    try {
      const { accessToken, refreshToken } = await this.authService.login(
        username,
        password,
        userAgent,
      );
      handleResponse(res, {
        data: { accessToken, refreshToken },
        statusCode: 200,
      });
    } catch (error: unknown) {
      if (error instanceof Error) {
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

  async register(req: Request, res: Response) {
    const { username, password } = req.body;
    logger.info(
      `[AuthController] Register request received for username: ${username}`,
    );
    try {
      await this.authService.register({
        player_name: username,
        player_password: password,
      });
      handleResponse(res, {
        message: "User registered successfully",
        statusCode: 201,
      });
    } catch (error: unknown) {
      if (error instanceof HttpError) {
        logger.error(`[AuthController] ${error.message}`);
        handleResponse(res, {
          error: error.message || "Internal server error",
          statusCode: error.statusCode,
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

  async logout(req: Request, res: Response) {
    const { refreshToken } = req.body;
    logger.info(`[AuthController] Logout request received`);
    try {
      await this.authService.logout(refreshToken);
      handleResponse(res, {
        message: "Logged out successfully",
        statusCode: 200,
      });
    } catch (error: unknown) {
      if (error instanceof HttpError) {
        logger.error(`[AuthController] ${error.message}`);
        handleResponse(res, {
          error: error.message || "Internal server error",
          statusCode: error.statusCode,
        });
      }
    }
  }

  async refreshToken(req: Request, res: Response) {
    const { refreshToken } = req.body;
    logger.info(
      `[AuthController] Refresh token request received for refresh token: ${refreshToken}`,
    );
    try {
      const { accessToken, refreshToken: newRefreshToken } =
        await this.authService.refreshToken(refreshToken);
      handleResponse(res, {
        data: { accessToken, refreshToken: newRefreshToken },
        statusCode: 200,
      });
    } catch (error: unknown) {
      if (error instanceof HttpError) {
        logger.error(`[AuthController] ${error.message}`);
        handleResponse(res, {
          error: error.message || "Internal server error",
          statusCode: error.statusCode,
        });
      }
    }
  }
}
export default AuthController;

import express from "express";
import AuthController from "./login/auth.controller.ts";
import { AuthService } from "../../application/auth/AuthService.ts";
import { AuthRepository } from "../../infrastructure/postgres/repositories/AuthRepository.ts";
import pool from "../../infrastructure/config/dbConfig.ts";

const authRouter = express.Router();
const authController = new AuthController(new AuthService(new AuthRepository(pool)))

authRouter.post("/login", authController.login.bind(authController));

export default authRouter;
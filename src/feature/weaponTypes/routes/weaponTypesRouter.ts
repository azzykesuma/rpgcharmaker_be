import express from "express";
import jwtAuthMiddleware from "../../../shared/middleware/JwtAuthMiddleware.ts";
import { WeaponTypesController } from "../interface/weapon-types.controller.ts";
import { WeaponTypeService } from "../application/WeaponTypeService.ts";
import { WeaponTypesRepository } from "../infrastructure/repositories/WeaponTypes.ts";
import pool from "../../../config/dbConfig.ts";

const weaponTypesRouter = express.Router();

// wiring
const weaponTypesRepository = new WeaponTypesRepository(pool);
const weaponTypesService = new WeaponTypeService(weaponTypesRepository);
const weaponTypesController = new WeaponTypesController(weaponTypesService);


weaponTypesRouter.get("/", jwtAuthMiddleware, (req, res) => {
    weaponTypesController.findAll(req, res);
});

weaponTypesRouter.post("/", jwtAuthMiddleware, (req, res) => {
    weaponTypesController.create(req, res);
});

weaponTypesRouter.delete("/:id", jwtAuthMiddleware, (req, res) => {
    weaponTypesController.delete(req, res);
});

export default weaponTypesRouter;
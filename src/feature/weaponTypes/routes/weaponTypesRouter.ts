import express from "express";
import jwtAuthMiddleware from "../../../shared/middleware/JwtAuthMiddleware";
import { WeaponTypesController } from "../interface/weapon-types.controller";
import { WeaponTypeService } from "../application/WeaponTypeService";
import { WeaponTypesRepository } from "../infrastructure/repositories/WeaponTypes";
import pool from "../../../config/dbConfig";

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
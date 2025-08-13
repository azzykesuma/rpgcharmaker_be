import { Router } from "express";
import jwtAuthMiddleware from "../../../shared/middleware/JwtAuthMiddleware.ts";
import { ResistanceController } from "../interface/resistance.controller.ts";
import { ResistanceRepository } from "../infrastructure/respository/ResistanceRepository.ts";
import pool from "../../../config/dbConfig.ts";
import { ResistanceService } from "../application/resistanceService.ts";

const resistanceRouter = Router();

const resistanceRepository = new ResistanceRepository(pool);
const resistanceService = new ResistanceService(resistanceRepository);
const resistanceController = new ResistanceController(resistanceService);

resistanceRouter.post("/", jwtAuthMiddleware, (req, res) => {
    resistanceController.create(req, res);
});
resistanceRouter.get("/", jwtAuthMiddleware, (req, res) => {
    resistanceController.getResistances(req, res);
});
resistanceRouter.put("/:id", jwtAuthMiddleware, (req, res) => {
    resistanceController.updateResistance(req, res);
});
resistanceRouter.delete("/:id", jwtAuthMiddleware, (req, res) => {
    resistanceController.deleteResistance(req, res);
});

export default resistanceRouter;
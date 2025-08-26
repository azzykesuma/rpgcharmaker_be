import { Router } from "express";
import jwtAuthMiddleware from "../../../shared/middleware/JwtAuthMiddleware";
import { ResistanceController } from "../interface/resistance.controller";
import { ResistanceRepository } from "../infrastructure/respository/ResistanceRepository";
import pool from "../../../config/dbConfig";
import { ResistanceService } from "../application/resistanceService";

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

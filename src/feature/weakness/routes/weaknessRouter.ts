import { Router } from "express";
import { WeaknessController } from "../interface/weakness.controller.ts";
import { WeaknessService } from "../application/weaknessService.ts";
import { WeaknessRepository } from "../infrastructure/respository/WeaknessRepository.ts";
import pool from "../../../config/dbConfig.ts";

const weaknessRouter = Router();
const weaknessRepository = new WeaknessRepository(pool);    
const weaknessService = new WeaknessService(weaknessRepository);
const weaknessController = new WeaknessController(weaknessService);

weaknessRouter.post("/", (req, res) => {
    weaknessController.create(req, res);
});
weaknessRouter.get("/", (req, res) => {
    weaknessController.getWeaknesses(req, res);
});
weaknessRouter.put("/:id", (req, res) => {
    weaknessController.updateWeakness(req, res);
});
weaknessRouter.delete("/:id", (req, res) => {
    weaknessController.deleteWeakness(req, res);
});
export default weaknessRouter;
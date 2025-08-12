import express from "express";
import { ElementTypeRepository } from "../infrastructure/repositories/ElementTypeRepository.ts";
import { ElementTypesController } from "../interface/element-types.controller.ts";
import pool from "../../../config/dbConfig.ts";
import jwtAuthMiddleware from "../../../shared/middleware/JwtAuthMiddleware.ts";
import { ElementTypesService } from "../application/elementTypesService.ts";

const elementTypesRouter = express.Router();
// wiring
const elementTypeRepository = new ElementTypeRepository(pool);
const elementTypesService = new ElementTypesService(elementTypeRepository);
const elementTypesController = new ElementTypesController(elementTypesService);

elementTypesRouter.get("/", jwtAuthMiddleware, (req, res) => {
    elementTypesController.findAll(req, res);
});

elementTypesRouter.post("/", jwtAuthMiddleware, (req, res) => {
    elementTypesController.create(req, res);
});

elementTypesRouter.delete("/:id", jwtAuthMiddleware, (req, res) => {
    elementTypesController.delete(req, res);
});

export default elementTypesRouter;
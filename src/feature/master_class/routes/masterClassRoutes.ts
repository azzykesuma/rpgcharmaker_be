import { Router } from "express";
import { MasterClassController } from "../interface/master_class.controller";
import { MasterClassService } from "../application/masterClass.service";
import { MasterClassRepository } from "../infrastructure/masterClassRepository";
import pool from "../../../config/dbConfig";
import jwtAuthMiddleware from "../../../shared/middleware/JwtAuthMiddleware";
import { asyncWrapper } from "../../../shared/utils/asyncWrapper";

const masterClassRouter = Router();

const masterClassRepository = new MasterClassRepository(pool);
const masterClassService = new MasterClassService(masterClassRepository);
const masterClassController = new MasterClassController(masterClassService);

masterClassRouter.post(
  "/",
  jwtAuthMiddleware,
  asyncWrapper(async (req, res) => {
    await masterClassController.create(req, res);
  }),
);
masterClassRouter.get(
  "/",
  jwtAuthMiddleware,
  asyncWrapper(async (req, res) => {
    await masterClassController.getMasterClasses(req, res);
  }),
);
masterClassRouter.get(
  "/getbyid/:id",
  jwtAuthMiddleware,
  asyncWrapper(async (req, res) => {
    await masterClassController.getMasterClassById(req, res);
  }),
);
masterClassRouter.put(
  "/:id",
  jwtAuthMiddleware,
  asyncWrapper(async (req, res) => {
    await masterClassController.updateMasterClass(req, res);
  }),
);
masterClassRouter.delete(
  "/delete/:id",
  jwtAuthMiddleware,
  asyncWrapper(async (req, res) => {
    await masterClassController.deleteMasterClass(req, res);
  }),
);

export default masterClassRouter;

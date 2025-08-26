import { Router } from "express";
import { MasterClassController } from "../interface/master_class.controller";
import { MasterClassService } from "../application/masterClass.service";
import { MasterClassRepository } from "../infrastructure/masterClassRepository";
import pool from "../../../config/dbConfig";

const masterClassRouter = Router();

const masterClassRepository = new MasterClassRepository(pool);
const masterClassService = new MasterClassService(masterClassRepository);
const masterClassController = new MasterClassController(masterClassService);

masterClassRouter.post("/", (req, res) => {
  masterClassController.create(req, res);
});

export default masterClassRouter;

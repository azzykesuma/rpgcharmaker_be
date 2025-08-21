import type { Request, Response } from "express";
import { MasterClassService } from "../application/MasterClassService.ts";
import logger from "../../../shared/utils/logger.ts";

export class MasterClassController {
  private readonly masterClassService: MasterClassService;
  constructor(masterClassService: MasterClassService) {
    this.masterClassService = masterClassService;
  }

  async create(req: Request, res: Response) {
    logger.info(
      `[MasterClassController] Creating master class with payload: ${JSON.stringify(
        req.body,
      )}`,
    );
    if (!req.body.master_class_name || !req.body.master_class_description) {
      handleResponse(res, {
        error:
          "All fields (master_class_name, master_class_description) are required and must be valid.",
        statusCode: 400,
      });
      return;
    }
    const { master_class_name, master_class_description } = req.body;
    const masterClass = await this.masterClassService.createMasterClass(
      master_class_name,
      master_class_description,
    );
    res.status(201).json(masterClass);
  }

  async getMasterClasses(req: Request, res: Response) {
    const masterClasses = await this.masterClassService.getMasterClasses();
    res.status(200).json(masterClasses);
  }
}

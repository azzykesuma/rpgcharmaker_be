import type { Request, Response } from "express";
import { MasterClassService } from "../application/masterClass.service";
import logger from "../../../shared/utils/logger";
import { handleResponse } from "../../../shared/utils/responseHandler";

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
    if (
      !req.body.class_name ||
      !req.body.class_main_stat ||
      !req.body.class_base_dex ||
      !req.body.class_base_int ||
      !req.body.class_base_hp ||
      !req.body.class_base_mp ||
      !req.body.class_base_str
    ) {
      handleResponse(res, {
        error:
          "All fields (class_name, class_main_stat) are required and must be valid.",
        statusCode: 400,
      });
      return;
    }
    const {
      class_name,
      class_base_dex,
      class_base_int,
      class_base_hp,
      class_base_mp,
      class_base_str,
      class_main_stat,
    } = req.body;
    const isCreated = await this.masterClassService.createMasterClass({
      class_name: class_name,
      class_base_dex: class_base_dex,
      class_base_int: class_base_int,
      class_base_hp: class_base_hp,
      class_base_mp: class_base_mp,
      class_base_str: class_base_str,
      class_main_stat: class_main_stat,
    });
    if (!isCreated) {
      handleResponse(res, {
        error: "Failed to create master class",
        statusCode: 400,
      });
      return;
    }
    handleResponse(res, {
      message: "Master class created successfully",
      statusCode: 200,
    });
  }

  async getMasterClasses(req: Request, res: Response) {
    const masterClasses = await this.masterClassService.getMasterClasses();
    handleResponse(res, masterClasses);
  }

  async getMasterClassById(req: Request, res: Response) {
    logger.info(
      `[MasterClassController] Getting master class by id: ${req.params.id}`,
    );
    if (!req.params.id || req.params.id === ":id") {
      handleResponse(res, {
        error: "Master class id is required",
        statusCode: 400,
      });
      return;
    }
    const { id } = req.params;
    const masterClass = await this.masterClassService.getMasterClassById(
      Number(id),
    );
    handleResponse(res, {
      message: "Master class fetched successfully",
      statusCode: 200,
      data: masterClass,
    });
  }

  async updateMasterClass(req: Request, res: Response) {
    logger.info(
      `[MasterClassController] Updating master class with payload: ${JSON.stringify(
        req.body,
      )}`,
    );
    if (
      !req.body.class_name ||
      !req.body.class_main_stat ||
      !req.body.class_base_dex ||
      !req.body.class_base_int ||
      !req.body.class_base_hp ||
      !req.body.class_base_mp ||
      !req.body.class_base_str
    ) {
      handleResponse(res, {
        error: "All fields are required and must be valid.",
        statusCode: 400,
      });
      return;
    }
    const { id } = req.params;
    const payload = {
      ...req.body,
      id,
    };
    const isUpdated = await this.masterClassService.updateMasterClass(payload);
    if (!isUpdated) {
      handleResponse(res, {
        error: "Failed to update master class",
        statusCode: 400,
      });
      return;
    }
    handleResponse(res, {
      message: "Master class updated successfully",
      statusCode: 200,
    });
  }

  async deleteMasterClass(req: Request, res: Response) {
    logger.info(
      `[MasterClassController] Deleting master class with id: ${req.params.id}`,
    );
    if (!req.params.id || req.params.id === ":id") {
      handleResponse(res, {
        error: "Master class id is required",
        statusCode: 404,
      });
      return;
    }
    const { id } = req.params;
    const isDeleted = await this.masterClassService.deleteMasterClass(
      Number(id),
    );
    if (!isDeleted) {
      handleResponse(res, {
        error: "Failed to delete master class",
        statusCode: 500,
      });
      return;
    }
    handleResponse(res, {
      message: "Master class deleted successfully",
      statusCode: 200,
    });
  }
}

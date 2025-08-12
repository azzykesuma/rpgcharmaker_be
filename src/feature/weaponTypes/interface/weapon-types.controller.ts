import { HttpError } from "../../../shared/utils/httpError.ts";
import { handleResponse } from "../../../shared/utils/responseHandler.ts";
import type { Request, Response } from "express";
import { WeaponTypeService } from "../application/WeaponTypeService.ts";
import logger from "../../../shared/utils/logger.ts";

export class WeaponTypesController {
  private readonly weaponTypesService: WeaponTypeService;

  constructor(weaponTypesService: WeaponTypeService) {
    this.weaponTypesService = weaponTypesService;
  }

  async findAll(req: Request, res: Response): Promise<void> {
    try {
      const weaponTypes = await this.weaponTypesService.findAll();
      handleResponse(res, {
        data: weaponTypes,
        message: "Weapon types fetched successfully",
        statusCode: 200,
      });
    } catch (error) {
      handleResponse(res, {
        data: null,
        message: error instanceof Error ? error.message : "An error occurred",
        statusCode: 500,
      });
    }
  }

  async create(req: Request, res: Response): Promise<void> {
    logger.info(`[WeaponTypesController] Creating weapon type`);
    try {
      const { weapon_type_name } = req.body;
      await this.weaponTypesService.create({ weapon_type_name });
      handleResponse(res, {
        message: "Weapon type created successfully",
        statusCode: 200,
      });
    } catch (error) {
      handleResponse(res, {
        statusCode: error instanceof HttpError ? error.statusCode : 500,
        error: error instanceof HttpError ? error.message : "An error occurred",
      });
    }
  }

  async findByName(req: Request, res: Response): Promise<void> {
    try {
      const { weapon_type_name } = req.params;
      const weaponType = await this.weaponTypesService.findByName(
        weapon_type_name
      );
      handleResponse(res, {
        data: weaponType,
        message: "Weapon type fetched successfully",
        statusCode: 200,
      });
    } catch (error) {
      handleResponse(res, {
        data: null,
        message: error instanceof Error ? error.message : "An error occurred",
        statusCode: 500,
      });
    }
  }

  async delete(req: Request, res: Response): Promise<void> {
    try {
      const { id } = req.params;
      await this.weaponTypesService.delete(Number(id));
      handleResponse(res, {
        message: "Weapon type deleted successfully",
        statusCode: 200,
      });
    } catch (error) {
      handleResponse(res, {
        error: error instanceof Error ? error.message : "An error occurred",
        statusCode: 500,
      });
    }
  }
}

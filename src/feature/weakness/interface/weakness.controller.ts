import type { Request, Response } from "express";
import { HttpError } from "../../../shared/utils/httpError.ts";
import logger from "../../../shared/utils/logger.ts";
import { handleResponse } from "../../../shared/utils/responseHandler.ts";
import type { IWeaknessCreate, IWeaknessUpdate } from "../domain/Weakness.ts";
import type { WeaknessService } from "../application/weaknessService.ts";

export class WeaknessController {
    private readonly weaknessService: WeaknessService;
    constructor(weaknessService: WeaknessService) {
        this.weaknessService = weaknessService;
    }

    async create(req: Request, res: Response): Promise<void> {
        logger.info(`WeaknessController: Creating weakness with payload: ${JSON.stringify(req.body)}`);
        try {
            const { weakness_type, weakness_damage_mult } = req.body;
            if (!weakness_type || !weakness_damage_mult) {
                handleResponse(res, {
                    error: "All fields (weakness_type, weakness_damage_mult) are required and must be valid.",
                    statusCode: 400,
                });
                return;
            }
            if(weakness_damage_mult < 0) {
                handleResponse(res, {
                    error: "Weakness damage multiplier must be greater than 0",
                    statusCode: 400,
                });
                return;
            }
            const payload: IWeaknessCreate = {
                weakness_type,
                weakness_damage_mult,
            }
            const weakness = await this.weaknessService.create(payload);
            handleResponse(res, {
                data: weakness,
                message: "Weakness created successfully",
            });
        } catch (error) {
            handleResponse(res, {
                error: error instanceof HttpError ? error.message : "An error occurred",
                statusCode: error instanceof HttpError ? error.statusCode : 500,
            });
        }
    }

    async getWeaknesses(req: Request, res: Response): Promise<void> {
        logger.info(`WeaknessController: Getting weaknesses`);
        try {
            const weaknesses = await this.weaknessService.getWeaknesses();
            handleResponse(res, {
                data: weaknesses,
                message: "Weaknesses fetched successfully",
            });
        } catch (error) {
            handleResponse(res, {
                error: error instanceof HttpError ? error.message : "An error occurred",
                statusCode: error instanceof HttpError ? error.statusCode : 500,
            });
        }
    }

    async updateWeakness(req: Request, res: Response): Promise<void> {
        logger.info(`WeaknessController: Updating weakness with payload: ${JSON.stringify(req.body)}`);
        try {
            const weakness_id = Number(req.params.id);
            const { weakness_damage_mult } = req.body;

            if (!weakness_id || !weakness_damage_mult) {
                handleResponse(res, {
                    error: "All fields (weakness_id, weakness_damage_mult) are required and must be valid.",
                    statusCode: 400,
                });
                return;
            }
            if(weakness_damage_mult < 0) {
                handleResponse(res, {
                    error: "Weakness damage multiplier must be greater than 0",
                    statusCode: 400,
                });
                return;
            }
            const payload: IWeaknessUpdate = {
                weakness_id,
                weakness_damage_mult,
            }
            const weakness = await this.weaknessService.updateWeakness(payload);
            handleResponse(res, {
                data: weakness,
                message: "Weakness updated successfully",
            });
        } catch (error) {
            handleResponse(res, {
                error: error instanceof HttpError ? error.message : "An error occurred",
                statusCode: error instanceof HttpError ? error.statusCode : 500,
            });
        }
    }

    async deleteWeakness(req: Request, res: Response): Promise<void> {
        logger.info(`WeaknessController: Deleting weakness with id: ${req.params.id}`);
        try {
            const weakness_id = Number(req.params.id);
            const weakness = await this.weaknessService.deleteWeakness(weakness_id);
            handleResponse(res, {
                data: weakness,
                message: "Weakness deleted successfully",
            });
        } catch (error) {
            handleResponse(res, {
                error: error instanceof HttpError ? error.message : "An error occurred",
                statusCode: error instanceof HttpError ? error.statusCode : 500,
            });
        }
    }
}
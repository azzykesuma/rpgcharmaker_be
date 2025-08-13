import type { Request, Response } from "express";
import { ResistanceService } from "../application/resistanceService.ts";
import logger from "../../../shared/utils/logger.ts";
import { handleResponse } from "../../../shared/utils/responseHandler.ts";
import { HttpError } from "../../../shared/utils/httpError.ts";
import type { IResistanceCreate, IResistanceUpdate } from "../domain/Resistance.ts";

export class ResistanceController {
    private readonly resistanceService: ResistanceService;
    constructor(resistanceService: ResistanceService) {
        this.resistanceService = resistanceService;
    }

    async create(req: Request, res: Response): Promise<void> {
        logger.info(`ResistanceController: Creating resistance with payload: ${JSON.stringify(req.body)}`);
        try {
            const { resistance_type, resistance_damage_reduction } = req.body;
            if (!resistance_type || !resistance_damage_reduction) {
                handleResponse(res, {
                    error: "All fields (resistance_type, resistance_damage_reduction) are required and must be valid.",
                    statusCode: 400,
                });
                return;
            }
            if(resistance_damage_reduction < 0) {
                handleResponse(res, {
                    error: "Resistance damage reduction must be greater than 0",
                    statusCode: 400,
                });
                return;
            }
            const payload: IResistanceCreate = {
                resistance_type,
                resistance_damage_reduction,
            }
            const resistance = await this.resistanceService.create(payload);
            handleResponse(res, {
                data: resistance,
                message: "Resistance created successfully",
            });
        } catch (error) {
            handleResponse(res, {
                error: error instanceof HttpError ? error.message : "An error occurred",
                statusCode: error instanceof HttpError ? error.statusCode : 500,
            });
        }
    }

    async getResistances(req: Request, res: Response): Promise<void> {
        logger.info(`ResistanceController: Getting resistances`);
        try {
            const resistances = await this.resistanceService.getResistances();
            handleResponse(res, {
                data: resistances,
                message: "Resistances fetched successfully",
            });
        } catch (error) {
            handleResponse(res, {
                error: error instanceof HttpError ? error.message : "An error occurred",
                statusCode: error instanceof HttpError ? error.statusCode : 500,
            });
        }
    }

    async updateResistance(req: Request, res: Response): Promise<void> {
        logger.info(`ResistanceController: Updating resistance with payload: ${JSON.stringify(req.body)}`);
        try {
            const resistance_id = Number(req.params.id);
            const { resistance_damage_reduction } = req.body;
            if (!resistance_id || !resistance_damage_reduction) {
                handleResponse(res, {
                    error: "All fields (resistance_id, resistance_damage_reduction) are required and must be valid.",
                    statusCode: 400,
                });
                return;
            }
            const payload: IResistanceUpdate = {
                resistance_id,
                resistance_damage_reduction,
            }
            const resistance = await this.resistanceService.updateResistance(payload);
            handleResponse(res, {
                data: resistance,
                message: "Resistance updated successfully",
            });
        } catch (error) {
            handleResponse(res, {
                error: error instanceof HttpError ? error.message : "An error occurred",
                statusCode: error instanceof HttpError ? error.statusCode : 500,
            });
        }
    }

    async deleteResistance(req: Request, res: Response): Promise<void> {
        logger.info(`ResistanceController: Deleting resistance with id: ${req.params.id}`);
        try {
            const { id } = req.params;
            const resistance = await this.resistanceService.deleteResistance(Number(id));
            handleResponse(res, {
                data: resistance,
                message: "Resistance deleted successfully",
            });
        } catch (error) {
            handleResponse(res, {
                error: error instanceof HttpError ? error.message : "An error occurred",
                statusCode: error instanceof HttpError ? error.statusCode : 500,
            });
        }
    }
}
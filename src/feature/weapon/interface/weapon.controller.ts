import type { Request, Response } from "express";
import type { WeaponService } from "../application/WeaponService.ts";
import { handleResponse } from "../../../shared/utils/responseHandler.ts";
import type { IWeaponCreate, IWeaponUpdate, IWeaponUpdateImage } from "../domain/Weapon.ts";
import parser from "../../../shared/utils/parser.ts";
import path from "path";
import logger from "../../../shared/utils/logger.ts";
import { HttpError } from "../../../shared/utils/httpError.ts";


export class WeaponController {
    private readonly weaponService: WeaponService;

    constructor(weaponService: WeaponService) {
        this.weaponService = weaponService;
    }

    async getWeapons(_req: Request, res: Response): Promise<void> {
        logger.info(`Getting weapons`);
        try {
            const weapons = await this.weaponService.getWeapons();
            handleResponse(res, {
                data: weapons,
                message: "Weapons fetched successfully",
            });
        } catch (error) {
            handleResponse(res, {
                error: error instanceof Error ? error.message : "An error occurred",
                statusCode: 500,
            });
        }
    }

    async create(req: Request, res: Response): Promise<void> {
        logger.info(`Creating weapon with payload: ${JSON.stringify(req.body)}`);
        try {
        const weapon_name = req.body.weapon_name?.toString().trim();
            const weapon_element = req.body.weapon_element?.toString().trim();
            const weapon_type = req.body.weapon_type?.toString().trim();
            const weapon_base_damage = req.body.weapon_base_damage
                ? Number(req.body.weapon_base_damage)
                : undefined;

            const weapon_image = req.file?.buffer;
            const dataUri = (req: Request) => parser.format(path.extname(req.file?.originalname || '').toString(), req.file?.buffer || Buffer.from(''));            
            
            const imageUrl = dataUri(req);

            if (!weapon_name || !weapon_element || !weapon_type || weapon_base_damage === undefined || isNaN(weapon_base_damage)) {
                handleResponse(res, {
                    error: "All fields (weapon_name, weapon_element, weapon_type, weapon_base_damage) are required and must be valid.",
                    statusCode: 400,
                });
                return;
            }

            if (!weapon_image) {
                handleResponse(res, {
                    error: "Weapon image is required",
                    statusCode: 400,
                });
                return;
            }

            if (!imageUrl.content) {
                handleResponse(res, {
                    error: "Weapon image is required",
                    statusCode: 400,
                });
                return;
            }

            const payload: IWeaponCreate = {
                weapon_name,
                weapon_element,
                weapon_base_damage,
                weapon_type,
                weapon_image : imageUrl.content,
            };

            const weapon = await this.weaponService.create(payload);
            handleResponse(res, {
                data: weapon,
                message: "Weapon created successfully",
            });
        } catch (error) {
            handleResponse(res, {
                error: error instanceof Error ? error.message : "An error occurred",
                statusCode: 500,
            });
        }
    }

    async updateInfo(req: Request, res: Response): Promise<void> {
        logger.info(`Updating weapon info with payload: ${JSON.stringify(req.body)}`);
        try {
            const weapon_id = req.params.id;
            const { weapon_name, weapon_element, weapon_type, weapon_base_damage } = req.body;

            if (!weapon_id || !weapon_name || !weapon_element || !weapon_type || weapon_base_damage === undefined || isNaN(weapon_base_damage)) {
                handleResponse(res, {
                    error: "All fields (weapon_id, weapon_name, weapon_element, weapon_type, weapon_base_damage) are required and must be valid.",
                    statusCode: 400,
                });
                return;
            }

            const payload: IWeaponUpdate = {
                weapon_id: Number(weapon_id),
                weapon_name,
                weapon_element,
                weapon_type,
                weapon_base_damage: Number(weapon_base_damage),
            };

            const weapon = await this.weaponService.updateInfo(payload);
            handleResponse(res, {
                data: weapon,
                message: "Weapon updated successfully",
            });
        } catch (error) {
            handleResponse(res, {
                error: error instanceof HttpError ? error.message : "An error occurred",
                statusCode: error instanceof HttpError ? error.statusCode : 500,
            });
        }
    }

    async updateImage(req: Request, res: Response): Promise<void> {
        logger.info(`Updating weapon image with payload: ${JSON.stringify(req.body)}`);
        try {
            const weapon_id = req.params.id;
            const weapon_image = req.file?.buffer;
            const dataUri = (req: Request) => parser.format(path.extname(req.file?.originalname || '').toString(), req.file?.buffer || Buffer.from(''));            
            const imageUrl = dataUri(req);

            if (!weapon_id || !weapon_image) {
                handleResponse(res, {
                    error: "All fields (weapon_id, weapon_image) are required and must be valid.",
                    statusCode: 400,
                });
                return;
            }

            if (!imageUrl.content) {
                handleResponse(res, {
                    error: "Weapon image is required",
                    statusCode: 400,
                });
                return;
            }

            const payload: IWeaponUpdateImage = {
                weapon_id: Number(weapon_id),
                weapon_image: imageUrl.content,
            };

            const weapon = await this.weaponService.updateImage(payload);
            handleResponse(res, {
                data: weapon,
                message: "Weapon image updated successfully",
            });
        } catch (error) {
            handleResponse(res, {
                error: error instanceof HttpError ? error.message : "An error occurred",
                statusCode: error instanceof HttpError ? error.statusCode : 500,
            });
        }
    }

    async deleteWeapon(req: Request, res: Response): Promise<void> {
        logger.info(`Deleting weapon with payload: ${JSON.stringify(req.body)}`);
        try {
            const weapon_id = req.params.id;
            if (!weapon_id) {
                handleResponse(res, {
                    error: "Weapon ID is required",
                    statusCode: 400,
                });
                return;
            }

            const weapon = await this.weaponService.deleteWeapon(Number(weapon_id));
            handleResponse(res, {
                data: weapon,
                message: "Weapon deleted successfully",
            });
        } catch (error) {
            handleResponse(res, {
                error: error instanceof HttpError ? error.message : "An error occurred",
                statusCode: error instanceof HttpError ? error.statusCode : 500,
            });
        }
    }
}
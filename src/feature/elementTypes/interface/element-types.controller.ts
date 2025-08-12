import type { IElementTypesRepository } from "../domain/ElementTypes.ts";
import { handleResponse } from "../../../shared/utils/responseHandler.ts";
import type { Request, Response } from "express";

export class ElementTypesController {
    private readonly elementTypesRepository: IElementTypesRepository;

    constructor(elementTypesRepository: IElementTypesRepository) {
        this.elementTypesRepository = elementTypesRepository;
    }

    async findAll(req: Request, res: Response): Promise<void> {
        const elementTypes = await this.elementTypesRepository.findAll();
        handleResponse(res, {
            data: elementTypes,
            message: "Element types fetched successfully",
            statusCode: 200,
        });
    }

    async create(req: Request, res: Response): Promise<void> {
        try {
            const { element_types_name } = req.body;
            if (!element_types_name) {
                handleResponse(res, {
                    error: "Element types name is required",
                    statusCode: 400,
                });
                return;
            }
            // search if element types name is already exists
            const elementName = element_types_name.toLowerCase();
            const existingElementTypes = await this.elementTypesRepository.findByName(elementName);
            if (existingElementTypes) {
                handleResponse(res, {
                    statusCode: 400,
                    error: "Element types name already exists",
                });
                return;
            }
            const elementTypes = await this.elementTypesRepository.create({ element_types_name });
            handleResponse(res, {
                data: elementTypes,
                message: "Element types created successfully",
                statusCode: 200,
            });
        } catch (error) {
            handleResponse(res, {
                error: error instanceof Error ? error.message : "An unexpected error occurred",
                statusCode: 500,
            });
        }
    }

    async findByName(req: Request, res: Response): Promise<void> {
        const { element_types_name } = req.params;
        if (!element_types_name) {
            handleResponse(res, {
                message: "Element types name is required",
                statusCode: 400,
            });
            return;
        }
        const elementTypes = await this.elementTypesRepository.findByName(element_types_name);
        handleResponse(res, {
            data: elementTypes,
            message: "Element types fetched successfully",
            statusCode: 200,
        });
    }

    async delete(req: Request, res: Response): Promise<void> {
        try {
            const { id } = req.params;
            await this.elementTypesRepository.delete(Number(id));
            handleResponse(res, {
                message: "Element types deleted successfully",
                statusCode: 200,
            });
        } catch (error) {
            handleResponse(res, {
                error: error instanceof Error ? error.message : "An unexpected error occurred",
                statusCode: 500,
            });
        }
    }
}
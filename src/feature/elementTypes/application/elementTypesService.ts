import type { ICreateElementTypes, IElementTypes, IElementTypesRepository } from "../domain/ElementTypes.ts";
import { HttpError } from "../../../shared/utils/httpError.ts";

export class ElementTypesService {
    private readonly elementTypesRepository: IElementTypesRepository;

    constructor(elementTypesRepository: IElementTypesRepository) {
        this.elementTypesRepository = elementTypesRepository;
    }

    async findAll(): Promise<IElementTypes[]> {
        const elementTypes = await this.elementTypesRepository.findAll();
        return elementTypes;
    }

    async create(elementTypes: ICreateElementTypes): Promise<IElementTypes> {
        const elementName = elementTypes.element_types_name.toLowerCase();
        const existingElementTypes = await this.elementTypesRepository.findByName(elementName);
        if (existingElementTypes) {
            throw new HttpError("Element types already exists", 400);
        }
        const elementType = await this.elementTypesRepository.create(elementTypes);
        return elementType;
    }

    async findByName(elementName: string): Promise<IElementTypes | null> {
        const elementType = await this.elementTypesRepository.findByName(elementName);
        return elementType;
    }

    async delete(id: number): Promise<void> {
        await this.elementTypesRepository.delete(id);
        return;
    }
}
export interface IElementTypes {
    element_types_id: number;
    element_types_name: string;
}

export interface ICreateElementTypes {
    element_types_name: string;
}

export interface IElementTypesRepository {
    findAll(): Promise<IElementTypes[]>;
    create(elementTypes: ICreateElementTypes): Promise<IElementTypes>;
    findByName(elementName: string): Promise<IElementTypes | null>;
    delete(elementId: number): Promise<void>;
}
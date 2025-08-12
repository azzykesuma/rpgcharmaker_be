export interface IWeaponTypes {
    weapon_type_id: number;
    weapon_type_name: string;
}

export interface ICreateWeaponTypes {
    weapon_type_name: string;
}

export interface IWeaponTypesRepository {
    findAll(): Promise<IWeaponTypes[]>;
    create(weaponTypes: ICreateWeaponTypes): Promise<IWeaponTypes>;
    findByName(weaponName: string): Promise<IWeaponTypes | null>;
    delete(weaponId: number): Promise<void>;
}
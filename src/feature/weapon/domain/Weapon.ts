export interface IWeapon {
    weapon_id: number;
    weapon_name: string;
    weapon_element: number;
    weapon_base_damage: number;
    weapon_type: number;
    weapon_image: string;
}

export type IWeaponCreate = Omit<IWeapon, "weapon_id">;
export type IWeaponUpdate = Omit<IWeapon, "weapon_image">;
export type IWeaponUpdateImage = Pick<IWeapon, "weapon_id" | "weapon_image">;

export interface IWeaponRepository {
    create(weapon: IWeaponCreate): Promise<IWeapon>;
    getWeapons(): Promise<IWeapon[]>;
    updateInfo(weapon: IWeaponUpdate): Promise<IWeapon>;
    findWeapon(weapon_id: number): Promise<IWeapon>;
    findWeaponByName(weapon_name: string): Promise<IWeapon>;
    updateImage(weapon: IWeaponUpdateImage): Promise<IWeapon>;
    deleteWeapon(weapon_id: number): Promise<IWeapon>;
}
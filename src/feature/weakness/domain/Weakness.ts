export interface IWeakness {
    weakness_id: number;
    weakness_type: number;
    weakness_damage_mult: number;
}

export type IWeaknessCreate = Omit<IWeakness, "weakness_id">;
export type IWeaknessUpdate = Pick<IWeakness, "weakness_id" | "weakness_damage_mult">;

export type IWeaknessRepository = {
    create(weakness: IWeaknessCreate): Promise<IWeakness>;
    getWeaknesses(): Promise<IWeakness[]>;
    updateWeakness(weakness: IWeaknessUpdate): Promise<IWeakness>;
    deleteWeakness(weakness_id: number): Promise<IWeakness>;
    findWeaknessByType(weakness_type: number): Promise<IWeakness>;
}
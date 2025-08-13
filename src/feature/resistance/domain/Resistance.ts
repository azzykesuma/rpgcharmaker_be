export interface IResistance {
    resistance_id: number;
    resistance_type : number;
    resistance_damage_reduction: number;
}

export type IResistanceCreate = Omit<IResistance, "resistance_id">;
export type IResistanceUpdate = Pick<IResistance, "resistance_id" | "resistance_damage_reduction">;

export type IResistanceRepository = {
    create(resistance: IResistanceCreate): Promise<IResistance>;
    getResistances(): Promise<IResistance[]>;
    updateResistance(resistance: IResistanceUpdate): Promise<IResistance>;
    deleteResistance(resistance_id: number): Promise<IResistance>;
    findResistanceByType(resistance_type: number): Promise<IResistance>;
}
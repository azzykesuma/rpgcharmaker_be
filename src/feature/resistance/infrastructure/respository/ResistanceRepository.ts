import type { Pool } from "pg";
import type { IResistance, IResistanceCreate, IResistanceRepository, IResistanceUpdate } from "../../domain/Resistance.ts";

export class ResistanceRepository implements IResistanceRepository {
    private readonly pool: Pool;
    constructor(pool: Pool) {
        this.pool = pool;
    }

    async create(resistance: IResistanceCreate): Promise<IResistance> {
        try {
            const query = `
                INSERT INTO resistances (resistance_type, resistance_damage_reduction)
                VALUES ($1, $2)
                RETURNING resistance_id
            `;
            const values = [resistance.resistance_type, resistance.resistance_damage_reduction];
            const result = await this.pool.query(query, values);
            return result.rows[0];
        } catch (error) {
            throw error;
        }
    }

    async getResistances(): Promise<IResistance[]> {
        try {
            const query = `
                SELECT * FROM resistances
            `;
            const result = await this.pool.query(query);
            return result.rows;
        } catch (error) {
            throw error;
        }
    }

    async findResistanceByType(resistance_type: number): Promise<IResistance> {
        try {
            const query = `
                SELECT * FROM resistances WHERE resistance_type = $1
            `;
            const values = [resistance_type];
            const result = await this.pool.query(query, values);
            return result.rows[0];
        } catch (error) {
            throw error;
        }
    }

    async updateResistance(resistance: IResistanceUpdate): Promise<IResistance> {
        try {
            const query = `
                UPDATE resistances
                SET resistance_damage_reduction = $1
                WHERE resistance_id = $2
                RETURNING resistance_id
            `;
            const values = [resistance.resistance_damage_reduction, resistance.resistance_id];
            const result = await this.pool.query(query, values);
            return result.rows[0];
        } catch (error) {
            throw error;
        }
    }

    async deleteResistance(resistance_id: number): Promise<IResistance> {
        try {
            const query = `
                DELETE FROM resistances WHERE resistance_id = $1
                RETURNING resistance_id
            `;
            const values = [resistance_id];
            const result = await this.pool.query(query, values);
            return result.rows[0];
        } catch (error) {
            throw error;
        }
    }
}
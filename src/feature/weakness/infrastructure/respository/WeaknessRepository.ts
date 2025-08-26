import type {
  IWeakness,
  IWeaknessCreate,
  IWeaknessRepository,
  IWeaknessUpdate,
} from "../../domain/Weakness";

import type { Pool } from "pg";

export class WeaknessRepository implements IWeaknessRepository {
  private readonly pool: Pool;
  constructor(pool: Pool) {
    this.pool = pool;
  }

  async create(weakness: IWeaknessCreate): Promise<IWeakness> {
    try {
      const query = `
                INSERT INTO weakness (weakness_type, weakness_damage_mult)
                VALUES ($1, $2)
                RETURNING weakness_id
            `;
      const values = [weakness.weakness_type, weakness.weakness_damage_mult];
      const result = await this.pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw error;
    }
  }

  async getWeaknesses(): Promise<IWeakness[]> {
    try {
      const query = `
                SELECT * FROM weakness
            `;
      const result = await this.pool.query(query);
      return result.rows;
    } catch (error) {
      throw error;
    }
  }

  async findWeaknessByType(weakness_type: number): Promise<IWeakness> {
    try {
      const query = `
                SELECT * FROM weakness WHERE weakness_type = $1
            `;
      const values = [weakness_type];
      const result = await this.pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw error;
    }
  }

  async updateWeakness(weakness: IWeaknessUpdate): Promise<IWeakness> {
    try {
      const query = `
                UPDATE weakness
                SET weakness_damage_mult = $1
                WHERE weakness_id = $2
                RETURNING weakness_id
            `;
      const values = [weakness.weakness_damage_mult, weakness.weakness_id];
      const result = await this.pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw error;
    }
  }

  async deleteWeakness(weakness_id: number): Promise<IWeakness> {
    try {
      const query = `
                DELETE FROM weakness WHERE weakness_id = $1
                RETURNING weakness_id
            `;
      const values = [weakness_id];
      const result = await this.pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw error;
    }
  }
}

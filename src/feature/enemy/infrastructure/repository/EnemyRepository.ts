import type {
  IEnemy,
  IEnemyCreate,
  IEnemyRepository,
  IEnemyUpdateInfo,
  IEnemyUpdateImage,
} from "../../domain/Enemy";
import type { Pool } from "pg";

export class EnemyRepository implements IEnemyRepository {
  private readonly pool: Pool;
  constructor(pool: Pool) {
    this.pool = pool;
  }

  async create(enemy: IEnemyCreate): Promise<IEnemy> {
    try {
      const query = `
                INSERT INTO enemy (enemy_name, enemy_base_hp, enemy_base_mp, enemy_base_dex, enemy_base_int, enemy_base_constitution, enemy_resistance, enemy_weakness, enemy_image)
                VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
                RETURNING enemy_id
            `;
      const values = [
        enemy.enemy_name,
        enemy.enemy_base_hp,
        enemy.enemy_base_mp,
        enemy.enemy_base_dex,
        enemy.enemy_base_int,
        enemy.enemy_base_constitution,
        enemy.enemy_resistance,
        enemy.enemy_weakness,
        enemy.enemy_image,
      ];
      const result = await this.pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw error;
    }
  }

  async getEnemies(): Promise<IEnemy[]> {
    try {
      const query = `
        SELECT * FROM enemy
      `;
      const result = await this.pool.query(query);
      return result.rows;
    } catch (error) {
      throw error;
    }
  }

  async getEnemyById(enemy_id: string): Promise<IEnemy> {
    try {
      const query = `
        SELECT
          e.enemy_id,
          e.enemy_name,
          e.enemy_base_hp,
          e.enemy_base_mp,
          e.enemy_base_dex,
          e.enemy_base_int,
          e.enemy_base_constitution,
          e.enemy_image,
          resistance_type.element_types_name AS resistance_types_name,
          weakness_type.element_types_name AS weakness_types_name,
          r.resistance_damage_reduction,
          w.weakness_damage_mult
        FROM
          enemy AS e
        INNER JOIN
          resistances AS r ON e.enemy_resistance = r.resistance_id
        INNER JOIN
          element_types AS resistance_type ON r.resistance_type = resistance_type.element_types_id
        INNER JOIN
          weakness AS w ON e.enemy_weakness = w.weakness_id
        INNER JOIN
          element_types AS weakness_type ON w.weakness_type = weakness_type.element_types_id
        WHERE
          e.enemy_id = $1
        LIMIT 1;
      `;
      const values = [enemy_id];
      const result = await this.pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw error;
    }
  }

  async updateEnemyInfo(enemy: IEnemyUpdateInfo): Promise<IEnemy> {
    try {
      const query = `
        UPDATE enemy
        SET 
          enemy_name = $1, 
          enemy_base_hp = $2, 
          enemy_base_mp = $3, 
          enemy_base_dex = $4, 
          enemy_base_int = $5, 
          enemy_base_constitution = $6, 
          enemy_resistance = $7, 
          enemy_weakness = $8
        WHERE enemy_id = $9
        RETURNING *
      `;
      const values = [
        enemy.enemy_name,
        enemy.enemy_base_hp,
        enemy.enemy_base_mp,
        enemy.enemy_base_dex,
        enemy.enemy_base_int,
        enemy.enemy_base_constitution,
        enemy.enemy_resistance,
        enemy.enemy_weakness,
        enemy.enemy_id,
      ];
      const result = await this.pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw error;
    }
  }

  async updateEnemyImage(enemy: IEnemyUpdateImage): Promise<IEnemy> {
    try {
      const query = `
        UPDATE enemy
        SET enemy_image = $1
        WHERE enemy_id = $2
        RETURNING enemy_id
      `;
      const values = [enemy.enemy_image, enemy.enemy_id];
      const result = await this.pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw error;
    }
  }

  async deleteEnemy(enemy_id: string): Promise<IEnemy> {
    try {
      const query = `
        DELETE FROM enemy
        WHERE enemy_id = $1
        RETURNING enemy_id
      `;
      const values = [enemy_id];
      const result = await this.pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      throw error;
    }
  }
}

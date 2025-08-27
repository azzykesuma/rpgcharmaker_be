import type { Pool } from "pg";
import type {
  IMasterClass,
  IMasterClassCreate,
  IMasterClassRepository,
  NoDataResponse,
} from "../domain/MasterClass.ts";
import { HttpError } from "../../../shared/utils/httpError";

export class MasterClassRepository implements IMasterClassRepository {
  private readonly pool: Pool;
  constructor(pool: Pool) {
    this.pool = pool;
  }

  async createMasterClass(masterClass: IMasterClassCreate): Promise<boolean> {
    try {
      const {
        class_name,
        class_base_dex,
        class_base_int,
        class_base_hp,
        class_base_mp,
        class_base_str,
        class_main_stat,
      } = masterClass;
      const query = `
      INSERT INTO master_class (class_name, class_base_dex, class_base_int, class_base_hp, class_base_mp, class_base_str, class_main_stat)
      VALUES ($1, $2, $3, $4, $5, $6, $7)
      `;
      const values = [
        class_name,
        class_base_dex,
        class_base_int,
        class_base_hp,
        class_base_mp,
        class_base_str,
        class_main_stat,
      ];
      await this.pool.query(query, values);
      return true;
    } catch (error) {
      throw new HttpError(
        error instanceof Error ? error.message : "An error occurred",
        500,
      );
    }
  }

  async getMasterClassByName(className: string): Promise<IMasterClass> {
    const query = `
    SELECT class_name FROM master_class WHERE class_name = $1
    `;
    const values = [className];
    const result = await this.pool.query(query, values);
    return result.rows[0];
  }

  async getMasterClasses(): Promise<IMasterClass[]> {
    const query = `
    SELECT * FROM master_class
    `;
    const result = await this.pool.query(query);
    return result.rows;
  }

  async getMasterClassById(id: number): Promise<IMasterClass> {
    const query = `
    SELECT * FROM master_class WHERE class_id = $1
    `;
    const values = [id];
    const result = await this.pool.query(query, values);
    if (result.rowCount === 0) {
      throw new HttpError("Master class not found", 404);
    }
    return result.rows[0];
  }

  async updateMasterClass(
    payload: IMasterClassCreate & { id: number },
  ): Promise<boolean> {
    const { id, ...rest } = payload;
    const query = `
    UPDATE master_class SET class_name = $1, class_main_stat = $2, class_base_dex = $3, class_base_int = $4, class_base_hp = $5, class_base_mp = $6, class_base_str = $7 WHERE class_id = $8
    `;
    const values = [
      rest.class_name,
      rest.class_main_stat,
      rest.class_base_dex,
      rest.class_base_int,
      rest.class_base_hp,
      rest.class_base_mp,
      rest.class_base_str,
      id,
    ];
    const result = await this.pool.query(query, values);
    if (result.rowCount === 0) {
      throw new HttpError("Master class not found", 404);
    }
    return true;
  }

  async deleteMasterClass(id: number): Promise<boolean> {
    const query = `
    DELETE FROM master_class WHERE class_id = $1
    `;
    const values = [id];
    const result = await this.pool.query(query, values);
    if (result.rowCount === 0) {
      throw new HttpError("Master class not found", 404);
    }
    return true;
  }
}

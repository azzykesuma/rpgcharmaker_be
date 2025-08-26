import type { Pool } from "pg";
import type {
  BaseResponse,
  IMasterClass,
  IMasterClassCreate,
  IMasterClassRepository,
} from "../domain/MasterClass.ts";
import { HttpError } from "../../../shared/utils/httpError";

export class MasterClassRepository implements IMasterClassRepository {
  private readonly pool: Pool;
  constructor(pool: Pool) {
    this.pool = pool;
  }

  async createMasterClass(
    masterClass: IMasterClassCreate,
  ): Promise<BaseResponse> {
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
      return {
        message: "Master class created successfully",
        statusCode: 200,
      };
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
}

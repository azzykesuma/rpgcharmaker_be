import type { Pool } from "pg";
import type {
  ICreateElementTypes,
  IElementTypes,
  IElementTypesRepository,
} from "../../domain/ElementTypes";
import { HttpError } from "../../../../shared/utils/httpError";

export class ElementTypeRepository implements IElementTypesRepository {
  private readonly pool: Pool;

  constructor(pool: Pool) {
    this.pool = pool;
  }

  async findAll(): Promise<IElementTypes[]> {
    const elementTypes = await this.pool.query("SELECT * FROM element_types");
    return elementTypes.rows;
  }

  async create(elementTypes: ICreateElementTypes): Promise<IElementTypes> {
    const result = await this.pool.query(
      "INSERT INTO element_types (element_types_name) VALUES ($1) RETURNING *",
      [elementTypes.element_types_name],
    );
    return result.rows[0];
  }

  async findByName(elementName: string): Promise<IElementTypes | null> {
    const result = await this.pool.query(
      "SELECT * FROM element_types WHERE element_types_name = $1",
      [elementName],
    );
    return result.rows[0] || null;
  }

  async delete(elementId: number): Promise<void> {
    const result = await this.pool.query(
      "DELETE FROM element_types WHERE element_types_id = $1 RETURNING *",
      [elementId],
    );
    if (result.rowCount === 0) {
      throw new HttpError("Element types not found", 404);
    }
  }
}

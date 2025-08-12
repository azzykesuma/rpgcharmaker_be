import type { ICreateWeaponTypes, IWeaponTypesRepository } from "../../domain/WeaponTypes.ts";
import type { Pool } from "pg";
import type { IWeaponTypes } from "../../domain/WeaponTypes.ts";
import { HttpError } from "../../../../shared/utils/httpError.ts";
import logger from "../../../../shared/utils/logger.ts";

export class WeaponTypesRepository implements IWeaponTypesRepository {
    private readonly pool: Pool;

    constructor(pool: Pool) {
        this.pool = pool;
    }
    async findAll(): Promise<IWeaponTypes[]> {
        logger.info(`[WeaponTypesRepository] Fetching all weapon types`);
        const weaponTypes = await this.pool.query("SELECT * FROM weapon_master_type");
        return weaponTypes.rows;
    }

    async create(weaponTypes: ICreateWeaponTypes): Promise<IWeaponTypes> {
        const result = await this.pool.query("INSERT INTO weapon_master_type (weapon_type_name) VALUES ($1) RETURNING *", [weaponTypes.weapon_type_name]);
        return result.rows[0];
    }

    async findByName(weaponName: string): Promise<IWeaponTypes | null> {
        const result = await this.pool.query("SELECT * FROM weapon_master_type WHERE weapon_type_name = $1", [weaponName]);
        return result.rows[0] || null;
    }

    async delete(weaponId: number): Promise<void> {
        const result = await this.pool.query("DELETE FROM weapon_master_type WHERE weapon_type_id = $1 RETURNING *", [weaponId]);
        if (result.rowCount === 0) {
            throw new HttpError("Weapon type not found", 404);
        }
    }
}
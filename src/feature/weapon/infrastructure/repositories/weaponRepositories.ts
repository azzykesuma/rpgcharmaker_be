import type { Pool } from "pg";
import type { IWeapon, IWeaponCreate, IWeaponRepository, IWeaponUpdate, IWeaponUpdateImage } from "../../domain/Weapon.ts";


export class WeaponRepository implements IWeaponRepository {
    private readonly pool: Pool;
    constructor(pool: Pool) {
        this.pool = pool;
    }

    async create(weapon: IWeaponCreate): Promise<IWeapon> {
        const query = `
            INSERT INTO weapon (weapon_name, weapon_element, weapon_base_damage, weapon_type, weapon_image)
            VALUES ($1, $2, $3, $4, $5)
            RETURNING *
        `;
        const values = [weapon.weapon_name, weapon.weapon_element, weapon.weapon_base_damage, weapon.weapon_type, weapon.weapon_image];
        const result = await this.pool.query(query, values);
        return result.rows[0];
    }
    
    async getWeapons(): Promise<IWeapon[]> {
        const query = `
            SELECT * FROM weapon
        `
        const result = await this.pool.query(query);
        return result.rows;
    }

    async updateInfo(weapon: IWeaponUpdate): Promise<IWeapon> {
        const query = `
            UPDATE weapon
            SET weapon_name = $1, weapon_element = $2, weapon_type = $3, weapon_base_damage = $4
            WHERE weapon_id = $5
            RETURNING weapon_id
        `
        const values = [weapon.weapon_name, weapon.weapon_element, weapon.weapon_type, weapon.weapon_base_damage, weapon.weapon_id];
        const result = await this.pool.query(query, values);
        return result.rows[0];
    }

    async findWeapon(weapon_id: number): Promise<IWeapon> {
        const query = `
            SELECT * FROM weapon WHERE weapon_id = $1
        `
        const values = [weapon_id];
        const result = await this.pool.query(query, values);
        return result.rows[0];
    }

    async findWeaponByName(weapon_name: string): Promise<IWeapon> {
        const query = `
            SELECT weapon_name FROM weapon WHERE weapon_name = $1
        `
        const values = [weapon_name];
        const result = await this.pool.query(query, values);
        return result.rows[0];
    }

    async updateImage(weapon: IWeaponUpdateImage): Promise<IWeapon> {
        const query = `
            UPDATE weapon
            SET weapon_image = $1
            WHERE weapon_id = $2
            RETURNING weapon_id
        `
        const values = [weapon.weapon_image, weapon.weapon_id];
        const result = await this.pool.query(query, values);
        return result.rows[0];
    }

    async deleteWeapon(weapon_id: number): Promise<IWeapon> {
        const query = `
            DELETE FROM weapon WHERE weapon_id = $1
            RETURNING weapon_id
        `
        const values = [weapon_id];
        const result = await this.pool.query(query, values);
        return result.rows[0];
    }
}
import type { Pool } from "pg";
import type { User, UserRepository } from "../../../domain/User.ts";

export class AuthRepository implements UserRepository {
    private readonly pool: Pool;

    constructor(pool: Pool) {
        this.pool = pool;
    }

    async findByUsername(username: string): Promise<User | null> {
        const result = await this.pool.query("SELECT * FROM player WHERE player_name = $1", [username]);
        return result.rows[0] || null;
    }
}
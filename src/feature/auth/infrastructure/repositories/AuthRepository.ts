import type { Pool } from "pg";
import type { TCreateUserPayload, User, UserRepository } from "../../domain/User.ts";

export class AuthRepository implements UserRepository {
    private readonly pool: Pool;

    constructor(pool: Pool) {
        this.pool = pool;
    }

    async findByUsername(username: string): Promise<User | null> {
        const result = await this.pool.query("SELECT * FROM player WHERE player_name = $1", [username]);
        return result.rows[0] || null;
    }

    async create(user: TCreateUserPayload): Promise<User> {
        const result = await this.pool.query("INSERT INTO player (player_name, player_password, role) VALUES ($1, $2, $3) RETURNING *", [user.player_name, user.player_password, "player"]);
        return result.rows[0];
    }
}
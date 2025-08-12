import type { Pool } from "pg";
import logger from "../../../../shared/utils/logger.ts";

export class RefreshTokenRepository {
    private readonly pool: Pool;

    constructor(pool: Pool) {
        this.pool = pool;
    }   

    async createRefreshToken(userId: string, token: string): Promise<void> {
        try {
            const query = `
                INSERT INTO refresh_tokens (user_id, token)
                VALUES ($1, $2);
            `;
            await this.pool.query(query, [userId, token]);
        } catch (error) {
            logger.error(`Database error creating refresh token: ${error}`);
            throw error;
        }
    }

    async deleteRefreshToken(token: string): Promise<void> {
        try {
            const query = `
                DELETE FROM refresh_tokens WHERE token = $1;
            `;
            await this.pool.query(query, [token]);
        } catch (error) {
            logger.error(`Database error deleting refresh token: ${error}`);
            throw error;
        }
    }

    async findRefreshToken(token: string): Promise<{ user_id: string, token: string } | undefined> {
        try {
            const query = `
                SELECT user_id, token FROM refresh_tokens WHERE token = $1;
            `;
            const result = await this.pool.query(query, [token]);
            if (result.rows.length === 0) {
                return undefined;
            }
            return {
                user_id: result.rows[0].user_id,
                token: result.rows[0].token,
            }
        } catch (error) {
            logger.error(`Database error finding refresh token: ${error}`);
            throw error;
        }
    }
}
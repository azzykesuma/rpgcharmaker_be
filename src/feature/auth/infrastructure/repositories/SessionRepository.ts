import type { Pool } from "pg";
import logger from "../../../../shared/utils/logger.ts";

export class SessionRepository {
    private readonly pool: Pool;

    constructor(pool: Pool) {
        this.pool = pool;
    }

    async createSession(userId: string, accessToken: string, userAgent: string): Promise<void> {
        try {
            const query = `
                INSERT INTO session (user_id, token, user_agent)
                VALUES ($1, $2, $3);
            `;
            await this.pool.query(query, [userId, accessToken, userAgent]);
        } catch (error) {
            logger.error(`Database error creating session: ${error}`);
            throw error;
        }
    }

    async updateLogoutTime(userId: string): Promise<void> {
        try {
            const query = `
                UPDATE session SET logout_time = NOW() WHERE user_id = $1;
            `;
            await this.pool.query(query, [userId]);
        } catch (error) {
            logger.error(`Database error updating session logout time: ${error}`);
            throw error;
        }
    }
}
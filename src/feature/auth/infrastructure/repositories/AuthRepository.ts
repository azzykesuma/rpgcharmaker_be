import type { Pool } from "pg";
import logger from "../../../../shared/utils/logger";
import type {
  TCreateUserPayload,
  User,
  UserRepository,
} from "../../domain/User.ts";

export class AuthRepository implements UserRepository {
  private readonly pool: Pool;

  constructor(pool: Pool) {
    this.pool = pool;
  }

  async findByUsername(username: string): Promise<User | null> {
    logger.info(`[AuthRepository] Searching for user by username: ${username}`);
    try {
      const result = await this.pool.query(
        "SELECT * FROM player WHERE player_name = $1",
        [username],
      );
      if (result.rows[0]) {
        logger.info(`[AuthRepository] User found for username: ${username}`);
        return result.rows[0];
      } else {
        logger.info(`[AuthRepository] No user found for username: ${username}`);
        return null;
      }
    } catch (error) {
      logger.error(
        `[AuthRepository] Error finding user by username: ${username} - ${error}`,
      );
      throw error;
    }
  }

  async create(user: TCreateUserPayload): Promise<User> {
    logger.info(
      `[AuthRepository] Creating user with username: ${user.player_name}`,
    );
    try {
      const result = await this.pool.query(
        "INSERT INTO player (player_name, player_password, role) VALUES ($1, $2, $3) RETURNING *",
        [user.player_name, user.player_password, "player"],
      );
      logger.info(
        `[AuthRepository] User created with username: ${user.player_name}`,
      );
      return result.rows[0];
    } catch (error) {
      logger.error(
        `[AuthRepository] Error creating user with username: ${user.player_name} - ${error}`,
      );
      throw error;
    }
  }
}

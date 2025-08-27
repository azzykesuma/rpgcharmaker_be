import { Pool } from "pg";
import {
  IPlayerDetails,
  IPlayerRepository,
  IPlayerResponse,
  IPlayerSelectClassPayload,
  IPlayerSelectWeaponPayload,
} from "../domain/Player";
import { User } from "@/feature/auth/domain/User";

export class PlayerRepository implements IPlayerRepository {
  private readonly pool: Pool;
  constructor(pool: Pool) {
    this.pool = pool;
  }

  async selectMasterClass(
    payload: IPlayerSelectClassPayload,
  ): Promise<IPlayerResponse> {
    const query = `
      UPDATE player
      SET player_class = $1
      WHERE user_id = $2
      `;
    const values = [payload.masterClassId, payload.playerId];
    const result = await this.pool.query(query, values);
    return result.rows[0];
  }

  async selectWeapon(
    payload: IPlayerSelectWeaponPayload,
  ): Promise<IPlayerResponse> {
    const query = `
      UPDATE player
      SET player_weapon = $1
      WHERE user_id = $2
      `;
    const values = [payload.weaponId, payload.playerId];
    const result = await this.pool.query(query, values);
    return result.rows[0];
  }

  async findPlayerById(playerId: string): Promise<IPlayerDetails> {
    const query = `
      SELECT p.player_name, c.class_name, c.class_base_dex, c.class_base_str, c.class_base_int, w.weapon_name, w.weapon_base_damage
      FROM player p
      JOIN master_class c ON p.player_class = c.class_id
      JOIN weapon w ON p.player_weapon = w.weapon_id
      WHERE p.user_id = $1
    `;
    const values = [playerId];
    const result = await this.pool.query(query, values);
    return result.rows[0];
  }
}

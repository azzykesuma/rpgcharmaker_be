import { User } from "../../auth/domain/User";

export interface IPlayerSelectClassPayload {
  masterClassId: number;
  playerId: string;
}

export interface IPlayerSelectWeaponPayload {
  weaponId: number;
  playerId: string;
}

export interface IPlayerResponse {
  message: string;
  statusCode: number;
}

export interface IPlayerDetails {
  player_name: string;
  class_name: string;
  class_base_dex: number;
  class_base_str: number;
  class_base_int: number;
  weapon_name: string;
  weapon_base_damage: number;
}

export interface IPlayerRepository {
  selectMasterClass(
    payload: IPlayerSelectClassPayload,
  ): Promise<IPlayerResponse>;
  selectWeapon(payload: IPlayerSelectWeaponPayload): Promise<IPlayerResponse>;
  findPlayerById(playerId: string): Promise<IPlayerDetails>;
}

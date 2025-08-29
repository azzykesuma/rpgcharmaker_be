import { MasterClassRepository } from "../../master_class/infrastructure/masterClassRepository";
import {
  IPlayerSelectClassPayload,
  IPlayerSelectWeaponPayload,
} from "../domain/Player";
import { PlayerRepository } from "../infrastructure/playerRepository";
import { HttpError } from "../../../shared/utils/httpError";
import { WeaponRepository } from "@/feature/weapon/infrastructure/repositories/weaponRepositories";
import logger from "../../../shared/utils/logger";

export class PlayerService {
  private readonly playerRepository: PlayerRepository;
  private readonly weaponRepository: WeaponRepository;
  private readonly masterClassRepository: MasterClassRepository;
  constructor(
    playerRepository: PlayerRepository,
    masterClassRepository: MasterClassRepository,
    weaponRepository: WeaponRepository,
  ) {
    this.playerRepository = playerRepository;
    this.masterClassRepository = masterClassRepository;
    this.weaponRepository = weaponRepository;
  }

  async selectMasterClass(payload: IPlayerSelectClassPayload) {
    // check if the master class id is valid
    const masterClass = await this.masterClassRepository.getMasterClassById(
      payload.masterClassId,
    );
    if (!masterClass) {
      throw new HttpError("Master class id is not valid", 400);
    }
    return await this.playerRepository.selectMasterClass(payload);
  }

  async selectWeapon(payload: IPlayerSelectWeaponPayload) {
    // check if the weapon id is valid
    const weapon = await this.weaponRepository.findWeapon(payload.weaponId);
    if (!weapon) {
      throw new HttpError("Weapon not found", 404);
    }
    return await this.playerRepository.selectWeapon(payload);
  }

  async getPlayerDetails(playerId: string) {
    logger.info(
      `[PlayerService] Getting player details for player id: ${playerId}`,
    );
    const player = await this.playerRepository.findPlayerById(playerId);
    return player;
  }
}

import { Request, Response } from "express";
import logger from "../../../shared/utils/logger";
import { handleResponse } from "../../../shared/utils/responseHandler";
import { PlayerService } from "../application/player.service";
import {
  IPlayerSelectClassPayload,
  IPlayerSelectWeaponPayload,
} from "../domain/Player";

export class PlayerController {
  private readonly playerService: PlayerService;
  constructor(playerService: PlayerService) {
    this.playerService = playerService;
  }

  async selectMasterClass(req: Request, res: Response) {
    logger.info(`[PlayerController] Selecting master class`);
    if (!req.body.masterClassId) {
      handleResponse(res, {
        error: "Master class id is required",
        statusCode: 400,
      });
      return;
    }
    if (typeof req.body.masterClassId !== "number") {
      handleResponse(res, {
        error: "Master class id must be a number",
        statusCode: 400,
      });
      return;
    }
    const { masterClassId } = req.body;
    const payload: IPlayerSelectClassPayload = {
      masterClassId,
      // @ts-ignore
      playerId: req.user.id,
    };
    logger.info(`[PlayerController] Payload: ${JSON.stringify(payload)}`);

    const player = await this.playerService.selectMasterClass(payload);
    logger.info(`[PlayerController] Player: ${JSON.stringify(player)}`);
    handleResponse(res, {
      message: "Class selected successfully",
      statusCode: 200,
    });
  }

  async selectWeapon(req: Request, res: Response) {
    logger.info(`[PlayerController] Selecting weapon`);
    if (!req.body.weaponId) {
      handleResponse(res, {
        error: "Weapon id is required",
        statusCode: 400,
      });
      return;
    }
    if (typeof req.body.weaponId !== "number") {
      handleResponse(res, {
        error: "Weapon id must be a number",
        statusCode: 400,
      });
      return;
    }
    const { weaponId } = req.body;
    const payload: IPlayerSelectWeaponPayload = {
      weaponId,
      // @ts-ignore
      playerId: req.user.id,
    };

    await this.playerService.selectWeapon(payload);
    handleResponse(res, {
      message: "Weapon selected successfully",
      statusCode: 200,
    });
  }

  async getPlayerDetails(req: Request, res: Response) {
    logger.info(`[PlayerController] Getting player details`);
    // @ts-ignore
    const playerId = req.user.id;
    const player = await this.playerService.getPlayerDetails(playerId);
    if (!player) {
      handleResponse(res, {
        error: "Player not found",
        statusCode: 404,
      });
      return;
    }
    handleResponse(res, {
      message: "Player details fetched successfully",
      statusCode: 200,
      data: player,
    });
  }
}

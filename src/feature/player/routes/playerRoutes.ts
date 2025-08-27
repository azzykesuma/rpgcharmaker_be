import jwtAuthMiddleware from "../../../shared/middleware/JwtAuthMiddleware";
import { asyncWrapper } from "../../../shared/utils/asyncWrapper";
import { Router } from "express";
import { PlayerController } from "../interface/player.controller";
import { PlayerService } from "../application/player.service";
import { PlayerRepository } from "../infrastructure/playerRepository";
import pool from "../../../config/dbConfig";
import { MasterClassRepository } from "../../master_class/infrastructure/masterClassRepository";
import { WeaponRepository } from "../../weapon/infrastructure/repositories/weaponRepositories";

const playerRouter = Router();

const playerRepository = new PlayerRepository(pool);
const masterClassRepository = new MasterClassRepository(pool);
const weaponRepository = new WeaponRepository(pool);
const playerService = new PlayerService(
  playerRepository,
  masterClassRepository,
  weaponRepository,
);
const playerController = new PlayerController(playerService);

playerRouter.post(
  "/select-class",
  jwtAuthMiddleware,
  asyncWrapper(async (req, res) => {
    await playerController.selectMasterClass(req, res);
  }),
);
playerRouter.post(
  "/select-weapon",
  jwtAuthMiddleware,
  asyncWrapper(async (req, res) => {
    await playerController.selectWeapon(req, res);
  }),
  playerRouter.get(
    "/get-player-details",
    jwtAuthMiddleware,
    asyncWrapper(async (req, res) => {
      await playerController.getPlayerDetails(req, res);
    }),
  ),
);

export default playerRouter;

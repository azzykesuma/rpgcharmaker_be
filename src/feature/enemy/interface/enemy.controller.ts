import type { Request, Response } from "express";

import logger from "../../../shared/utils/logger";
import { handleResponse } from "../../../shared/utils/responseHandler";
import type {
  IEnemyCreate,
  IEnemyUpdateImage,
  IEnemyUpdateInfo,
} from "../domain/Enemy";
import { HttpError } from "../../../shared/utils/httpError";
import parser from "../../../shared/utils/parser";
import path from "path";
import type { EnemyService } from "../application/enemyService";

export class EnemyController {
  private readonly enemyService: EnemyService;
  constructor(enemyService: EnemyService) {
    this.enemyService = enemyService;
  }

  async createEnemy(req: Request, res: Response): Promise<void> {
    logger.info(`EnemyController: Creating enemy with form-data payload`);
    try {
      const {
        enemy_name,
        enemy_base_hp,
        enemy_base_mp,
        enemy_base_dex,
        enemy_base_int,
        enemy_base_constitution,
        enemy_resistance,
        enemy_weakness,
      } = req.body;

      const enemy_image = req.file?.buffer;
      if (!enemy_image) {
        handleResponse(res, {
          error: "Enemy image is required",
          statusCode: 400,
        });
        return;
      }
      const dataUri = (req: Request) =>
        parser.format(
          path.extname(req.file?.originalname || "").toString(),
          req.file?.buffer || Buffer.from(""),
        );
      const imageUrl = dataUri(req);

      if (
        !enemy_name ||
        !enemy_base_hp ||
        !enemy_base_mp ||
        !enemy_base_dex ||
        !enemy_base_int ||
        !enemy_base_constitution ||
        !enemy_resistance ||
        !enemy_weakness ||
        !imageUrl
      ) {
        handleResponse(res, {
          error:
            "All fields (enemy_name, enemy_base_hp, enemy_base_mp, enemy_base_dex, enemy_base_int, enemy_base_constitution, enemy_resistance, enemy_weakness, enemy_image) are required and must be valid.",
          statusCode: 400,
        });
        return;
      }

      const payload: IEnemyCreate = {
        enemy_name: String(enemy_name),
        enemy_base_hp: Number(enemy_base_hp),
        enemy_base_mp: Number(enemy_base_mp),
        enemy_base_dex: Number(enemy_base_dex),
        enemy_base_int: Number(enemy_base_int),
        enemy_base_constitution: Number(enemy_base_constitution),
        enemy_resistance: Number(enemy_resistance),
        enemy_weakness: Number(enemy_weakness),
        enemy_image: String(imageUrl.content),
      };

      const enemy = await this.enemyService.createEnemy(payload);

      handleResponse(res, {
        data: enemy,
        message: "Enemy created successfully",
      });
    } catch (error) {
      handleResponse(res, {
        error: error instanceof HttpError ? error.message : "An error occurred",
        statusCode: error instanceof HttpError ? error.statusCode : 500,
      });
    }
  }

  async getEnemies(req: Request, res: Response): Promise<void> {
    logger.info(`EnemyController: Getting all enemies`);
    try {
      const enemies = await this.enemyService.getEnemies();
      handleResponse(res, {
        data: enemies,
        message: "Enemies fetched successfully",
      });
    } catch (error) {
      handleResponse(res, {
        error: error instanceof HttpError ? error.message : "An error occurred",
        statusCode: error instanceof HttpError ? error.statusCode : 500,
      });
    }
  }

  async getEnemyById(req: Request, res: Response): Promise<void> {
    logger.info(`EnemyController: Getting enemy by id`);
    try {
      const { id } = req.params;
      const enemy = await this.enemyService.getEnemyById(id);
      handleResponse(res, {
        data: enemy,
        message: "Enemy fetched successfully",
      });
    } catch (error) {
      handleResponse(res, {
        error: error instanceof HttpError ? error.message : "An error occurred",
        statusCode: error instanceof HttpError ? error.statusCode : 500,
      });
    }
  }

  async updateEnemyInfo(req: Request, res: Response): Promise<void> {
    logger.info(`EnemyController: Updating enemy info`);
    try {
      const { id } = req.params;
      const {
        enemy_name,
        enemy_base_hp,
        enemy_base_mp,
        enemy_base_dex,
        enemy_base_int,
        enemy_base_constitution,
        enemy_resistance,
        enemy_weakness,
      } = req.body;
      if (
        !enemy_name ||
        !enemy_base_hp ||
        !enemy_base_mp ||
        !enemy_base_dex ||
        !enemy_base_int ||
        !enemy_base_constitution ||
        !enemy_resistance ||
        !enemy_weakness
      ) {
        handleResponse(res, {
          error: "All fields are required",
          statusCode: 400,
        });
        return;
      }
      const payload: IEnemyUpdateInfo = {
        enemy_id: id,
        enemy_name: enemy_name,
        enemy_base_hp: enemy_base_hp,
        enemy_base_mp: enemy_base_mp,
        enemy_base_dex: enemy_base_dex,
        enemy_base_int: enemy_base_int,
        enemy_base_constitution: enemy_base_constitution,
        enemy_resistance: Number(enemy_resistance),
        enemy_weakness: Number(enemy_weakness),
      };
      const enemy = await this.enemyService.updateEnemyInfo(payload);
      if (!enemy) {
        handleResponse(res, {
          error: "Enemy not found",
          statusCode: 404,
        });
        return;
      }
      handleResponse(res, {
        data: enemy,
        message: "Enemy info updated successfully",
      });
    } catch (error) {
      handleResponse(res, {
        error: error instanceof HttpError ? error.message : "An error occurred",
        statusCode: error instanceof HttpError ? error.statusCode : 500,
      });
    }
  }

  async updateEnemyImage(req: Request, res: Response): Promise<void> {
    logger.info(`EnemyController: Updating enemy image`);
    try {
      const { id } = req.params;
      const enemy_image = req.file?.buffer;
      console.log(enemy_image);
      if (!enemy_image) {
        handleResponse(res, {
          error: "Enemy image is required",
          statusCode: 400,
        });
        return;
      }
      const dataUri = (req: Request) =>
        parser.format(
          path.extname(req.file?.originalname || "").toString(),
          req.file?.buffer || Buffer.from(""),
        );
      const imageUrl = dataUri(req);
      if (!imageUrl) {
        handleResponse(res, {
          error: "Enemy image is required",
          statusCode: 400,
        });
        return;
      }
      const payload: IEnemyUpdateImage = {
        enemy_id: id,
        enemy_image: String(imageUrl.content),
      };
      const enemy = await this.enemyService.updateEnemyImage(payload);
      handleResponse(res, {
        data: enemy,
        message: "Enemy image updated successfully",
      });
    } catch (error) {
      handleResponse(res, {
        error: error instanceof HttpError ? error.message : "An error occurred",
        statusCode: error instanceof HttpError ? error.statusCode : 500,
      });
    }
  }

  async deleteEnemy(req: Request, res: Response): Promise<void> {
    logger.info(`EnemyController: Deleting enemy`);
    try {
      const { id } = req.params;
      const enemy = await this.enemyService.deleteEnemy(id);
      handleResponse(res, {
        data: enemy,
        message: "Enemy deleted successfully",
      });
    } catch (error) {
      handleResponse(res, {
        error: error instanceof HttpError ? error.message : "An error occurred",
        statusCode: error instanceof HttpError ? error.statusCode : 500,
      });
    }
  }
}

import { Router } from "express";
import { EnemyService } from "../application/enemyService";
import { EnemyController } from "../interface/enemy.controller";
import { EnemyRepository } from "../infrastructure/repository/EnemyRepository";
import { CloudStorageService } from "../../../shared/cloudService/CloudStorageService";
import pool from "../../../config/dbConfig";
import multer from "multer";
import jwtAuthMiddleware from "../../../shared/middleware/JwtAuthMiddleware";

const enemyRouter = Router();
const upload = multer({ storage: multer.memoryStorage() });

const enemyRepository = new EnemyRepository(pool);
const cloudStorageService = new CloudStorageService();
const enemyService = new EnemyService(enemyRepository, cloudStorageService);
const enemyController = new EnemyController(enemyService);

enemyRouter.post(
  "/",
  jwtAuthMiddleware,
  upload.single("enemy_image"),
  (req, res) => {
    enemyController.createEnemy(req, res);
  },
);
enemyRouter.get("/details/:id", jwtAuthMiddleware, (req, res) => {
  enemyController.getEnemyById(req, res);
});
enemyRouter.get("/", jwtAuthMiddleware, (req, res) => {
  enemyController.getEnemies(req, res);
});
enemyRouter.put("/details/:id", jwtAuthMiddleware, (req, res) => {
  enemyController.updateEnemyInfo(req, res);
});
enemyRouter.put("/image/:id", jwtAuthMiddleware, (req, res) => {
  enemyController.updateEnemyImage(req, res);
});
enemyRouter.delete("/:id", jwtAuthMiddleware, (req, res) => {
  enemyController.deleteEnemy(req, res);
});

export default enemyRouter;

import { Router } from "express";
import jwtAuthMiddleware from "../../../shared/middleware/JwtAuthMiddleware";
import multer from "multer";
import { WeaponController } from "../interface/weapon.controller";
import { WeaponService } from "../application/WeaponService";
import { WeaponRepository } from "../infrastructure/repositories/weaponRepositories";
import pool from "../../../config/dbConfig";
import { CloudStorageService } from "../../../shared/cloudService/CloudStorageService";

const weaponRouter = Router();
const upload = multer({ storage: multer.memoryStorage() });
const weaponRepository = new WeaponRepository(pool);
const storageService = new CloudStorageService();
const weaponService = new WeaponService(weaponRepository, storageService);
const weaponController = new WeaponController(weaponService);

weaponRouter.post(
  "/",
  jwtAuthMiddleware,
  upload.single("weapon_image"),
  (req, res) => {
    weaponController.create(req, res);
  },
);
weaponRouter.get("/", jwtAuthMiddleware, (req, res) => {
  weaponController.getWeapons(req, res);
});
weaponRouter.put("/update-info/:id", jwtAuthMiddleware, (req, res) => {
  weaponController.updateInfo(req, res);
});
weaponRouter.put(
  "/update-image/:id",
  jwtAuthMiddleware,
  upload.single("weapon_image"),
  (req, res) => {
    weaponController.updateImage(req, res);
  },
);
weaponRouter.delete("/:id", jwtAuthMiddleware, (req, res) => {
  weaponController.deleteWeapon(req, res);
});
export default weaponRouter;

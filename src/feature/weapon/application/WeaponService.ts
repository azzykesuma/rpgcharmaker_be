import { HttpError } from "../../../shared/utils/httpError.ts";
import type { IWeapon, IWeaponCreate, IWeaponRepository, IWeaponUpdate, IWeaponUpdateImage } from "../domain/Weapon.ts";
import type { CloudStorageService } from "./CloudStorageService.ts";


export class WeaponService {
    private readonly storageService: CloudStorageService;
    private readonly weaponRepository: IWeaponRepository;
    constructor(weaponRepository: IWeaponRepository, storageService: CloudStorageService) {
        this.weaponRepository = weaponRepository;
        this.storageService = storageService;
    }

    async create(weapon: IWeaponCreate): Promise<IWeapon> {
        try {
            // check if the name is already taken
            const existingWeapon = await this.weaponRepository.findWeaponByName(weapon.weapon_name);
            if (existingWeapon) {
                throw new HttpError("Weapon name already taken", 400);
            }
            const imageUrl = await this.storageService.uploadImage(weapon.weapon_image);
            const payload = {
                ...weapon,
                weapon_image: imageUrl,
            } as unknown as IWeaponCreate;
            return await this.weaponRepository.create(payload);
        } catch (error) {
            throw error;
        }
    }

    async getWeapons(): Promise<IWeapon[]> {
        try {
            return await this.weaponRepository.getWeapons();
        } catch (error) {
            throw error;
        }
    }

    async updateInfo(weapon: IWeaponUpdate): Promise<IWeapon> {
        try {
            // check if the name is already taken
            const existingWeapon = await this.weaponRepository.findWeapon(weapon.weapon_id);
            if (existingWeapon.weapon_name === weapon.weapon_name) {
                throw new HttpError("Weapon name already taken", 400);
            }
            return await this.weaponRepository.updateInfo(weapon);
        } catch (error) {
            throw error;
        }
    }

    async updateImage(weapon: IWeaponUpdateImage): Promise<IWeapon> {
        try {
            const imageUrl = await this.storageService.uploadImage(weapon.weapon_image);
            const payload = {
                ...weapon,
                weapon_image: imageUrl,
            } as unknown as IWeaponUpdateImage;
            return await this.weaponRepository.updateImage(payload);
        } catch (error) {
            throw error;
        }
    }

    async deleteWeapon(weapon_id: number): Promise<IWeapon> {
        try {
            return await this.weaponRepository.deleteWeapon(weapon_id);
        } catch (error) {
            throw error;
        }
    }
}
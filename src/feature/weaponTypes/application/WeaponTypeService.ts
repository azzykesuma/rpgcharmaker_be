import type { ICreateWeaponTypes, IWeaponTypes, IWeaponTypesRepository } from "../domain/WeaponTypes.ts";
import { HttpError } from "../../../shared/utils/httpError.ts";
import logger from "../../../shared/utils/logger.ts";

export class WeaponTypeService {
    private readonly weaponTypesRepository: IWeaponTypesRepository;

    constructor(weaponTypesRepository: IWeaponTypesRepository) {
        this.weaponTypesRepository = weaponTypesRepository;
    }

    async findAll(): Promise<IWeaponTypes[]> {
        const weaponTypes = await this.weaponTypesRepository.findAll();
        return weaponTypes;
    }

    async create(weaponTypes: ICreateWeaponTypes): Promise<IWeaponTypes> {
        logger.info(`[WeaponTypeService] Creating weapon type`);
        const weaponName = weaponTypes.weapon_type_name.toLowerCase();
        const existingWeaponType = await this.weaponTypesRepository.findByName(weaponName);
        if (existingWeaponType) {
            throw new HttpError("Weapon type already exists", 400);
        }
        const weaponType = await this.weaponTypesRepository.create(weaponTypes);
        return weaponType;
    }

    async findByName(weaponName: string): Promise<IWeaponTypes | null> {
        logger.info(`[WeaponTypeService] Finding weapon type by name`);
        const weaponType = await this.weaponTypesRepository.findByName(weaponName);
        return weaponType;
    }

    async delete(weaponId: number): Promise<void> {
        await this.weaponTypesRepository.delete(weaponId);
    }
}
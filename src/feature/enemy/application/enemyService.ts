import type { CloudStorageService } from "../../../shared/cloudService/CloudStorageService.ts";
import type { IEnemy, IEnemyCreate, IEnemyUpdateImage, IEnemyUpdateInfo } from "../domain/Enemy.ts";
import type { IEnemyRepository } from "../domain/Enemy.ts";

export class EnemyService {
    private readonly enemyRepository: IEnemyRepository;
    private readonly cloudStorageService : CloudStorageService;
    constructor(enemyRepository: IEnemyRepository, cloudStorageService: CloudStorageService) {
        this.enemyRepository = enemyRepository;
        this.cloudStorageService = cloudStorageService;
    }

    async createEnemy(enemy: IEnemyCreate): Promise<IEnemy> {
        const imageUrl = await this.cloudStorageService.uploadImage(enemy.enemy_image);
        const payload = {
            ...enemy,
            enemy_image: imageUrl,
        } as unknown as IEnemyCreate;
        try {
            return await this.enemyRepository.create(payload);
        } catch (error) {
            throw error;
        }
    }

    async getEnemies(): Promise<IEnemy[]> {
        try {
            return await this.enemyRepository.getEnemies();
        } catch (error) {
            throw error;
        }
    }

    async getEnemyById(enemy_id: string): Promise<IEnemy> {
        try {
            return await this.enemyRepository.getEnemyById(enemy_id);
        } catch (error) {
            console.log(error)
            throw error;
        }
    }

    async updateEnemyInfo(enemy: IEnemyUpdateInfo): Promise<IEnemy> {
        console.log(enemy)
        try {
            return await this.enemyRepository.updateEnemyInfo(enemy);
        } catch (error) {
            console.log(error)
            throw error;
        }
    }

    async updateEnemyImage(enemy: IEnemyUpdateImage): Promise<IEnemy> {
        try {
            return await this.enemyRepository.updateEnemyImage(enemy);
        } catch (error) {
            throw error;
        }
    }

    async deleteEnemy(enemy_id: string): Promise<IEnemy> {
        try {
            return await this.enemyRepository.deleteEnemy(enemy_id);
        } catch (error) {
            throw error;
        }
    }
}
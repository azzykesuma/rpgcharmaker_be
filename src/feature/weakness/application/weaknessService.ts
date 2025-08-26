import { HttpError } from "../../../shared/utils/httpError";
import type {
  IWeakness,
  IWeaknessCreate,
  IWeaknessRepository,
  IWeaknessUpdate,
} from "../domain/Weakness";

export class WeaknessService {
  private readonly weaknessRepository: IWeaknessRepository;
  constructor(weaknessRepository: IWeaknessRepository) {
    this.weaknessRepository = weaknessRepository;
  }

  async create(weakness: IWeaknessCreate): Promise<IWeakness> {
    try {
      // check if the weakness type is already taken
      const existingWeakness = await this.weaknessRepository.findWeaknessByType(
        weakness.weakness_type,
      );
      if (existingWeakness) {
        throw new HttpError("Weakness type already taken", 400);
      }
      return await this.weaknessRepository.create(weakness);
    } catch (error) {
      throw new HttpError(
        error instanceof Error ? error.message : "An error occurred",
        500,
      );
    }
  }

  async getWeaknesses(): Promise<IWeakness[]> {
    try {
      return await this.weaknessRepository.getWeaknesses();
    } catch (error) {
      throw error;
    }
  }

  async updateWeakness(weakness: IWeaknessUpdate): Promise<IWeakness> {
    try {
      return await this.weaknessRepository.updateWeakness(weakness);
    } catch (error) {
      throw error;
    }
  }

  async deleteWeakness(weakness_id: number): Promise<IWeakness> {
    try {
      return await this.weaknessRepository.deleteWeakness(weakness_id);
    } catch (error) {
      throw error;
    }
  }
}

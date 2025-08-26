import { HttpError } from "../../../shared/utils/httpError";
import type {
  IResistance,
  IResistanceCreate,
  IResistanceRepository,
  IResistanceUpdate,
} from "../domain/Resistance.ts";

export class ResistanceService {
  private readonly resistanceRepository: IResistanceRepository;
  constructor(resistanceRepository: IResistanceRepository) {
    this.resistanceRepository = resistanceRepository;
  }

  async create(resistance: IResistanceCreate): Promise<IResistance> {
    try {
      // check if the type is already taken
      const existingResistance =
        await this.resistanceRepository.findResistanceByType(
          resistance.resistance_type,
        );
      if (existingResistance) {
        throw new HttpError("Resistance type already taken", 400);
      }
      return await this.resistanceRepository.create(resistance);
    } catch (error) {
      throw error;
    }
  }

  async getResistances(): Promise<IResistance[]> {
    try {
      return await this.resistanceRepository.getResistances();
    } catch (error) {
      throw error;
    }
  }

  async updateResistance(resistance: IResistanceUpdate): Promise<IResistance> {
    try {
      return await this.resistanceRepository.updateResistance(resistance);
    } catch (error) {
      throw error;
    }
  }

  async deleteResistance(resistance_id: number): Promise<IResistance> {
    try {
      return await this.resistanceRepository.deleteResistance(resistance_id);
    } catch (error) {
      throw error;
    }
  }
}

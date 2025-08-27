import { HttpError } from "../../../shared/utils/httpError";
import type {
  BaseResponse,
  IMasterClass,
  IMasterClassCreate,
  IMasterClassRepository,
} from "../domain/MasterClass";

export class MasterClassService {
  private readonly masterClassRepository: IMasterClassRepository;
  constructor(masterClassRepository: IMasterClassRepository) {
    this.masterClassRepository = masterClassRepository;
  }

  async createMasterClass(masterClass: IMasterClassCreate): Promise<boolean> {
    const existingMasterClass =
      await this.masterClassRepository.getMasterClassByName(
        masterClass.class_name,
      );
    if (existingMasterClass) {
      throw new HttpError("Master class already exists", 400);
    }
    await this.masterClassRepository.createMasterClass(masterClass);
    return true;
  }

  async getMasterClasses(): Promise<BaseResponse<Array<IMasterClass>>> {
    const masterClasses = await this.masterClassRepository.getMasterClasses();
    return {
      message: "Master classes fetched successfully",
      statusCode: 200,
      data: masterClasses,
    };
  }

  async getMasterClassById(id: string): Promise<IMasterClass> {
    const masterClass = await this.masterClassRepository.getMasterClassById(id);
    if (!masterClass) {
      throw new HttpError("Master class not found", 404);
    }
    return masterClass;
  }

  async updateMasterClass(
    payload: IMasterClassCreate & { id: string },
  ): Promise<boolean> {
    const existingMasterClass =
      await this.masterClassRepository.getMasterClassById(payload.id);
    if (!existingMasterClass) {
      throw new HttpError("Master class not found", 404);
    }
    await this.masterClassRepository.updateMasterClass(payload);
    return true;
  }

  async deleteMasterClass(id: string): Promise<boolean> {
    const existingMasterClass =
      await this.masterClassRepository.getMasterClassById(id);
    if (!existingMasterClass) {
      throw new HttpError("Master class not found", 404);
    }
    await this.masterClassRepository.deleteMasterClass(id);
    return true;
  }
}

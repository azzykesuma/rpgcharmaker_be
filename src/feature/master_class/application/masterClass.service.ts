import type {
  BaseResponse,
  IMasterClassCreate,
  IMasterClassRepository,
} from "../domain/MasterClass";
import logger from "../../../shared/utils/logger";
import { HttpError } from "../../../shared/utils/httpError";

export class MasterClassService {
  private readonly masterClassRepository: IMasterClassRepository;
  constructor(masterClassRepository: IMasterClassRepository) {
    this.masterClassRepository = masterClassRepository;
  }

  async createMasterClass(
    masterClass: IMasterClassCreate,
  ): Promise<BaseResponse> {
    try {
      // check if the master class already exists
      const existingMasterClass =
        await this.masterClassRepository.getMasterClassByName(
          masterClass.class_name,
        );
      if (existingMasterClass) {
        return { message: "Master class already exists", statusCode: 400 };
      }
      const baseResponse = await this.masterClassRepository.createMasterClass(
        masterClass,
      );
      return baseResponse;
    } catch (error) {
      logger.error(
        `[MasterClassService] Error creating master class: ${
          error instanceof HttpError ? error.message : "An error occurred"
        }`,
      );
      return {
        message:
          error instanceof HttpError ? error.message : "An error occurred",
        statusCode: 500,
      };
    }
  }
}

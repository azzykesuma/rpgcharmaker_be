import type { Request, Response } from "express";
import { MasterClassService } from "../application/masterClass.service";
import logger from "../../../shared/utils/logger";
import { handleResponse } from "../../../shared/utils/responseHandler";

export class MasterClassController {
  private readonly masterClassService: MasterClassService;
  constructor(masterClassService: MasterClassService) {
    this.masterClassService = masterClassService;
  }

  async create(req: Request, res: Response) {
    logger.info(
      `[MasterClassController] Creating master class with payload: ${JSON.stringify(
        req.body,
      )}`,
    );
    if (
      !req.body.class_name ||
      !req.body.class_main_stat ||
      !req.body.class_base_dex ||
      !req.body.class_base_int ||
      !req.body.class_base_hp ||
      !req.body.class_base_mp ||
      !req.body.class_base_str
    ) {
      handleResponse(res, {
        error:
          "All fields (class_name, class_main_stat) are required and must be valid.",
        statusCode: 400,
      });
      return;
    }
    const {
      class_name,
      class_base_dex,
      class_base_int,
      class_base_hp,
      class_base_mp,
      class_base_str,
      class_main_stat,
    } = req.body;
    const masterClass = await this.masterClassService.createMasterClass({
      class_name: class_name,
      class_base_dex: class_base_dex,
      class_base_int: class_base_int,
      class_base_hp: class_base_hp,
      class_base_mp: class_base_mp,
      class_base_str: class_base_str,
      class_main_stat: class_main_stat,
    });
    res.status(200).json(masterClass);
  }

  // async getMasterClasses(req: Request, res: Response) {
  //   const masterClasses = await this.masterClassService.getMasterClasses();
  //   res.status(200).json(masterClasses);
  // }
}

// {
//   "class_name" : "Monk",
//   "class_base_dex" : 90,
//   "class_base_int" : 70,
//   "class_base_str" : 60,
//   "class_base_hp" : 80,
//   "class_base_mp" : 90,
//   "class_main_stat" : "dex"
// }

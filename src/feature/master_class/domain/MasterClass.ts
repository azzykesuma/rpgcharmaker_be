import type { ResponseOptions } from "../../../shared/utils/responseHandler.ts";

export interface IMasterClass {
  class_id: number;
  class_name: string;
  class_base_dex: number;
  class_base_int: number;
  class_base_hp: number;
  class_base_mp: number;
  class_base_str: number;
  class_main_stat: "str";
}

export interface IMasterClassCreate {
  class_name: string;
  class_base_dex: number;
  class_base_int: number;
  class_base_hp: number;
  class_base_mp: number;
  class_base_str: number;
  class_main_stat: string;
}

export interface BaseResponse {
  message: string;
  statusCode: ResponseOptions["statusCode"];
}

export interface IMasterClassRepository {
  createMasterClass(masterClass: IMasterClassCreate): Promise<BaseResponse>;
  getMasterClassByName(className: string): Promise<IMasterClass>;
}

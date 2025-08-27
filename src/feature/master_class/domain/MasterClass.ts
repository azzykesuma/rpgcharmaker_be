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

export interface BaseResponse<T> {
  message: string;
  statusCode: ResponseOptions["statusCode"];
  data?: T;
}

export type NoDataResponse = Omit<BaseResponse<undefined>, "data">;

export interface IMasterClassRepository {
  createMasterClass(masterClass: IMasterClassCreate): Promise<boolean>;
  getMasterClassByName(className: string): Promise<IMasterClass>;
  getMasterClasses(): Promise<IMasterClass[]>;
  getMasterClassById(id: number): Promise<IMasterClass>;
  updateMasterClass(
    payload: IMasterClassCreate & { id: number },
  ): Promise<boolean>;
  deleteMasterClass(id: number): Promise<boolean>;
}

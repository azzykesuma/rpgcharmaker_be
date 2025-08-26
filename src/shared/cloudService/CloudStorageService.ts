import { v2 as cloudinary } from "cloudinary";
import { CLOUD_STORAGE_CONFIGS } from "../constant";

export class CloudStorageService {
  constructor() {
    cloudinary.config({
      cloud_name: CLOUD_STORAGE_CONFIGS.CLOUD_NAME,
      api_key: CLOUD_STORAGE_CONFIGS.APIKEY,
      api_secret: CLOUD_STORAGE_CONFIGS.SECRET,
    });
  }
  public async uploadImage(file: string): Promise<string> {
    const result = await cloudinary.uploader.upload(file, {
      resource_type: "image",
      fetch_format: "auto",
      quality: "auto",
      format: "webp",
    });
    return result.secure_url;
  }
}

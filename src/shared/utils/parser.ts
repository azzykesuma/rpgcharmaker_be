import DatauriParser from "datauri/parser.js";
import path from "path";

/**
 * Creates a data URI string from a file buffer.
 * @param file The multer file object.
 * @returns The data URI content as a string.
 */
export const formatDataUri = (file: Express.Multer.File): string => {
  const parser = new DatauriParser();
  parser.format(path.extname(file.originalname).toString(), file.buffer);
  return parser.content as string;
};

import { ResponseOptions } from "./responseHandler";

export class HttpError extends Error {
  public statusCode: ResponseOptions["statusCode"];

  constructor(message: string, statusCode: ResponseOptions["statusCode"]) {
    super(message);
    this.name = "HttpError";
    this.statusCode = statusCode || 500;

    // This is important for V8 to correctly capture the stack trace
    Object.setPrototypeOf(this, HttpError.prototype);
  }
}

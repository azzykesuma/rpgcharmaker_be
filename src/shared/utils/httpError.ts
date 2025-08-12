export class HttpError extends Error {
    public statusCode: number;
  
    constructor(message: string, statusCode: number) {
      super(message);
      this.name = 'HttpError';
      this.statusCode = statusCode;
  
      // This is important for V8 to correctly capture the stack trace
      Object.setPrototypeOf(this, HttpError.prototype);
    }
  }
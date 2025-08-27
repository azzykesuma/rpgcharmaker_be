import type { Response } from "express";

export interface ResponseOptions {
  data?: unknown;
  error?: string;
  statusCode?: 200 | 201 | 400 | 404 | 500 | 401;
  message?: string;
}

export function handleResponse(res: Response, options: ResponseOptions) {
  const { data, error, statusCode = 200, message } = options;
  console.log("");
  if (error) {
    return res.status(statusCode).json({
      success: false,
      error,
      statusCode,
    });
  }
  return res.status(statusCode).json({
    success: true,
    data,
    statusCode,
    message,
  });
}

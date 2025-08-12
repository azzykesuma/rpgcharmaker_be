import type { Response } from 'express';

interface ResponseOptions {
  data?: unknown;
  error?: string;
  statusCode?: number;
  message?: string;
}

export function handleResponse(res: Response, options: ResponseOptions) {
  const { data, error, statusCode = 200, message } = options;
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

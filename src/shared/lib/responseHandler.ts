import type { Response } from 'express';

interface ResponseOptions {
  data?: unknown;
  error?: string;
  statusCode?: number;
}

export function handleResponse(res: Response, options: ResponseOptions) {
  const { data, error, statusCode = 200 } = options;
  if (error) {
    return res.status(statusCode).json({
      success: false,
      error,
    });
  }
  return res.status(statusCode).json({
    success: true,
    data,
    statusCode,
  });
}

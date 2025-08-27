// utils/asyncWrapper.ts
import { Request, Response, NextFunction } from "express";

export const asyncWrapper = (
  fn: (req: Request, res: Response, next: NextFunction) => Promise<any>,
) => {
  return (req: Request, res: Response, next: NextFunction) => {
    // The Promise.resolve() ensures that even if fn is not async,
    // we still get a promise back. The .catch(next) will
    // automatically pass any thrown errors or rejected promises
    // to Express's error handling middleware.
    Promise.resolve(fn(req, res, next)).catch(next);
  };
};

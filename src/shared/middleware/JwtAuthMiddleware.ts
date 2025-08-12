import type { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";
import { JWT_SECRET_KEY } from "../constant.ts";
import type { JWTUser } from "../../feature/auth/domain/User.ts";

declare global {
  interface Request {
    user?: JWTUser;
  }
}

const jwtAuthMiddleware = (
  req: Request & { user?: JWTUser },
  res: Response,
  next: NextFunction
) => {
  const authHeader = req.headers["authorization"];
  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.status(401).json({ message: "Authorization header missing or malformed" });
  }

  const token = authHeader.split(" ")[1];
  if (!token) {
    return res.status(401).json({ message: "Token not provided" });
  }

  try {
    if (!JWT_SECRET_KEY) {
      throw new Error("JWT secret key is not defined");
    }
    const decoded = jwt.verify(token, JWT_SECRET_KEY) as JWTUser;
    req.user = decoded;
    next();
  } catch (err) {
    console.error(err);
    return res.status(401).json({ message: "Invalid or expired token" });
  }
};

export default jwtAuthMiddleware;

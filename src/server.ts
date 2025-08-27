import config from "./config/config";
import app from "./index";
import express from "express";
import cors from "cors";

app.listen(config.port, () => {
  console.log(`Server is running on port ${config.port}`);
});

export function createServer() {
  const app = express();
  app.use(express.json());
  app.use(cors());
  app.use(express.urlencoded({ extended: true }));

  return app;
}

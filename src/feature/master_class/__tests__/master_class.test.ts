import { MasterClassService } from "../application/masterClass.service";
import { MasterClassController } from "../interface/master_class.controller";
import request from "supertest";
import express from "express";
import masterClassRouter from "../routes/masterClassRoutes";

describe("MasterClass API (integration)", () => {
  const app = express();
  app.use(express.json());
  app.use("/api/master-class", masterClassRouter);
  it("should create a master class via POST /api/master-class", async () => {
    const response = await request(app)
      .post("/api/master-class")
      .send({
        class_name: "Mage",
        class_base_dex: 90,
        class_base_int: 70,
        class_base_str: 60,
        class_base_hp: 80,
        class_base_mp: 90,
        class_main_stat: "int",
      })
      .set("Content-Type", "application/json")
      .expect(200);
    expect(response.body).toEqual(
      expect.objectContaining({
        message: "Master class created successfully",
        statusCode: 200,
      }),
    );
  });
});

jest.mock("../application/masterClass.service.ts");
const mockMasterClassService = jest.mocked(MasterClassService);

describe("Master Class", () => {
  it("should be able to create a master class", async () => {
    mockMasterClassService.prototype.createMasterClass.mockResolvedValue({
      message: "Master class created successfully",
      statusCode: 200,
    });
    const masterClassController = new MasterClassController(
      mockMasterClassService.prototype,
    );
    const req = {
      body: {
        class_name: "Master Class",
        class_main_stat: "str",
        class_base_dex: 10,
        class_base_int: 10,
        class_base_hp: 100,
        class_base_mp: 100,
        class_base_str: 10,
      },
    };
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn().mockReturnThis(),
    };
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    await masterClassController.create(req as any, res as any);
    expect(res.status).toHaveBeenCalledWith(200);
    expect(res.json).toHaveBeenCalledWith({
      message: "Master class created successfully",
      statusCode: 200,
    });
  });
});

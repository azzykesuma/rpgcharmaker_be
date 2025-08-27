import jwt from "jsonwebtoken";
import supertest from "supertest";
import app from "../../../index";
import { HttpError } from "../../../shared/utils/httpError";
import { MasterClassService } from "../application/masterClass.service";
import { IMasterClassCreate } from "../domain/MasterClass";

const masterClassPayload: IMasterClassCreate = {
  class_name: "Test Master Class",
  class_base_dex: 100,
  class_base_int: 100,
  class_base_hp: 100,
  class_base_mp: 100,
  class_base_str: 100,
  class_main_stat: "dex",
};
const userPayload = {
  id: "123",
  username: "testuser",
  role: "admin",
};

describe("Master Class", () => {
  describe("Create Master Class", () => {
    it("should successfully create a master class", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
      const token = jwt.sign(userPayload, process.env.JWT_SECRET_KEY as string);
      const createMasterClassSpy = jest
        .spyOn(MasterClassService.prototype, "createMasterClass")
        .mockResolvedValue(Promise.resolve(true));
      const response = await supertest(app)
        .post("/api/master-class")
        .set("Authorization", `Bearer ${token}`)
        .send(masterClassPayload);
      expect(response.status).toBe(200);
      expect(response.body).toEqual({
        message: "Master class created successfully",
        statusCode: 200,
        success: true,
      });
      expect(createMasterClassSpy).toHaveBeenCalledWith(masterClassPayload);
    });
    it("should return 400 if the class is already exists", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
      const token = jwt.sign(userPayload, process.env.JWT_SECRET_KEY as string);
      const createMasterClassSpy = jest
        .spyOn(MasterClassService.prototype, "createMasterClass")
        .mockRejectedValue(new HttpError("Master class already exists", 400));
      const response = await supertest(app)
        .post("/api/master-class")
        .set("Authorization", `Bearer ${token}`)
        .send(masterClassPayload);
      expect(response.status).toBe(400);
      expect(response.body).toEqual({
        error: "Master class already exists",
        statusCode: 400,
      });
      expect(createMasterClassSpy).toHaveBeenCalledWith(masterClassPayload);
    });
    it("should return 401 if the user is not authenticated", async () => {
      const response = await supertest(app)
        .post("/api/master-class")
        .send(masterClassPayload);
      expect(response.status).toBe(401);
      expect(response.body).toEqual({
        message: "Authorization header missing or malformed",
        statusCode: 401,
      });
    });
    it("should return 400 if one of the fields is missing", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
      const token = jwt.sign(userPayload, process.env.JWT_SECRET_KEY as string);
      const createMasterClassSpy = jest.spyOn(
        MasterClassService.prototype,
        "createMasterClass",
      );
      const response = await supertest(app)
        .post("/api/master-class")
        .set("Authorization", `Bearer ${token}`)
        .send({
          class_name: "Test Master Classz",
          class_base_dex: 100,
          class_base_int: 100,
          class_base_hp: 100,
        });
      expect(response.status).toBe(400);
      expect(response.body).toEqual({
        error:
          "All fields (class_name, class_main_stat) are required and must be valid.",
        statusCode: 400,
        success: false,
      });
      expect(createMasterClassSpy).not.toHaveBeenCalled();
    });
    it("should return 400 if the class_main_stat is not valid", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
      const token = jwt.sign(userPayload, process.env.JWT_SECRET_KEY as string);
      const createMasterClassSpy = jest
        .spyOn(MasterClassService.prototype, "createMasterClass")
        .mockRejectedValue(
          new HttpError(
            'new row for relation "master_class" violates check constraint "check_class_type"',
            400,
          ),
        );
      const response = await supertest(app)
        .post("/api/master-class")
        .set("Authorization", `Bearer ${token}`)
        .send({
          ...masterClassPayload,
          class_main_stat: "invalid",
        });
      expect(response.status).toBe(400);
      expect(response.body).toEqual({
        error:
          'new row for relation "master_class" violates check constraint "check_class_type"',
        statusCode: 400,
      });
    });
    it("should return failed to create master class when repo failed to create master class", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
      const token = jwt.sign(userPayload, process.env.JWT_SECRET_KEY as string);
      const createMasterClassSpy = jest
        .spyOn(MasterClassService.prototype, "createMasterClass")
        .mockRejectedValue(new Error("Failed to create master class"));
      const response = await supertest(app)
        .post("/api/master-class")
        .set("Authorization", `Bearer ${token}`)
        .send(masterClassPayload);
      expect(response.status).toBe(500);
      expect(response.body).toEqual({
        error: "Internal Server Error",
        statusCode: 500,
      });
      expect(createMasterClassSpy).toHaveBeenCalledWith(masterClassPayload);
    });
  });
  describe("Get Master Classes", () => {
    it("should successfully get all master classes", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
      const token = jwt.sign(userPayload, process.env.JWT_SECRET_KEY as string);
      const getMasterClassesSpy = jest.spyOn(
        MasterClassService.prototype,
        "getMasterClasses",
      );
      const response = await supertest(app)
        .get("/api/master-class")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json");
      expect(response.status).toBe(200);
      expect(response.body).toEqual({
        message: "Master classes fetched successfully",
        statusCode: 200,
        success: true,
        data: expect.any(Array),
      });
      expect(getMasterClassesSpy).toHaveBeenCalled();
    });
    it("should return 401 if the user is not authenticated", async () => {
      const response = await supertest(app)
        .get("/api/master-class")
        .set("Content-Type", "application/json");
      expect(response.status).toBe(401);
      expect(response.body).toEqual({
        message: "Authorization header missing or malformed",
        statusCode: 401,
      });
    });
  });
  describe("Get Master Class By Id", () => {
    it("should successfully get the class by id", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
    });
    it("should get the class by id", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
      const token = jwt.sign(userPayload, process.env.JWT_SECRET_KEY as string);
      const getMasterClassByIdSpy = jest.spyOn(
        MasterClassService.prototype,
        "getMasterClassById",
      );
      const response = await supertest(app)
        .get("/api/master-class/getbyid/2")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json");
      expect(response.status).toBe(200);
      expect(response.body).toEqual({
        message: "Master class fetched successfully",
        statusCode: 200,
        success: true,
        data: expect.any(Object),
      });
      expect(getMasterClassByIdSpy).toHaveBeenCalledWith("2");
    });
    it("should return 401 if the user is not authenticated", async () => {
      const response = await supertest(app)
        .get("/api/master-class/getbyid/1")
        .set("Content-Type", "application/json");
      expect(response.status).toBe(401);
      expect(response.body).toEqual({
        message: "Authorization header missing or malformed",
        statusCode: 401,
      });
    });
    it("should return 404 if the class is not found", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
      const token = jwt.sign(userPayload, process.env.JWT_SECRET_KEY as string);
      jest.spyOn(MasterClassService.prototype, "getMasterClassById");
      const response = await supertest(app)
        .get("/api/master-class/getbyid/11321313")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json");
      expect(response.status).toBe(404);
      expect(response.body).toEqual({
        error: "Master class not found",
        statusCode: 404,
      });
    });
    it("should return 400 when no id is provided", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
      const token = jwt.sign(userPayload, process.env.JWT_SECRET_KEY as string);
      const response = await supertest(app)
        .get("/api/master-class/getbyid/:id")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json");
      expect(response.status).toBe(400);
      expect(response.body).toEqual({
        error: "Master class id is required",
        statusCode: 400,
        success: false,
      });
    });
  });
  describe("Update Master Class", () => {
    it("should successfully update the class", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
      const token = jwt.sign(userPayload, process.env.JWT_SECRET_KEY as string);
      const updateMasterClassSpy = jest
        .spyOn(MasterClassService.prototype, "updateMasterClass")
        .mockResolvedValue(Promise.resolve(true));
      const response = await supertest(app)
        .put("/api/master-class/1")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json")
        .send({ ...masterClassPayload, id: "1" });
      expect(response.status).toBe(200);
      expect(response.body).toEqual({
        message: "Master class updated successfully",
        statusCode: 200,
        success: true,
      });
      expect(updateMasterClassSpy).toHaveBeenCalledWith({
        ...masterClassPayload,
        id: "1",
      });
    });
    it("should return 401 if the user is not authenticated", async () => {
      const response = await supertest(app)
        .put("/api/master-class/1")
        .set("Content-Type", "application/json")
        .send({ ...masterClassPayload, id: "1" });
      expect(response.status).toBe(401);
    });
    it("should return 404 if the class is not found", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
      const token = jwt.sign(userPayload, process.env.JWT_SECRET_KEY as string);
      const response = await supertest(app)
        .put("/api/master-class/11321313")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json")
        .send({ ...masterClassPayload, id: "11321313" });
      expect(response.status).toBe(404);
      expect(response.body).toEqual({
        error: "Master class not found",
        statusCode: 404,
      });
    });
  });
  describe("Delete Master Class", () => {
    it("should successfully delete the class", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
      const token = jwt.sign(userPayload, process.env.JWT_SECRET_KEY as string);
      const deleteMasterClassSpy = jest
        .spyOn(MasterClassService.prototype, "deleteMasterClass")
        .mockResolvedValue(Promise.resolve(true));
      const response = await supertest(app)
        .delete("/api/master-class/delete/1")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json");
      expect(response.status).toBe(200);
      expect(response.body).toEqual({
        message: "Master class deleted successfully",
        statusCode: 200,
        success: true,
      });
      expect(deleteMasterClassSpy).toHaveBeenCalledWith("1");
    });
    it("should return 401 if the user is not authenticated", async () => {
      const response = await supertest(app)
        .delete("/api/master-class/delete/1")
        .set("Content-Type", "application/json");
      expect(response.status).toBe(401);
    });
    it("should return 404 if the class is not found", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
      const token = jwt.sign(userPayload, process.env.JWT_SECRET_KEY as string);
      const response = await supertest(app)
        .delete("/api/master-class/delete/11321313")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json");
      expect(response.status).toBe(404);
      expect(response.body).toEqual({
        error: "Master class not found",
        statusCode: 404,
      });
    });
    it("should return 400 when no id is provided", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
      const token = jwt.sign(userPayload, process.env.JWT_SECRET_KEY as string);
      const response = await supertest(app)
        .delete("/api/master-class/delete/:id") // Explicitly call the endpoint without an id
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json");
      console.log(response.body);
      expect(response.statusCode).toBe(404);
      expect(response.body).toEqual({
        error: "Master class id is required",
        statusCode: 404,
        success: false,
      });
    });
    it("should return 500 when the repo fails to delete the class", async () => {
      if (!process.env.JWT_SECRET_KEY) {
        expect(true).toBe(false);
      }
      const token = jwt.sign(userPayload, process.env.JWT_SECRET_KEY as string);
      const deleteMasterClassSpy = jest
        .spyOn(MasterClassService.prototype, "deleteMasterClass")
        .mockRejectedValue(new Error("Failed to delete master class"));
      const response = await supertest(app)
        .delete("/api/master-class/delete/1")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json");
      expect(response.status).toBe(500);
      expect(response.body).toEqual({
        error: "Internal Server Error",
        statusCode: 500,
      });
    });
  });
});

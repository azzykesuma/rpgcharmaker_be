import jwt from "jsonwebtoken";
import supertest from "supertest";
import app from "../../../index";

const selectMasterClassPayload = {
  masterClassId: 3,
  playerId: "7370ea58-d419-4159-bcdf-e1cc9de8f94d",
};
const selectWeaponPayload = {
  weaponId: 10,
  playerId: "7370ea58-d419-4159-bcdf-e1cc9de8f94d",
};

describe("Player", () => {
  describe.skip("player select master class", () => {
    let token: string;
    beforeAll(() => {
      if (!process.env.JWT_SECRET_KEY) {
        throw new Error("JWT_SECRET is not set");
      }
      token = jwt.sign(selectMasterClassPayload, process.env.JWT_SECRET_KEY);
    });

    it("should be able to select master class", async () => {
      const response = await supertest(app)
        .post("/api/player/select-class")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json")
        .send(selectMasterClassPayload);
      expect(response.status).toBe(200);
      expect(response.body.message).toBe("Class selected successfully");
    });
    it("should return 400 if master class id is not provided", async () => {
      const response = await supertest(app)
        .post("/api/player/select-class")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json")
        .send({
          playerId: "7370ea58-d419-4159-bcdf-e1cc9de8f94d",
        });
      expect(response.status).toBe(400);
      expect(response.body.error).toBe("Master class id is required");
    });
    it("should return 401 if token is not provided", async () => {
      const response = await supertest(app)
        .post("/api/player/select-class")
        .set("Content-Type", "application/json")
        .send(selectMasterClassPayload);
      expect(response.status).toBe(401);
    });
    it("should return 400 if master class id is not valid", async () => {
      const response = await supertest(app)
        .post("/api/player/select-class")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json")
        .send({
          masterClassId: 7878312,
          playerId: "7370ea58-d419-4159-bcdf-e1cc9de8f94d",
        });
      expect(response.status).toBe(404);
      expect(response.body.error).toBe("Master class not found");
    });
    it("should return 400 if master class id is not a number", async () => {
      const response = await supertest(app)
        .post("/api/player/select-class")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json")
        .send({
          masterClassId: "7878312",
          playerId: "7370ea58-d419-4159-bcdf-e1cc9de8f94d",
        });
      expect(response.status).toBe(400);
      expect(response.body.error).toBe("Master class id must be a number");
    });
  });
  describe("player select weapon", () => {
    let token: string;
    beforeAll(() => {
      if (!process.env.JWT_SECRET_KEY) {
        throw new Error("JWT_SECRET is not set");
      }
      token = jwt.sign(selectWeaponPayload, process.env.JWT_SECRET_KEY);
    });
    it("should be able to select weapon", async () => {
      const response = await supertest(app)
        .post("/api/player/select-weapon")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json")
        .send(selectWeaponPayload);
      expect(response.status).toBe(200);
      expect(response.body.message).toBe("Weapon selected successfully");
    });
    it("should return 400 when weapon is not found", async () => {
      const response = await supertest(app)
        .post("/api/player/select-weapon")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json")
        .send({ ...selectWeaponPayload, weaponId: 567131 });
      expect(response.status).toBe(404);
      expect(response.body.error).toBe("Weapon not found");
    });
    it("should return 400 when weapon id is not a number", async () => {
      const response = await supertest(app)
        .post("/api/player/select-weapon")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json")
        .send({ selectWeaponPayload, weaponId: "invalid" });
      expect(response.status).toBe(400);
      expect(response.body.error).toBe("Weapon id must be a number");
    });
    it("should return 400 when weapon id is not given", async () => {
      const response = await supertest(app)
        .post("/api/player/select-weapon")
        .set("Authorization", `Bearer ${token}`)
        .set("Content-Type", "application/json")
        .send({ selectWeaponPayload, weaponId: undefined });
      expect(response.status).toBe(400);
      expect(response.body.error).toBe("Weapon id is required");
    });
  });
  describe("get player details", () => {
    let token: string;
    beforeAll(() => {
      if (!process.env.JWT_SECRET_KEY) {
        throw new Error("JWT_SECRET is not set");
      }
      token = jwt.sign(selectWeaponPayload, process.env.JWT_SECRET_KEY);
    });
    it("should be able to get player details", async () => {
      const response = await supertest(app)
        .get("/api/player/get-player-details")
        .set("Authorization", `Bearer ${token}`);
      expect(response.status).toBe(200);
      expect(response.body.message).toBe("Player details fetched successfully");
    });
  });
});

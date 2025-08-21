import { MasterClass } from "../application/MasterClassService.ts";
import { MasterClassController } from "../interface/master_class.controller.ts";

jest.mock("../application/MasterClassService.ts");
const mockMasterClassService = jest.mocked(MasterClass);
describe("Master Class", () => {
  it("should be able to create a master class", () => {
    mockMasterClassService.createMasterClass.mockResolvedValue({
      message: "Master class created successfully",
      statusCode: 201,
    });
    const masterClassController = new MasterClassController(
      mockMasterClassService,
    );
    const req = {
      body: {
        master_class_name: "Master Class",
        master_class_description: "Master Class Description",
      },
    };
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn().mockReturnThis(),
    };
    await masterClassController.create(req, res);
    expect(res.status).toHaveBeenCalledWith(201);
    expect(res.json).toHaveBeenCalledWith({
      message: "Master class created successfully",
      statusCode: 201,
    });
  });
});

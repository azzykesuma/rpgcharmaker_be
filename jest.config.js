module.exports = {
  preset: "ts-jest",
  testEnvironment: "node",
  roots: ["./src"],
  transform: {
    "^.+\\.ts?$": "ts-jest",
  },
  testRegex: "(/__tests__/.*|(\\.|/)(test|spec))\\.ts?$",
  moduleFileExtensions: ["ts", "js", "json", "node"],
  clearMocks: true,
  resetMocks: true,
  restoreMocks: true,
  forceExit: true,
};

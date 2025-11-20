# Skill: TypeScript Testing

## Overview
Master testing TypeScript applications with Jest, Vitest, and type testing tools for comprehensive quality assurance.

## Learning Objectives
- Set up Jest/Vitest with TypeScript
- Write type-safe tests
- Mock with TypeScript
- Test types with tsd/expect-type
- Apply testing best practices

## Difficulty
Intermediate to Advanced

## Estimated Time
5-7 hours

## Key Concepts

### Jest Setup
```bash
npm install -D jest @types/jest ts-jest

# jest.config.js
module.exports = {
  preset: "ts-jest",
  testEnvironment: "node",
  roots: ["<rootDir>/src"],
  testMatch: ["**/__tests__/**/*.ts", "**/?(*.)+(spec|test).ts"]
};
```

### Basic Testing
```typescript
import { add, User, createUser } from "./math";

describe("add function", () => {
  it("should add two numbers", () => {
    const result = add(2, 3);
    expect(result).toBe(5);
  });

  it("should handle negative numbers", () => {
    expect(add(-1, -2)).toBe(-3);
  });
});

describe("createUser", () => {
  it("should create user with correct types", () => {
    const user: User = createUser("Alice", "alice@example.com");

    expect(user).toEqual({
      id: expect.any(Number),
      name: "Alice",
      email: "alice@example.com"
    });
  });
});
```

### Type-Safe Mocking
```typescript
import { jest } from "@jest/globals";

interface UserService {
  getUser(id: number): Promise<User>;
  createUser(name: string, email: string): Promise<User>;
}

const mockUserService: jest.Mocked<UserService> = {
  getUser: jest.fn(),
  createUser: jest.fn()
};

describe("UserController", () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it("should get user", async () => {
    const mockUser: User = { id: 1, name: "Alice", email: "alice@example.com" };
    mockUserService.getUser.mockResolvedValue(mockUser);

    const controller = new UserController(mockUserService);
    const user = await controller.getById(1);

    expect(user).toEqual(mockUser);
    expect(mockUserService.getUser).toHaveBeenCalledWith(1);
  });
});
```

### Type Testing
```typescript
import { expectType, expectError } from "tsd";

// Test function return types
expectType<number>(add(1, 2));
expectError(add("1", "2"));  // Should error

// Test generic inference
function identity<T>(value: T): T {
  return value;
}

expectType<number>(identity(42));
expectType<string>(identity("hello"));

// Test utility types
interface User {
  id: number;
  name: string;
  email: string;
}

expectType<Partial<User>>({ id: 1 });
expectType<Required<Partial<User>>>({ id: 1, name: "Alice", email: "a@b.com" });
```

### Vitest with TypeScript
```typescript
import { describe, it, expect, expectTypeOf } from "vitest";

describe("Type-safe testing", () => {
  it("should test runtime and types", () => {
    const result = add(1, 2);

    // Runtime assertion
    expect(result).toBe(3);

    // Type assertion
    expectTypeOf(result).toBeNumber();
    expectTypeOf(result).not.toBeString();
  });

  it("should test generics", () => {
    function identity<T>(value: T): T {
      return value;
    }

    expectTypeOf(identity<number>).parameter(0).toBeNumber();
    expectTypeOf(identity<number>).returns.toBeNumber();
  });
});
```

## Practical Examples

### Example 1: API Client Testing
```typescript
import { rest } from "msw";
import { setupServer } from "msw/node";

const server = setupServer();

describe("API Client", () => {
  beforeAll(() => server.listen());
  afterEach(() => server.resetHandlers());
  afterAll(() => server.close());

  it("should fetch users", async () => {
    const mockUsers: User[] = [
      { id: 1, name: "Alice", email: "alice@example.com" }
    ];

    server.use(
      rest.get("/api/users", (req, res, ctx) => {
        return res(ctx.json(mockUsers));
      })
    );

    const client = createApiClient();
    const users = await client.get<User[]>("/api/users");

    expect(users).toEqual(mockUsers);
    expectTypeOf(users).toMatchTypeOf<User[]>();
  });
});
```

## Resources
- [Jest TypeScript](https://jestjs.io/docs/getting-started#using-typescript)
- [Vitest](https://vitest.dev/)
- [tsd](https://github.com/SamVerschueren/tsd)

## Next Steps
- **Migration Best Practices Agent**
- **Testing Types Agent**

# Skill: Type Guards

## Overview
Master TypeScript type guards for runtime type checking and type narrowing to write safer, more predictable code.

## Learning Objectives
- Use built-in type guards (typeof, instanceof, in)
- Create custom type predicates
- Implement assertion functions
- Apply discriminated unions
- Perform exhaustiveness checking

## Difficulty
Intermediate

## Estimated Time
4-5 hours

## Key Concepts

### Built-in Type Guards
```typescript
// typeof
function processValue(value: string | number) {
  if (typeof value === "string") {
    return value.toUpperCase();
  } else {
    return value.toFixed(2);
  }
}

// instanceof
class Dog { bark() {} }
class Cat { meow() {} }

function makeSound(animal: Dog | Cat) {
  if (animal instanceof Dog) {
    animal.bark();
  } else {
    animal.meow();
  }
}

// in operator
interface Fish { swim: () => void; }
interface Bird { fly: () => void; }

function move(animal: Fish | Bird) {
  if ("swim" in animal) {
    animal.swim();
  } else {
    animal.fly();
  }
}
```

### Custom Type Guards
```typescript
interface User {
  id: number;
  name: string;
  email: string;
}

function isUser(obj: unknown): obj is User {
  return (
    typeof obj === "object" &&
    obj !== null &&
    "id" in obj &&
    typeof (obj as User).id === "number" &&
    "name" in obj &&
    typeof (obj as User).name === "string" &&
    "email" in obj &&
    typeof (obj as User).email === "string"
  );
}

function processData(data: unknown) {
  if (isUser(data)) {
    console.log(data.name);  // TypeScript knows it's User
  }
}
```

### Assertion Functions
```typescript
function assertIsString(value: unknown): asserts value is string {
  if (typeof value !== "string") {
    throw new Error("Value must be a string");
  }
}

function processInput(input: unknown) {
  assertIsString(input);
  // After this point, TypeScript knows input is string
  console.log(input.toUpperCase());
}
```

### Discriminated Unions
```typescript
type Result<T> =
  | { success: true; data: T }
  | { success: false; error: string };

function handleResult<T>(result: Result<T>) {
  if (result.success) {
    console.log(result.data);
  } else {
    console.error(result.error);
  }
}

// Exhaustiveness checking
type Shape =
  | { kind: "circle"; radius: number }
  | { kind: "rectangle"; width: number; height: number }
  | { kind: "triangle"; base: number; height: number };

function getArea(shape: Shape): number {
  switch (shape.kind) {
    case "circle":
      return Math.PI * shape.radius ** 2;
    case "rectangle":
      return shape.width * shape.height;
    case "triangle":
      return (shape.base * shape.height) / 2;
    default:
      const _exhaustive: never = shape;
      throw new Error(`Unhandled shape: ${_exhaustive}`);
  }
}
```

## Practical Examples

### Example 1: Form Validation
```typescript
interface FormData {
  email: string;
  password: string;
  age?: number;
}

function isValidEmail(value: unknown): value is string {
  return typeof value === "string" && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);
}

function isValidPassword(value: unknown): value is string {
  return typeof value === "string" && value.length >= 8;
}

function validateForm(data: unknown): data is FormData {
  if (typeof data !== "object" || data === null) return false;

  const { email, password, age } = data as FormData;

  if (!isValidEmail(email)) return false;
  if (!isValidPassword(password)) return false;
  if (age !== undefined && (typeof age !== "number" || age < 18)) return false;

  return true;
}
```

### Example 2: API Response Handler
```typescript
interface ApiSuccess<T> {
  status: "success";
  data: T;
}

interface ApiError {
  status: "error";
  message: string;
  code: number;
}

type ApiResponse<T> = ApiSuccess<T> | ApiError;

function isSuccess<T>(response: ApiResponse<T>): response is ApiSuccess<T> {
  return response.status === "success";
}

async function fetchUser(id: number): Promise<User> {
  const response: ApiResponse<User> = await fetch(`/api/users/${id}`).then(r => r.json());

  if (isSuccess(response)) {
    return response.data;
  } else {
    throw new Error(`${response.code}: ${response.message}`);
  }
}
```

## Resources
- [TypeScript Handbook - Narrowing](https://www.typescriptlang.org/docs/handbook/2/narrowing.html)
- [Type Predicates](https://www.typescriptlang.org/docs/handbook/2/narrowing.html#using-type-predicates)

## Next Steps
- **Decorators Skill**
- **TypeScript Testing Skill**
- **Type System Agent**

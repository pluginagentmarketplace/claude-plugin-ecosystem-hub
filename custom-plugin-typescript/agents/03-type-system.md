# Type System Agent

## Role
TypeScript type system expert specializing in type inference, type guards, type narrowing, assertion functions, and control flow analysis for bulletproof type safety.

## Expertise
- Type inference and contextual typing
- Type guards (typeof, instanceof, in)
- User-defined type guards
- Assertion functions
- Discriminated unions
- Control flow analysis
- Narrowing patterns
- Exhaustiveness checking

## Approach
You teach how TypeScript's type system analyzes code to provide safety guarantees. Focus on leveraging the compiler's intelligence for runtime safety.

## Key Principles
1. **Let the Compiler Work**: Leverage type inference and flow analysis
2. **Guard at Boundaries**: Validate types at system boundaries
3. **Narrow Confidently**: Use type guards to refine types safely
4. **Exhaust All Cases**: Use exhaustiveness checking for completeness

## Teaching Method

### Type Inference Mastery
```typescript
// Basic inference
let x = 3; // inferred as number
let arr = [0, 1, null]; // inferred as (number | null)[]

// Contextual typing
window.addEventListener("click", (e) => {
  // e is inferred as MouseEvent
  console.log(e.clientX, e.clientY);
});

// Best common type
let mixed = [0, 1, "hello"]; // inferred as (string | number)[]

// Return type inference
function calculate(x: number, y: number) {
  return x * y; // inferred return type: number
}

// Generic inference
function identity<T>(arg: T): T {
  return arg;
}

const num = identity(42); // T inferred as 42 (literal type)
const str = identity("hello"); // T inferred as "hello"
```

## Learning Progression

### Level 1: Built-in Type Guards (Week 1)
```typescript
// typeof guard
function processValue(value: string | number) {
  if (typeof value === "string") {
    // value is string
    return value.toUpperCase();
  } else {
    // value is number
    return value.toFixed(2);
  }
}

// instanceof guard
class Dog {
  bark() {
    console.log("Woof!");
  }
}

class Cat {
  meow() {
    console.log("Meow!");
  }
}

function makeSound(animal: Dog | Cat) {
  if (animal instanceof Dog) {
    animal.bark(); // TypeScript knows it's Dog
  } else {
    animal.meow(); // TypeScript knows it's Cat
  }
}

// in operator guard
interface Fish {
  swim: () => void;
}

interface Bird {
  fly: () => void;
}

function move(animal: Fish | Bird) {
  if ("swim" in animal) {
    animal.swim(); // TypeScript knows it's Fish
  } else {
    animal.fly(); // TypeScript knows it's Bird
  }
}

// Truthiness narrowing
function printLength(str: string | null | undefined) {
  if (str) {
    // str is string (null and undefined filtered out)
    console.log(str.length);
  }
}

// Equality narrowing
function compare(x: string | number, y: string | boolean) {
  if (x === y) {
    // x and y are both string
    console.log(x.toUpperCase(), y.toUpperCase());
  }
}
```

### Level 2: User-Defined Type Guards (Week 2)
```typescript
// Type predicate function
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

// Usage
function processData(data: unknown) {
  if (isUser(data)) {
    // TypeScript knows data is User
    console.log(data.name, data.email);
  }
}

// Generic type guard
function isArray<T>(value: unknown): value is T[] {
  return Array.isArray(value);
}

function isArrayOf<T>(
  value: unknown,
  guard: (item: unknown) => item is T
): value is T[] {
  return Array.isArray(value) && value.every(guard);
}

function isString(value: unknown): value is string {
  return typeof value === "string";
}

const data: unknown = ["a", "b", "c"];
if (isArrayOf(data, isString)) {
  // data is string[]
  data.forEach((str) => console.log(str.toUpperCase()));
}

// Narrowing with type predicates
interface Success<T> {
  status: "success";
  data: T;
}

interface Failure {
  status: "error";
  error: string;
}

type Result<T> = Success<T> | Failure;

function isSuccess<T>(result: Result<T>): result is Success<T> {
  return result.status === "success";
}

function handleResult<T>(result: Result<T>) {
  if (isSuccess(result)) {
    console.log(result.data); // TypeScript knows it's Success<T>
  } else {
    console.error(result.error); // TypeScript knows it's Failure
  }
}
```

### Level 3: Assertion Functions (Week 3)
```typescript
// Assertion function with asserts
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

// Assert condition
function assert(condition: boolean, message?: string): asserts condition {
  if (!condition) {
    throw new Error(message || "Assertion failed");
  }
}

function getUser(id: number): User | null {
  // ... fetch user
  return null;
}

function processUser(id: number) {
  const user = getUser(id);
  assert(user !== null, "User not found");
  // After this point, TypeScript knows user is User (not null)
  console.log(user.name);
}

// Assert type with specific properties
function assertHasProperty<T, K extends string>(
  obj: T,
  key: K,
  message?: string
): asserts obj is T & Record<K, unknown> {
  if (!(key in (obj as any))) {
    throw new Error(message || `Property ${key} not found`);
  }
}

function processConfig(config: unknown) {
  assertHasProperty(config, "apiKey");
  assertHasProperty(config, "endpoint");
  // TypeScript knows config has apiKey and endpoint
  console.log(config.apiKey, config.endpoint);
}
```

### Level 4: Advanced Control Flow (Week 4)
```typescript
// Discriminated unions with exhaustiveness
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
      // Exhaustiveness check
      const _exhaustive: never = shape;
      throw new Error(`Unhandled shape: ${_exhaustive}`);
  }
}

// Control flow with optional chaining
interface Config {
  server?: {
    host?: string;
    port?: number;
  };
}

function getServerUrl(config: Config): string {
  const host = config.server?.host ?? "localhost";
  const port = config.server?.port ?? 3000;
  return `http://${host}:${port}`;
}

// Nullish coalescing with narrowing
function processValue(value: string | null | undefined): string {
  // value is string | null | undefined
  const cleaned = value ?? "default";
  // cleaned is string
  return cleaned;
}

// Type narrowing with array methods
function filterUsers(users: (User | null)[]): User[] {
  return users.filter((user): user is User => user !== null);
}

// Narrowing with destructuring
type Response =
  | { success: true; data: { id: number; name: string } }
  | { success: false; error: string };

function handleResponse(response: Response) {
  if (response.success) {
    const { data } = response; // data is { id: number; name: string }
    console.log(data.name);
  } else {
    const { error } = response; // error is string
    console.error(error);
  }
}
```

## Advanced Patterns

### Runtime Validation with Type Guards
```typescript
import { z } from "zod"; // Example with Zod library

// Define schema
const UserSchema = z.object({
  id: z.number(),
  name: z.string(),
  email: z.string().email(),
  role: z.enum(["admin", "user", "guest"]),
});

type User = z.infer<typeof UserSchema>;

// Type guard with runtime validation
function validateUser(data: unknown): data is User {
  return UserSchema.safeParse(data).success;
}

// Usage
async function fetchUser(id: number): Promise<User> {
  const response = await fetch(`/api/users/${id}`);
  const data = await response.json();

  if (validateUser(data)) {
    return data; // TypeScript knows it's User
  }

  throw new Error("Invalid user data");
}
```

### Type-Safe Event System
```typescript
type EventMap = {
  click: { x: number; y: number };
  keypress: { key: string };
  submit: { formData: FormData };
};

type EventListener<K extends keyof EventMap> = (event: EventMap[K]) => void;

class TypedEventEmitter {
  private listeners: {
    [K in keyof EventMap]?: Set<EventListener<K>>;
  } = {};

  on<K extends keyof EventMap>(event: K, listener: EventListener<K>): void {
    if (!this.listeners[event]) {
      this.listeners[event] = new Set();
    }
    this.listeners[event]!.add(listener);
  }

  emit<K extends keyof EventMap>(event: K, data: EventMap[K]): void {
    this.listeners[event]?.forEach((listener) => listener(data));
  }
}

// Usage
const emitter = new TypedEventEmitter();

emitter.on("click", (event) => {
  // event is { x: number; y: number }
  console.log(event.x, event.y);
});

emitter.emit("click", { x: 10, y: 20 }); // Type-safe
// emitter.emit("click", { invalid: true }); // Error
```

### Branded Types
```typescript
// Create branded types for primitive values
type Brand<K, T> = K & { __brand: T };

type UserId = Brand<number, "UserId">;
type ProductId = Brand<number, "ProductId">;

// Constructor functions
function createUserId(id: number): UserId {
  return id as UserId;
}

function createProductId(id: number): ProductId {
  return id as ProductId;
}

// Type-safe usage
function getUser(id: UserId): User {
  // Implementation
  return {} as User;
}

function getProduct(id: ProductId): Product {
  // Implementation
  return {} as Product;
}

const userId = createUserId(123);
const productId = createProductId(456);

getUser(userId); // OK
// getUser(productId); // Error: ProductId is not UserId
// getUser(123); // Error: number is not UserId
```

## Best Practices

1. **Write Type Guards for External Data**: Always validate data from APIs, user input, etc.
2. **Use Assertion Functions for Preconditions**: Make invariants explicit
3. **Leverage Discriminated Unions**: For state machines and variant types
4. **Enable Exhaustiveness Checking**: Ensure all cases are handled
5. **Prefer Type Guards over Type Assertions**: Type guards are safer

## Common Pitfalls

❌ **Unsafe type assertions**
```typescript
// Bad
const user = data as User; // No runtime check

// Good
if (isUser(data)) {
  const user = data; // Type guard ensures runtime safety
}
```

❌ **Incomplete type guards**
```typescript
// Bad - doesn't check all properties
function isUser(obj: any): obj is User {
  return obj && obj.id && obj.name;
}

// Good - comprehensive check
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
```

❌ **Missing exhaustiveness check**
```typescript
// Bad - doesn't handle all cases
function getArea(shape: Shape): number {
  switch (shape.kind) {
    case "circle":
      return Math.PI * shape.radius ** 2;
    case "rectangle":
      return shape.width * shape.height;
    // Missing triangle case - no compile error!
  }
  return 0;
}

// Good - exhaustiveness check
function getArea(shape: Shape): number {
  switch (shape.kind) {
    case "circle":
      return Math.PI * shape.radius ** 2;
    case "rectangle":
      return shape.width * shape.height;
    case "triangle":
      return (shape.base * shape.height) / 2;
    default:
      const _exhaustive: never = shape; // Compile error if case missing
      throw new Error(`Unhandled shape: ${_exhaustive}`);
  }
}
```

## Exercises

### Exercise 1: API Response Validator
Build a comprehensive type guard system for API responses with nested validation.

### Exercise 2: State Machine with Type Safety
Implement a state machine with discriminated unions and exhaustiveness checking.

### Exercise 3: Form Validation Library
Create a type-safe form validation library with assertion functions.

### Exercise 4: Type-Safe Router
Build a type-safe router with path parameter extraction and validation.

## Resources
- [TypeScript Handbook - Narrowing](https://www.typescriptlang.org/docs/handbook/2/narrowing.html)
- [Type Guards and Type Predicates](https://www.typescriptlang.org/docs/handbook/2/narrowing.html#using-type-predicates)
- [Assertion Functions](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-3-7.html#assertion-functions)
- [Control Flow Analysis](https://www.typescriptlang.org/docs/handbook/2/narrowing.html#control-flow-analysis)

## Prerequisites
- TypeScript Fundamentals Agent
- Advanced Types Agent
- Understanding of JavaScript runtime types

## Estimated Duration
3-4 weeks (10-12 hours per week)

## Next Agent
Continue to **Decorators & Metadata Agent** for learning experimental decorators, reflect-metadata, and metaprogramming patterns.

# Skill: TypeScript Type System Basics

## Overview
Master TypeScript's foundational type system including primitive types, object types, arrays, tuples, and type annotations for building type-safe applications.

## Learning Objectives
- Understand TypeScript's basic types (string, number, boolean)
- Use array types and tuple types effectively
- Define object types with interfaces and type aliases
- Apply type annotations to variables and functions
- Leverage type inference for cleaner code

## Prerequisites
- JavaScript ES6+ fundamentals
- Understanding of data types
- Basic object-oriented programming concepts

## Difficulty
Beginner to Intermediate

## Estimated Time
6-8 hours

## Key Concepts

### 1. Primitive Types
```typescript
// String
let username: string = "Alice";
let message: string = `Hello, ${username}!`;

// Number
let age: number = 30;
let price: number = 99.99;
let hex: number = 0xf00d;
let binary: number = 0b1010;

// Boolean
let isActive: boolean = true;
let hasPermission: boolean = false;

// Null and Undefined
let empty: null = null;
let notDefined: undefined = undefined;

// Any (avoid when possible)
let dynamic: any = "string";
dynamic = 42;  // No error, but loses type safety

// Unknown (safer than any)
let uncertain: unknown = "maybe string";
if (typeof uncertain === "string") {
  console.log(uncertain.toUpperCase());  // Type guard required
}
```

### 2. Array Types
```typescript
// Array syntax option 1
let numbers: number[] = [1, 2, 3, 4, 5];

// Array syntax option 2 (generic)
let strings: Array<string> = ["a", "b", "c"];

// Mixed types with union
let mixed: (string | number)[] = [1, "two", 3, "four"];

// Readonly arrays
let immutable: readonly number[] = [1, 2, 3];
// immutable.push(4);  // Error: Property 'push' does not exist

// Array of objects
interface User {
  id: number;
  name: string;
}

let users: User[] = [
  { id: 1, name: "Alice" },
  { id: 2, name: "Bob" }
];
```

### 3. Tuple Types
```typescript
// Fixed-length array with specific types
let coordinate: [number, number] = [10, 20];

// Named tuple (TypeScript 4.0+)
let person: [name: string, age: number] = ["Alice", 30];

// Optional tuple elements
let data: [string, number?] = ["value"];

// Rest elements in tuples
let scores: [string, ...number[]] = ["Alice", 95, 87, 92];

// Tuple with different types
type Response = [status: number, data: any, headers: Record<string, string>];
let apiResponse: Response = [200, { user: "Alice" }, { "Content-Type": "application/json" }];
```

### 4. Object Types
```typescript
// Type alias for object
type Point = {
  x: number;
  y: number;
};

const origin: Point = { x: 0, y: 0 };

// Interface for object
interface User {
  id: number;
  name: string;
  email: string;
  age?: number;  // Optional property
  readonly createdAt: Date;  // Read-only property
}

const user: User = {
  id: 1,
  name: "Alice",
  email: "alice@example.com",
  createdAt: new Date()
};

// user.createdAt = new Date();  // Error: Cannot assign to 'createdAt'

// Index signature
interface Dictionary {
  [key: string]: number;
}

const scores: Dictionary = {
  math: 95,
  science: 87,
  history: 92
};
```

### 5. Function Types
```typescript
// Function with typed parameters and return type
function add(a: number, b: number): number {
  return a + b;
}

// Function type expression
type MathOperation = (x: number, y: number) => number;

const multiply: MathOperation = (x, y) => x * y;

// Optional and default parameters
function greet(name: string, greeting: string = "Hello"): string {
  return `${greeting}, ${name}!`;
}

// Rest parameters
function sum(...numbers: number[]): number {
  return numbers.reduce((total, n) => total + n, 0);
}

// Void return type
function logMessage(message: string): void {
  console.log(message);
}

// Never return type (for functions that never return)
function throwError(message: string): never {
  throw new Error(message);
}
```

## Practical Examples

### Example 1: User Management System
```typescript
interface User {
  id: number;
  username: string;
  email: string;
  role: "admin" | "user" | "guest";  // Literal type
  preferences?: {
    theme: "light" | "dark";
    notifications: boolean;
  };
}

function createUser(
  username: string,
  email: string,
  role: User["role"] = "user"
): User {
  return {
    id: Math.random(),
    username,
    email,
    role
  };
}

function updateUserEmail(user: User, newEmail: string): User {
  return {
    ...user,
    email: newEmail
  };
}

const admin: User = createUser("admin", "admin@example.com", "admin");
console.log(admin);
```

### Example 2: Product Catalog
```typescript
type Category = "electronics" | "clothing" | "food" | "books";

interface Product {
  id: number;
  name: string;
  price: number;
  category: Category;
  tags: string[];
  inStock: boolean;
  rating?: number;
}

interface CartItem {
  product: Product;
  quantity: number;
}

function calculateTotal(items: CartItem[]): number {
  return items.reduce((total, item) => {
    return total + (item.product.price * item.quantity);
  }, 0);
}

function filterByCategory(products: Product[], category: Category): Product[] {
  return products.filter(p => p.category === category);
}

const products: Product[] = [
  {
    id: 1,
    name: "Laptop",
    price: 999,
    category: "electronics",
    tags: ["computer", "portable"],
    inStock: true,
    rating: 4.5
  },
  {
    id: 2,
    name: "T-Shirt",
    price: 29,
    category: "clothing",
    tags: ["casual", "cotton"],
    inStock: true
  }
];

const electronics = filterByCategory(products, "electronics");
console.log(electronics);
```

### Example 3: API Response Handling
```typescript
interface ApiResponse<T> {
  status: number;
  data: T;
  message?: string;
  timestamp: Date;
}

interface UserData {
  id: number;
  name: string;
  email: string;
}

async function fetchUser(id: number): Promise<ApiResponse<UserData>> {
  // Simulated API call
  return {
    status: 200,
    data: {
      id,
      name: "Alice",
      email: "alice@example.com"
    },
    timestamp: new Date()
  };
}

async function handleUserFetch(id: number): Promise<void> {
  const response = await fetchUser(id);

  if (response.status === 200) {
    console.log(`User: ${response.data.name}`);
  } else {
    console.error(response.message);
  }
}
```

## Common Patterns

### Pattern 1: Discriminated Unions
```typescript
interface Success {
  type: "success";
  data: any;
}

interface Error {
  type: "error";
  message: string;
}

type Result = Success | Error;

function handleResult(result: Result): void {
  if (result.type === "success") {
    console.log(result.data);  // TypeScript knows it's Success
  } else {
    console.error(result.message);  // TypeScript knows it's Error
  }
}
```

### Pattern 2: Type Assertions
```typescript
// When you know more than TypeScript
const input = document.getElementById("email") as HTMLInputElement;
input.value = "alice@example.com";

// Alternative syntax
const input2 = <HTMLInputElement>document.getElementById("email");

// Use type assertions sparingly, prefer type guards
```

## Exercises

### Exercise 1: Student Grade System
Create interfaces for Student, Course, and Grade. Implement functions to:
- Add a student
- Enroll student in course
- Assign grade
- Calculate GPA

### Exercise 2: E-Commerce Cart
Build a shopping cart system with:
- Product interface
- Cart interface
- Add/remove items functions
- Calculate subtotal, tax, and total

### Exercise 3: Task Manager
Create a task management system:
- Task interface with priority levels
- Task list operations (add, complete, filter)
- Type-safe task status tracking

## Best Practices

1. ✅ Use `const` assertions for literal types
```typescript
const config = {
  apiUrl: "https://api.example.com",
  timeout: 5000
} as const;
```

2. ✅ Prefer interfaces for object shapes
```typescript
interface User {  // Extendable
  id: number;
  name: string;
}
```

3. ✅ Use type aliases for unions and complex types
```typescript
type ID = string | number;
type Status = "pending" | "approved" | "rejected";
```

4. ✅ Leverage type inference
```typescript
let count = 0;  // TypeScript infers number
// Don't write: let count: number = 0;
```

5. ✅ Use readonly for immutability
```typescript
interface Config {
  readonly apiKey: string;
  readonly endpoint: string;
}
```

## Common Mistakes

❌ **Using `any` unnecessarily**
```typescript
// Bad
let data: any = fetchData();

// Good
let data: User = fetchData();
```

❌ **Missing return types**
```typescript
// Bad
function calculate(x: number, y: number) {
  return x + y;  // Inferred, but explicit is better
}

// Good
function calculate(x: number, y: number): number {
  return x + y;
}
```

❌ **Overusing type assertions**
```typescript
// Bad
const value = input as string as number;  // Double assertion!

// Good
if (typeof input === "string") {
  const num = Number(input);
}
```

## Resources
- [TypeScript Handbook - Basic Types](https://www.typescriptlang.org/docs/handbook/2/basic-types.html)
- [TypeScript Playground](https://www.typescriptlang.org/play)
- [TypeScript Deep Dive - Types](https://basarat.gitbook.io/typescript/type-system)

## Next Steps
After mastering basic types, proceed to:
- **Generics Patterns Skill** - For reusable type-safe code
- **Type Guards Skill** - For runtime type checking
- **Advanced Types Agent** - For conditional and mapped types

## Validation
You've mastered this skill when you can:
- [ ] Define complex object types with interfaces
- [ ] Use union and literal types effectively
- [ ] Create type-safe functions with proper signatures
- [ ] Apply type inference appropriately
- [ ] Build a small TypeScript application without `any`

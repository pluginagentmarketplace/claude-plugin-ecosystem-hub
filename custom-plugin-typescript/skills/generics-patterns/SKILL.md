# Skill: Generics Patterns

## Overview
Master TypeScript generics for writing reusable, type-safe code that works with multiple types while maintaining compile-time type checking.

## Learning Objectives
- Understand generic type parameters
- Create generic functions and classes
- Use generic constraints
- Implement generic interfaces
- Apply generics to real-world scenarios

## Difficulty
Intermediate

## Estimated Time
4-6 hours

## Key Concepts

### Generic Functions
```typescript
function identity<T>(arg: T): T {
  return arg;
}

const num = identity<number>(42);  // Explicit
const str = identity("hello");     // Inferred

function toArray<T>(value: T): T[] {
  return [value];
}

function first<T>(arr: T[]): T | undefined {
  return arr[0];
}
```

### Generic Constraints
```typescript
interface Lengthwise {
  length: number;
}

function longest<T extends Lengthwise>(a: T, b: T): T {
  return a.length >= b.length ? a : b;
}

longest("hello", "world");  // OK: strings have length
longest([1, 2], [3, 4, 5]);  // OK: arrays have length
// longest(10, 20);  // Error: numbers don't have length
```

### Generic Classes
```typescript
class DataStore<T> {
  private data: T[] = [];

  add(item: T): void {
    this.data.push(item);
  }

  getAll(): T[] {
    return this.data;
  }

  find(predicate: (item: T) => boolean): T | undefined {
    return this.data.find(predicate);
  }
}

const userStore = new DataStore<User>();
userStore.add({ id: 1, name: "Alice", email: "alice@example.com" });
```

### Generic Interfaces
```typescript
interface Repository<T> {
  find(id: number): Promise<T | null>;
  findAll(): Promise<T[]>;
  create(data: Omit<T, "id">): Promise<T>;
  update(id: number, data: Partial<T>): Promise<T>;
  delete(id: number): Promise<void>;
}

class UserRepository implements Repository<User> {
  async find(id: number): Promise<User | null> {
    // Implementation
    return null;
  }

  async findAll(): Promise<User[]> {
    return [];
  }

  async create(data: Omit<User, "id">): Promise<User> {
    return { id: Math.random(), ...data };
  }

  async update(id: number, data: Partial<User>): Promise<User> {
    return { id, ...data } as User;
  }

  async delete(id: number): Promise<void> {
    // Implementation
  }
}
```

## Practical Examples

### Example 1: Generic Promise Wrapper
```typescript
interface ApiResponse<T> {
  data: T;
  status: number;
  message?: string;
}

async function fetchData<T>(url: string): Promise<ApiResponse<T>> {
  const response = await fetch(url);
  const data = await response.json();
  return {
    data,
    status: response.status
  };
}

// Usage
const users = await fetchData<User[]>("/api/users");
const product = await fetchData<Product>("/api/products/1");
```

### Example 2: Generic State Manager
```typescript
class State<T> {
  private state: T;
  private listeners: Array<(state: T) => void> = [];

  constructor(initialState: T) {
    this.state = initialState;
  }

  get(): T {
    return this.state;
  }

  set(newState: T | ((prev: T) => T)): void {
    this.state = typeof newState === "function"
      ? (newState as (prev: T) => T)(this.state)
      : newState;
    this.notify();
  }

  subscribe(listener: (state: T) => void): () => void {
    this.listeners.push(listener);
    return () => {
      this.listeners = this.listeners.filter(l => l !== listener);
    };
  }

  private notify(): void {
    this.listeners.forEach(listener => listener(this.state));
  }
}

const counter = new State<number>(0);
counter.subscribe(state => console.log(state));
counter.set(state => state + 1);
```

## Common Patterns

### Multiple Type Parameters
```typescript
function map<T, U>(arr: T[], fn: (item: T) => U): U[] {
  return arr.map(fn);
}

const numbers = [1, 2, 3];
const strings = map(numbers, n => n.toString());
```

### Default Generic Types
```typescript
interface Response<T = unknown> {
  data: T;
  status: number;
}

const response1: Response = { data: "anything", status: 200 };
const response2: Response<User> = { data: { id: 1, name: "Alice" }, status: 200 };
```

## Resources
- [TypeScript Handbook - Generics](https://www.typescriptlang.org/docs/handbook/2/generics.html)
- [Advanced Generic Patterns](https://www.typescriptlang.org/docs/handbook/2/types-from-types.html)

## Next Steps
- **Type Guards Skill**
- **TypeScript React Skill**
- **Advanced Types Agent**

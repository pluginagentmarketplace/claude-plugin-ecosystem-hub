# Skill: Decorators

## Overview
Master TypeScript decorators for metaprogramming, cross-cutting concerns, and building framework-like functionality.

## Learning Objectives
- Use class, method, property, and parameter decorators
- Create decorator factories
- Work with reflect-metadata
- Build reusable decorator patterns
- Apply decorators in real-world scenarios

## Difficulty
Advanced

## Estimated Time
5-7 hours

## Key Concepts

### Enable Decorators
```json
// tsconfig.json
{
  "compilerOptions": {
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true
  }
}
```

### Method Decorator
```typescript
function log(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
  const originalMethod = descriptor.value;

  descriptor.value = function (...args: any[]) {
    console.log(`Calling ${propertyKey} with:`, args);
    const result = originalMethod.apply(this, args);
    console.log(`Result:`, result);
    return result;
  };

  return descriptor;
}

class Calculator {
  @log
  add(a: number, b: number): number {
    return a + b;
  }
}
```

### Class Decorator
```typescript
function sealed(constructor: Function) {
  Object.seal(constructor);
  Object.seal(constructor.prototype);
}

@sealed
class Greeter {
  greeting: string;
  constructor(message: string) {
    this.greeting = message;
  }
}
```

### Property Decorator
```typescript
function readonly(target: any, propertyKey: string) {
  Object.defineProperty(target, propertyKey, {
    writable: false
  });
}

class Person {
  @readonly
  name: string = "Alice";
}
```

## Practical Examples

### Example 1: Memoization
```typescript
function memoize(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
  const originalMethod = descriptor.value;
  const cache = new Map();

  descriptor.value = function (...args: any[]) {
    const key = JSON.stringify(args);
    if (cache.has(key)) {
      return cache.get(key);
    }
    const result = originalMethod.apply(this, args);
    cache.set(key, result);
    return result;
  };

  return descriptor;
}

class DataService {
  @memoize
  expensiveOperation(id: number): any {
    console.log("Computing...");
    return { id, data: Math.random() };
  }
}
```

### Example 2: Validation
```typescript
import "reflect-metadata";

const validationMetadataKey = Symbol("validation");

function IsEmail() {
  return function (target: any, propertyKey: string) {
    const rules = Reflect.getMetadata(validationMetadataKey, target.constructor) || [];
    rules.push({
      property: propertyKey,
      validator: (value: string) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)
    });
    Reflect.defineMetadata(validationMetadataKey, rules, target.constructor);
  };
}

class RegisterDTO {
  @IsEmail()
  email: string;
}
```

## Resources
- [TypeScript Handbook - Decorators](https://www.typescriptlang.org/docs/handbook/decorators.html)
- [Reflect Metadata](https://github.com/rbuckton/reflect-metadata)

## Next Steps
- **TypeScript Node Skill**
- **Decorators & Metadata Agent**

# TypeScript Plugin - Complete Learning Ecosystem

Master TypeScript from fundamentals to advanced patterns with 7 specialized agents and 7 practical skills.

## Quick Start

```bash
# Install the plugin
claude plugin install custom-plugin-typescript

# Start with fundamentals
claude run --plugin custom-plugin-typescript --agent 01-typescript-fundamentals

# Practice with skills
claude run --plugin custom-plugin-typescript --skill typescript-types
```

## What You'll Learn

### Core Type System
- Basic types, interfaces, and type aliases
- Generics and type parameters
- Union and intersection types
- Conditional and mapped types
- Template literal types

### Advanced Features
- Type guards and type narrowing
- Decorators and metadata reflection
- Utility types and type transformations
- Type inference and control flow analysis

### Real-World Integration
- TypeScript with React (components, hooks, context)
- TypeScript with Node.js (Express, APIs, file system)
- Testing with Jest/Vitest
- Migration strategies from JavaScript

## Learning Paths

### 🎯 Frontend Developer (10-14 weeks)
Perfect for React developers wanting type safety.

1. TypeScript Fundamentals (4 weeks)
2. Advanced Types (4 weeks)
3. Type System (3 weeks)
4. TypeScript + React Skill

**Outcome:** Build type-safe React applications

### 🎯 Backend Developer (12-16 weeks)
Ideal for Node.js developers building APIs.

1. TypeScript Fundamentals (4 weeks)
2. Advanced Types (4 weeks)
3. Type System (3 weeks)
4. Decorators & Metadata (3 weeks)
5. TypeScript + Node.js Skill
6. Testing Types

**Outcome:** Create robust, type-safe backend services

### 🎯 Migration Specialist (8-12 weeks)
For teams converting JavaScript codebases.

1. TypeScript Fundamentals (3 weeks)
2. Configuration (2 weeks)
3. Type System (2 weeks)
4. Migration Best Practices (3-5 weeks)

**Outcome:** Successfully migrate JavaScript projects to TypeScript

## 7 Agents

| Agent | Focus | Level | Duration |
|-------|-------|-------|----------|
| **01-Fundamentals** | Basic types, interfaces, functions | Beginner | 4 weeks |
| **02-Advanced Types** | Union, conditional, mapped types | Intermediate | 4-5 weeks |
| **03-Type System** | Guards, narrowing, inference | Intermediate | 3-4 weeks |
| **04-Decorators** | Decorators, metadata, DI | Advanced | 3-4 weeks |
| **05-Configuration** | tsconfig, compiler options | Intermediate | 2-3 weeks |
| **06-Testing** | Jest, Vitest, type testing | Intermediate | 3-4 weeks |
| **07-Migration** | JS to TS conversion strategies | Advanced | 4-12 weeks |

## 7 Skills

| Skill | Description | Difficulty |
|-------|-------------|------------|
| **TypeScript Types** | Basic type system mastery | Beginner |
| **Generics Patterns** | Reusable type-safe code | Intermediate |
| **Type Guards** | Runtime type checking | Intermediate |
| **Decorators** | Metaprogramming patterns | Advanced |
| **TypeScript + React** | Type-safe React apps | Intermediate |
| **TypeScript + Node** | Backend TypeScript | Intermediate |
| **TypeScript Testing** | Jest/Vitest integration | Intermediate |

## Prerequisites

- **JavaScript ES6+** proficiency
- **Understanding of:**
  - Variables, functions, objects
  - Arrays and array methods
  - Promises and async/await
  - Modules (import/export)
- **Optional but helpful:**
  - React or Node.js experience
  - Testing framework knowledge
  - Object-oriented programming concepts

## Installation

```bash
# Clone the repository
git clone https://github.com/pluginagentmarketplace/claude-plugin-ecosystem-hub.git

# Navigate to TypeScript plugin
cd claude-plugin-ecosystem-hub/custom-plugin-typescript

# Install with Claude Code
claude plugin install .
```

## Project Structure

```
custom-plugin-typescript/
├── agents/                     # 7 specialized teaching agents
│   ├── 01-typescript-fundamentals.md
│   ├── 02-advanced-types.md
│   ├── 03-type-system.md
│   ├── 04-decorators-metadata.md
│   ├── 05-typescript-configuration.md
│   ├── 06-testing-types.md
│   └── 07-migration-best-practices.md
├── skills/                     # 7 practical skill modules
│   ├── typescript-types/
│   ├── generics-patterns/
│   ├── type-guards/
│   ├── decorators/
│   ├── typescript-react/
│   ├── typescript-node/
│   └── typescript-testing/
├── docs/                       # Additional documentation
├── .claude-plugin/
│   └── plugin.json            # Plugin manifest
├── plugin.md                   # Plugin overview
└── README.md                   # This file
```

## Examples

### TypeScript Fundamentals
```typescript
// Basic types
interface User {
  id: number;
  name: string;
  email: string;
  role: "admin" | "user";
}

function createUser(name: string, email: string): User {
  return {
    id: Math.random(),
    name,
    email,
    role: "user"
  };
}
```

### Generics
```typescript
// Generic function
function toArray<T>(value: T): T[] {
  return [value];
}

// Generic class
class DataStore<T> {
  private data: T[] = [];

  add(item: T): void {
    this.data.push(item);
  }

  getAll(): T[] {
    return this.data;
  }
}
```

### Type Guards
```typescript
// Custom type guard
function isUser(obj: unknown): obj is User {
  return (
    typeof obj === "object" &&
    obj !== null &&
    "id" in obj &&
    "name" in obj &&
    "email" in obj
  );
}

function processData(data: unknown) {
  if (isUser(data)) {
    console.log(data.name); // TypeScript knows it's User
  }
}
```

### React with TypeScript
```typescript
import React, { FC, useState } from "react";

interface TodoProps {
  todo: {
    id: number;
    text: string;
    completed: boolean;
  };
  onToggle: (id: number) => void;
}

export const TodoItem: FC<TodoProps> = ({ todo, onToggle }) => {
  return (
    <div>
      <input
        type="checkbox"
        checked={todo.completed}
        onChange={() => onToggle(todo.id)}
      />
      <span>{todo.text}</span>
    </div>
  );
};
```

## Best Practices

✅ **Enable strict mode** in tsconfig.json
✅ **Avoid `any`** - use `unknown` when type is uncertain
✅ **Leverage type inference** - let TypeScript infer obvious types
✅ **Use readonly** for immutability
✅ **Create custom type guards** for runtime validation
✅ **Test your types** with tsd or expect-type
✅ **Migrate incrementally** - don't convert everything at once

## Common Pitfalls

❌ Using `any` everywhere (defeats purpose of TypeScript)
❌ Not enabling strict mode
❌ Overusing type assertions (`as`)
❌ Ignoring null/undefined checks
❌ Not writing type tests for libraries
❌ Migrating entire codebase at once

## Resources

### Official Documentation
- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/intro.html)
- [TypeScript Playground](https://www.typescriptlang.org/play)
- [TSConfig Reference](https://www.typescriptlang.org/tsconfig)

### Community Resources
- [TypeScript Deep Dive](https://basarat.gitbook.io/typescript/)
- [React TypeScript Cheatsheet](https://react-typescript-cheatsheet.netlify.app/)
- [Type Challenges](https://github.com/type-challenges/type-challenges)

### Tools
- [DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped) - Type definitions
- [ts-node](https://github.com/TypeStrong/ts-node) - TypeScript execution
- [tsx](https://github.com/esbuild-kit/tsx) - TypeScript executor (fast)

## Contributing

Contributions welcome! Please:

1. Follow existing agent/skill structure
2. Include practical examples
3. Add exercises for validation
4. Ensure type safety throughout
5. Update plugin.json manifest

## License

MIT License - see LICENSE file for details

## Support

- **Issues:** [GitHub Issues](https://github.com/pluginagentmarketplace/claude-plugin-ecosystem-hub/issues)
- **Discussions:** [GitHub Discussions](https://github.com/pluginagentmarketplace/claude-plugin-ecosystem-hub/discussions)
- **Email:** pluginagentmarketplace@gmail.com

## Acknowledgments

Based on:
- [roadmap.sh/typescript](https://roadmap.sh/typescript) - Learning roadmap
- TypeScript official documentation
- Community best practices

---

**Ready to master TypeScript?** Start with the TypeScript Fundamentals Agent!

```bash
claude run --plugin custom-plugin-typescript --agent 01-typescript-fundamentals
```

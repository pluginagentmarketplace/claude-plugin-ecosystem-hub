# Skill: TypeScript with Node.js

## Overview
Master TypeScript integration with Node.js for building type-safe backend applications, APIs, and server-side logic.

## Learning Objectives
- Set up TypeScript in Node.js projects
- Type Express.js applications
- Work with file system and streams
- Type async/await patterns
- Build type-safe REST APIs

## Difficulty
Intermediate

## Estimated Time
6-8 hours

## Key Concepts

### Project Setup
```json
// tsconfig.json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "lib": ["ES2022"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "types": ["node"]
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}

// package.json
{
  "type": "module",
  "scripts": {
    "build": "tsc",
    "start": "node dist/index.js",
    "dev": "tsx watch src/index.ts"
  },
  "devDependencies": {
    "@types/node": "^20.0.0",
    "typescript": "^5.0.0",
    "tsx": "^4.0.0"
  }
}
```

### Express with TypeScript
```typescript
import express, { Request, Response, NextFunction } from "express";

const app = express();
app.use(express.json());

// Type-safe route handler
interface UserParams {
  id: string;
}

interface CreateUserBody {
  name: string;
  email: string;
}

app.get("/users/:id", (
  req: Request<UserParams>,
  res: Response
) => {
  const userId = parseInt(req.params.id);
  res.json({ id: userId, name: "Alice" });
});

app.post("/users", (
  req: Request<{}, {}, CreateUserBody>,
  res: Response
) => {
  const { name, email } = req.body;
  res.json({ id: 1, name, email });
});

// Custom middleware
interface AuthRequest extends Request {
  user?: { id: number; email: string };
}

function authMiddleware(
  req: AuthRequest,
  res: Response,
  next: NextFunction
) {
  const token = req.headers.authorization;
  if (!token) {
    return res.status(401).json({ error: "Unauthorized" });
  }
  req.user = { id: 1, email: "user@example.com" };
  next();
}

app.get("/profile", authMiddleware, (
  req: AuthRequest,
  res: Response
) => {
  res.json(req.user);
});

app.listen(3000, () => {
  console.log("Server running on port 3000");
});
```

### File System Operations
```typescript
import { promises as fs } from "fs";
import path from "path";

async function readJsonFile<T>(filePath: string): Promise<T> {
  const content = await fs.readFile(filePath, "utf-8");
  return JSON.parse(content) as T;
}

async function writeJsonFile<T>(filePath: string, data: T): Promise<void> {
  const dir = path.dirname(filePath);
  await fs.mkdir(dir, { recursive: true });
  await fs.writeFile(filePath, JSON.stringify(data, null, 2));
}

interface Config {
  apiKey: string;
  endpoint: string;
}

const config = await readJsonFile<Config>("./config.json");
await writeJsonFile<Config>("./config.json", { apiKey: "key", endpoint: "url" });
```

## Practical Examples

### Example 1: RESTful API
```typescript
import express, { Express } from "express";

interface User {
  id: number;
  name: string;
  email: string;
}

class UserService {
  private users: User[] = [];
  private nextId = 1;

  findAll(): User[] {
    return this.users;
  }

  findById(id: number): User | undefined {
    return this.users.find(u => u.id === id);
  }

  create(data: Omit<User, "id">): User {
    const user = { id: this.nextId++, ...data };
    this.users.push(user);
    return user;
  }

  update(id: number, data: Partial<Omit<User, "id">>): User | undefined {
    const index = this.users.findIndex(u => u.id === id);
    if (index === -1) return undefined;
    this.users[index] = { ...this.users[index], ...data };
    return this.users[index];
  }

  delete(id: number): boolean {
    const index = this.users.findIndex(u => u.id === id);
    if (index === -1) return false;
    this.users.splice(index, 1);
    return true;
  }
}

function createApp(): Express {
  const app = express();
  const userService = new UserService();

  app.use(express.json());

  app.get("/users", (req, res) => {
    res.json(userService.findAll());
  });

  app.get("/users/:id", (req, res) => {
    const user = userService.findById(parseInt(req.params.id));
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }
    res.json(user);
  });

  app.post("/users", (req, res) => {
    const user = userService.create(req.body);
    res.status(201).json(user);
  });

  return app;
}

const app = createApp();
app.listen(3000);
```

## Resources
- [Node.js TypeScript Guide](https://nodejs.org/en/learn/getting-started/nodejs-with-typescript)
- [Express TypeScript](https://github.com/DefinitelyTyped/DefinitelyTyped/tree/master/types/express)

## Next Steps
- **TypeScript Testing Skill**
- **Migration Best Practices Agent**

# Skill: TypeScript with React

## Overview
Master TypeScript integration with React for building type-safe, maintainable React applications.

## Learning Objectives
- Type React components (functional and class)
- Use TypeScript with hooks
- Type props, state, and events
- Work with refs and context
- Type custom hooks

## Difficulty
Intermediate

## Estimated Time
6-8 hours

## Key Concepts

### Functional Components
```typescript
import React, { FC } from "react";

interface UserCardProps {
  user: {
    id: number;
    name: string;
    email: string;
  };
  onEdit: (id: number) => void;
  className?: string;
}

export const UserCard: FC<UserCardProps> = ({ user, onEdit, className }) => {
  return (
    <div className={className}>
      <h3>{user.name}</h3>
      <p>{user.email}</p>
      <button onClick={() => onEdit(user.id)}>Edit</button>
    </div>
  );
};
```

### Hooks with TypeScript
```typescript
import { useState, useEffect, useRef } from "react";

// useState
const [count, setCount] = useState<number>(0);
const [user, setUser] = useState<User | null>(null);

// useEffect
useEffect(() => {
  // Cleanup function is properly typed
  return () => {
    console.log("Cleanup");
  };
}, []);

// useRef
const inputRef = useRef<HTMLInputElement>(null);
inputRef.current?.focus();

// Custom hook
function useLocalStorage<T>(key: string, initialValue: T) {
  const [storedValue, setStoredValue] = useState<T>(() => {
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      return initialValue;
    }
  });

  const setValue = (value: T | ((val: T) => T)) => {
    try {
      const valueToStore = value instanceof Function ? value(storedValue) : value;
      setStoredValue(valueToStore);
      window.localStorage.setItem(key, JSON.stringify(valueToStore));
    } catch (error) {
      console.error(error);
    }
  };

  return [storedValue, setValue] as const;
}
```

### Event Handling
```typescript
import { ChangeEvent, FormEvent, MouseEvent } from "react";

function Form() {
  const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
    console.log(e.target.value);
  };

  const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    // Handle submit
  };

  const handleClick = (e: MouseEvent<HTMLButtonElement>) => {
    console.log(e.currentTarget);
  };

  return (
    <form onSubmit={handleSubmit}>
      <input onChange={handleChange} />
      <button onClick={handleClick}>Submit</button>
    </form>
  );
}
```

### Context API
```typescript
import { createContext, useContext, ReactNode } from "react";

interface AuthContextType {
  user: User | null;
  login: (email: string, password: string) => Promise<void>;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null);

  const login = async (email: string, password: string) => {
    // Login logic
  };

  const logout = () => {
    setUser(null);
  };

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error("useAuth must be used within AuthProvider");
  }
  return context;
}
```

## Practical Examples

### Example 1: Form Component
```typescript
interface FormData {
  email: string;
  password: string;
}

interface LoginFormProps {
  onSubmit: (data: FormData) => Promise<void>;
}

export function LoginForm({ onSubmit }: LoginFormProps) {
  const [formData, setFormData] = useState<FormData>({
    email: "",
    password: ""
  });
  const [errors, setErrors] = useState<Partial<FormData>>({});
  const [loading, setLoading] = useState(false);

  const handleChange = (field: keyof FormData) => (
    e: ChangeEvent<HTMLInputElement>
  ) => {
    setFormData(prev => ({ ...prev, [field]: e.target.value }));
  };

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      await onSubmit(formData);
    } finally {
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="email"
        value={formData.email}
        onChange={handleChange("email")}
      />
      <input
        type="password"
        value={formData.password}
        onChange={handleChange("password")}
      />
      <button disabled={loading}>
        {loading ? "Loading..." : "Submit"}
      </button>
    </form>
  );
}
```

## Resources
- [React TypeScript Cheatsheet](https://react-typescript-cheatsheet.netlify.app/)
- [React Hooks with TypeScript](https://react-typescript-cheatsheet.netlify.app/docs/basic/getting-started/hooks)

## Next Steps
- **TypeScript Testing Skill**
- **TypeScript Node Skill**

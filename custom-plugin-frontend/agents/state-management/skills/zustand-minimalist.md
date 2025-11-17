# Skill: Zustand - Minimalist State

**Level:** Core
**Duration:** 1 week
**Agent:** State Management
**Prerequisites:** JavaScript Fundamentals

## Overview
Learn Zustand, the lightweight state management solution. Perfect for simple to medium complexity applications.

## Key Topics

- Store creation
- Hooks and selectors
- Middleware
- Async operations
- DevTools integration

## Learning Objectives

- Create stores
- Use store hooks
- Handle async state
- Optimize subscriptions
- Combine stores

## Practical Exercises

### Basic store
```javascript
import create from 'zustand';

const useStore = create((set) => ({
  count: 0,
  increment: () => set(state => ({ count: state.count + 1 })),
  decrement: () => set(state => ({ count: state.count - 1 }))
}));

function Counter() {
  const count = useStore(state => state.count);
  return <p>{count}</p>;
}
```

## Resources

- [Zustand Docs](https://github.com/pmndrs/zustand)

---
**Status:** Active | **Version:** 1.0.0

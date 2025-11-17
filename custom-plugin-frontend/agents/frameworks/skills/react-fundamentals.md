# Skill: React Fundamentals

**Level:** Core
**Duration:** 2 weeks
**Agent:** Frameworks
**Prerequisites:** JavaScript Fundamentals

## Overview
Learn React, the dominant JavaScript framework. Master components, JSX, hooks, and state management.

## Key Topics

- Components (functional and class)
- JSX syntax
- Props and state
- Hooks (useState, useEffect, etc.)
- Event handling
- Conditional rendering

## Learning Objectives

- Build functional components
- Understand component lifecycle
- Manage state with hooks
- Handle user events
- Create reusable components

## Practical Exercises

### Functional component
```javascript
function Counter() {
  const [count, setCount] = useState(0);
  
  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>
        Increment
      </button>
    </div>
  );
}
```

### useEffect hook
```javascript
useEffect(() => {
  document.title = `Count: ${count}`;
}, [count]);
```

## Resources

- [React Official Docs](https://react.dev/)
- [React Hooks Guide](https://react.dev/reference/react/hooks)

---
**Status:** Active | **Version:** 1.0.0

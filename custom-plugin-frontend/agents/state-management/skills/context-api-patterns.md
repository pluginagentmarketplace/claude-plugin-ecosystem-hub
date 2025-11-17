# Skill: Context API & Custom Hooks

**Level:** Core
**Duration:** 1 week
**Agent:** State Management
**Prerequisites:** React Fundamentals

## Overview
Master React's built-in state management. Learn Context API and custom hooks for managing shared state without Redux.

## Key Topics

- Creating context
- Providers and consumers
- useContext hook
- Custom hooks
- Performance optimization
- When to use Context vs Redux

## Learning Objectives

- Create Context
- Provide and consume context
- Build custom hooks
- Optimize re-renders
- Choose between solutions

## Practical Exercises

### Context setup
```javascript
const ThemeContext = createContext();

export function ThemeProvider({ children }) {
  const [theme, setTheme] = useState('light');
  
  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}

function useTheme() {
  return useContext(ThemeContext);
}
```

## Resources

- [React Context](https://react.dev/reference/react/useContext)
- [Custom Hooks](https://react.dev/learn/reusing-logic-with-custom-hooks)

---
**Status:** Active | **Version:** 1.0.0

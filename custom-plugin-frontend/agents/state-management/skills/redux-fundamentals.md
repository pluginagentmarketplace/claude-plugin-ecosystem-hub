# Skill: Redux Fundamentals

**Level:** Core
**Duration:** 1.5 weeks
**Agent:** State Management
**Prerequisites:** Framework Fundamentals

## Overview
Learn Redux, the predictable state management library. Master actions, reducers, and the store pattern for complex applications.

## Key Topics

- Actions and action creators
- Reducers and pure functions
- Store and subscriptions
- Middleware
- Selectors
- Redux Toolkit

## Learning Objectives

- Create actions and reducers
- Set up Redux store
- Dispatch actions
- Select state
- Use Redux Toolkit
- Debug with DevTools

## Practical Exercises

### Basic Redux setup
```javascript
const initialState = { count: 0 };

const counterReducer = (state = initialState, action) => {
  switch(action.type) {
    case 'INCREMENT':
      return { count: state.count + 1 };
    default:
      return state;
  }
};

const store = createStore(counterReducer);
```

## Resources

- [Redux Docs](https://redux.js.org/)
- [Redux Toolkit](https://redux-toolkit.js.org/)

---
**Status:** Active | **Version:** 1.0.0

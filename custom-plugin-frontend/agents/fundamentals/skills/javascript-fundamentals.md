# Skill: JavaScript Fundamentals

**Level:** Foundation
**Duration:** 2 weeks
**Agent:** Fundamentals
**Prerequisites:** None

## Overview
Learn the programming language of the web. JavaScript powers interactive web applications and is essential for all frontend development.

## Learning Objectives

- Write clean, readable JavaScript code
- Master ES6+ syntax and features
- Handle asynchronous operations
- Work with arrays and objects
- Understand scope and closures
- Handle errors appropriately

## Key Topics

### Variables & Data Types
- `let`, `const`, `var` declarations
- Primitive types: string, number, boolean, null, undefined, symbol
- Objects and arrays
- Type coercion and conversion

### Operators & Control Flow
- Arithmetic, logical, comparison operators
- if/else, switch statements
- for, while, do-while loops
- Array methods: map, filter, reduce
- Template literals

### Functions
- Function declarations and expressions
- Arrow functions
- Default parameters and rest parameters
- Closures and scope
- Callbacks and higher-order functions

### ES6+ Features
- Destructuring (objects and arrays)
- Spread operator
- Classes and inheritance
- Modules (import/export)
- Promise and async/await
- Optional chaining and nullish coalescing

### Error Handling
- try/catch/finally
- Error types and custom errors
- Proper error propagation
- Debugging techniques

## Practical Exercises

### Exercise 1: Variables and Scope
```javascript
let globalVar = 'global';

function testScope() {
  let localVar = 'local';
  const constant = 'immutable';

  console.log(globalVar); // 'global'
  console.log(localVar);  // 'local'
}

console.log(constant); // Error: not defined
```

### Exercise 2: Array Methods
```javascript
const numbers = [1, 2, 3, 4, 5];

const doubled = numbers.map(n => n * 2);
const evens = numbers.filter(n => n % 2 === 0);
const sum = numbers.reduce((a, b) => a + b, 0);
```

### Exercise 3: Promises and Async/Await
```javascript
async function fetchData() {
  try {
    const response = await fetch('https://api.example.com/data');
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error:', error);
  }
}
```

### Exercise 4: Classes
```javascript
class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;
  }

  greet() {
    return `Hello, ${this.name}!`;
  }
}

const user = new User('John', 'john@example.com');
```

## Real-World Projects

### Project 1: Calculator App
- Basic operations
- Error handling
- User input validation

### Project 2: API Data Fetcher
- Promises and async/await
- Array manipulation
- Error handling

### Project 3: Object-Oriented Program
- Classes and inheritance
- Encapsulation
- Polymorphism

## Assessment Criteria

- ✅ Correct syntax and semantics
- ✅ Proper variable scoping
- ✅ Effective array/object usage
- ✅ Correct async handling
- ✅ Clean, readable code

## Resources

- [JavaScript.info: Language Basics](https://javascript.info/)
- [MDN: JavaScript Guide](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide)
- [You Don't Know JS](https://github.com/getify/You-Dont-Know-JS)
- [ES6+ Features](https://es6-features.org/)

## Next Skills

- DOM Manipulation
- Asynchronous Programming
- Error Handling & Debugging

---
**Status:** Active | **Version:** 1.0.0

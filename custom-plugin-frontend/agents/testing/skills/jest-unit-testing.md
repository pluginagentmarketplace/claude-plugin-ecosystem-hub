# Skill: Jest & Unit Testing

**Level:** Core
**Duration:** 1.5 weeks
**Agent:** Testing
**Prerequisites:** JavaScript Fundamentals

## Overview
Master Jest, the industry-standard testing framework. Learn to write comprehensive unit tests for your code.

## Key Topics

- Test structure and setup
- Assertions and matchers
- Mocking functions and modules
- Async testing
- Snapshot testing
- Coverage reporting

## Learning Objectives

- Write unit tests
- Use assertions effectively
- Mock dependencies
- Test async code
- Generate coverage reports

## Practical Exercises

### Basic test
```javascript
describe('sum function', () => {
  it('adds two numbers correctly', () => {
    expect(sum(2, 3)).toBe(5);
  });
});
```

### Mocking
```javascript
jest.mock('./api');
const api = require('./api');

api.getUser.mockResolvedValue({ id: 1, name: 'John' });
```

## Resources

- [Jest Docs](https://jestjs.io/)
- [Testing Patterns](https://kentcdodds.com/blog/common-mistakes-with-react-testing-library)

---
**Status:** Active | **Version:** 1.0.0

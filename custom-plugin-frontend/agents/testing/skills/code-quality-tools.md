# Skill: Code Quality & Linting

**Level:** Core
**Duration:** 1 week
**Agent:** Testing
**Prerequisites:** Testing Fundamentals

## Overview
Master code quality tools including ESLint, Prettier, and TypeScript. Ensure code consistency and catch bugs early.

## Key Topics

- ESLint configuration
- Prettier formatting
- Pre-commit hooks
- TypeScript setup
- Code coverage

## Learning Objectives

- Configure ESLint
- Set up Prettier
- Use TypeScript
- Implement pre-commit hooks
- Monitor coverage

## Practical Exercises

### ESLint config
```javascript
module.exports = {
  extends: ['eslint:recommended'],
  rules: {
    'no-console': 'warn'
  }
};
```

### Pre-commit hooks
```json
{
  "husky": {
    "hooks": {
      "pre-commit": "lint-staged"
    }
  }
}
```

## Resources

- [ESLint Docs](https://eslint.org/)
- [Prettier Docs](https://prettier.io/)

---
**Status:** Active | **Version:** 1.0.0

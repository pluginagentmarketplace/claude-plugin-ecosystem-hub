# Skill: E2E Testing with Cypress

**Level:** Core
**Duration:** 1.5 weeks
**Agent:** Testing
**Prerequisites:** Testing Fundamentals

## Overview
Learn Cypress, the developer-friendly E2E testing framework. Write and debug end-to-end tests with excellent developer experience.

## Key Topics

- Writing Cypress tests
- Selecting elements
- User interactions
- Assertions
- Debugging tests
- CI/CD integration

## Learning Objectives

- Write E2E tests
- Handle async operations
- Debug test failures
- Integrate with CI/CD
- Test complete user flows

## Practical Exercises

### E2E test
```javascript
describe('Login flow', () => {
  it('logs user in successfully', () => {
    cy.visit('/login');
    cy.get('[data-testid="email"]').type('user@example.com');
    cy.get('[data-testid="password"]').type('password');
    cy.get('button').click();
    cy.url().should('include', '/dashboard');
  });
});
```

## Resources

- [Cypress Docs](https://docs.cypress.io/)
- [Cypress Best Practices](https://docs.cypress.io/guides/references/best-practices)

---
**Status:** Active | **Version:** 1.0.0

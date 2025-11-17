# Testing & Quality Assurance Agent

## Agent Profile
**Name:** Quality Assurance Expert
**Specialization:** Unit Testing, Integration Testing, E2E Testing, Code Quality
**Level:** Intermediate to Advanced
**Duration:** 4-5 weeks (25-30 hours)
**Prerequisites:** Fundamentals Agent + Frameworks Agent

## Philosophy
The Testing Agent transforms developers from "test-aware" to "test-driven." In production environments, well-tested code is non-negotiable. This agent covers the complete testing pyramid: unit tests, integration tests, and end-to-end tests, plus code quality tools that prevent bugs before they happen.

## Agent Capabilities

### 1. Unit Testing
- **Jest** - Industry standard framework
- **Vitest** - Modern alternative with HMR
- **Test structure** - Setup, execution, assertions
- **Mocking** - Functions, modules, timers
- **Assertions** - Expect API mastery
- **Test organization** - Describe blocks, beforeEach
- **Snapshot testing** - Visual regression

### 2. Testing Libraries
- **React Testing Library** - User-centric testing
- **Vue Test Utils** - Official Vue testing
- **Testing Library ecosystems** - Angular, Svelte
- **User Event Library** - Realistic interactions
- **Assertions Library** - @testing-library/jest-dom

### 3. Integration Testing
- **Component integration** - Multiple components
- **State management testing** - Redux, Zustand
- **API mocking** - Mock Service Worker
- **Router testing** - Navigation and redirects
- **Form testing** - Complex interactions

### 4. End-to-End Testing
- **Cypress** - Developer-friendly E2E
- **Playwright** - Cross-browser E2E
- **Test automation** - Recording and scripts
- **Visual testing** - Screenshots and videos
- **Accessibility testing** - WCAG compliance

### 5. Code Quality Tools
- **ESLint** - Static code analysis
- **Prettier** - Code formatting
- **TypeScript** - Type safety
- **Husky & lint-staged** - Pre-commit hooks
- **SonarQube/SonarCloud** - Code metrics

### 6. Testing Strategies
- **Testing Pyramid** - Optimal test distribution
- **Test-Driven Development (TDD)** - Red-green-refactor
- **Behavior-Driven Development (BDD)** - Gherkin syntax
- **Coverage metrics** - Meaningful targets
- **CI/CD integration** - Automated testing

## Learning Outcomes

After completing this agent, developers will:
- ✅ Write comprehensive unit tests
- ✅ Build integration tests
- ✅ Create end-to-end tests
- ✅ Achieve meaningful coverage
- ✅ Use code quality tools
- ✅ Practice TDD/BDD
- ✅ Debug test failures
- ✅ Implement CI/CD testing

## Skill Hierarchy

### Foundation Level (Week 1)
1. **Testing Fundamentals** - Why testing matters
2. **Jest Introduction** - Basic test structure
3. **Test Assertions** - Expect API basics

### Core Level (Week 1-2)
4. **Jest Mastery** - Mocking and advanced features
5. **React Testing Library** - Component testing
6. **Integration Testing** - Multi-component tests

### Advanced Level (Week 2-3)
7. **Cypress E2E** - End-to-end automation
8. **Playwright** - Cross-browser testing
9. **Test Coverage** - Meaningful metrics

### Quality Level (Week 3-4)
10. **ESLint & Prettier** - Code quality
11. **TypeScript Testing** - Type-safe tests
12. **Pre-commit Hooks** - Quality gates

### Advanced Level (Week 4-5)
13. **TDD & BDD** - Test-first approaches
14. **Accessibility Testing** - WCAG compliance
15. **Capstone Project** - Full test suite

## Prerequisites
- Completion of Fundamentals Agent
- Framework knowledge (React/Vue/Angular)
- JavaScript proficiency
- Basic understanding of async code

## Tools Required
- **Test Runners:** Jest or Vitest
- **Testing Libraries:** React Testing Library
- **E2E Tools:** Cypress or Playwright
- **Code Quality:** ESLint, Prettier
- **Editor:** VS Code with extensions

## Project-Based Learning

### Project 1: Jest & Unit Tests (Week 1-2)
Test utility functions and business logic:
- Pure function testing
- Mocking dependencies
- Async testing
- Coverage analysis

### Project 2: React Component Testing (Week 2)
Test React components thoroughly:
- Component rendering
- User interactions
- State changes
- Props validation

### Project 3: Integration Tests (Week 2-3)
Test component interactions:
- Multiple components working together
- State management integration
- Router navigation
- API mocking

### Project 4: E2E Application Testing (Week 3-4)
Complete user journey testing:
- Multi-page flows
- User authentication
- Form submissions
- Data validation

### Project 5: Full Test Suite (Week 4-5)
Comprehensive testing setup:
- Unit, integration, E2E tests
- Code quality tools
- CI/CD pipeline
- Coverage reports

## Recommended Resources

### Jest & Vitest
- [Jest Official Docs](https://jestjs.io/)
- [Vitest Documentation](https://vitest.dev/)
- [Testing Library](https://testing-library.com/)
- [Jest Cheatsheet](https://cheatsheets.zip/jest)

### E2E Testing
- [Cypress Official Docs](https://docs.cypress.io/)
- [Playwright Official Docs](https://playwright.dev/)
- [Cypress vs Playwright](https://www.browserstack.com/guide/cypress-vs-playwright)

### Code Quality
- [ESLint Docs](https://eslint.org/)
- [Prettier Docs](https://prettier.io/)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)

## Learning Outcomes Checklist

### Unit Testing
- [ ] Write Jest tests
- [ ] Mock functions and modules
- [ ] Test async code
- [ ] Organize tests effectively
- [ ] Generate coverage reports
- [ ] Use Vitest with modern setup

### Component Testing
- [ ] Render components
- [ ] Query elements (role, label, text)
- [ ] Trigger user events
- [ ] Assert state changes
- [ ] Test error states
- [ ] Test loading states

### Integration Testing
- [ ] Test component interactions
- [ ] Mock API calls
- [ ] Test state management
- [ ] Test routing
- [ ] Test forms
- [ ] Handle async flows

### E2E Testing
- [ ] Write Cypress tests
- [ ] Use Playwright
- [ ] Test complete user flows
- [ ] Handle authentication
- [ ] Test error scenarios
- [ ] Record and debug

### Code Quality
- [ ] Configure ESLint
- [ ] Set up Prettier
- [ ] Use TypeScript effectively
- [ ] Implement pre-commit hooks
- [ ] Integrate with CI/CD
- [ ] Monitor code metrics

## Daily Schedule (Example Week)

**Monday:** Testing concepts + Jest introduction
**Tuesday:** Unit testing exercises and practice
**Wednesday:** Component testing with React Testing Library
**Thursday:** Integration testing + E2E introduction
**Friday:** Project work + CI/CD setup

## Assessment Criteria

- **Test Coverage:** 30% of grade
- **Test Quality:** 30% of grade
- **Code Quality:** 20% of grade
- **Best Practices:** 20% of grade

## Testing Pyramid Best Practices

```
        /\
       /E2E\         10% - Few, slow, expensive
      /______\
     /        \
    /Integration\   20% - Medium, moderate cost
   /____________\
  /              \
 /  Unit Tests    \ 70% - Many, fast, cheap
/________________\
```

**Distribution Targets:**
- Unit Tests: 70% (fast, cheap, focused)
- Integration: 20% (medium speed/cost)
- E2E: 10% (slow, expensive, critical paths)

## Jest vs Vitest Comparison

| Feature | Jest | Vitest |
|---------|------|--------|
| **Speed** | Good | 10-20x faster |
| **Setup** | Zero-config | Zero-config (Vite) |
| **ESM** | Limited | Native |
| **Watch Mode** | Good | Excellent |
| **TypeScript** | Excellent | Excellent |
| **Community** | Massive | Growing |
| **Best For** | Established projects | Modern stacks |

**Recommendation:** Use Vitest for new projects; Jest for broader compatibility.

## Cypress vs Playwright Comparison

| Feature | Cypress | Playwright |
|---------|---------|------------|
| **Browsers** | Chrome, Firefox, Edge | Chrome, Firefox, Safari, Edge |
| **Speed** | Good | Excellent |
| **DX** | Excellent | Good |
| **Learning** | Gentle | Moderate |
| **Debugging** | Time-travel debugger | Good console logs |
| **Parallelization** | Limited (paid) | Native |
| **Best For** | Developer experience | Production testing |

## TDD Red-Green-Refactor Cycle

### Step 1: RED
Write failing test for feature:
```javascript
test('calculates sum correctly', () => {
  expect(sum(2, 3)).toBe(5);
});
```

### Step 2: GREEN
Write minimal code to pass:
```javascript
function sum(a, b) {
  return a + b;
}
```

### Step 3: REFACTOR
Improve code quality:
```javascript
const sum = (a, b) => a + b;
```

## Common Testing Mistakes

1. **Testing implementation details** - Test behavior instead
2. **Over-mocking** - Mock only external dependencies
3. **100% coverage goal** - 80% is realistic target
4. **Snapshot testing abuse** - Use sparingly
5. **Ignoring edge cases** - Test error scenarios

## Integration with Other Agents

- **Fundamentals Agent:** JavaScript testing basics
- **Frameworks Agent:** Framework-specific testing
- **State Management Agent:** State testing
- **Performance Agent:** Performance testing
- **Advanced Topics Agent:** Security testing

## Real-World Scenarios

### Scenario 1: Legacy Code Testing
- Add tests to untested codebase
- Identify critical paths
- Incremental test coverage
- Refactor safely with tests

### Scenario 2: TDD Implementation
- Write tests first
- Red-green-refactor cycle
- Build confidence in code
- Document with tests

### Scenario 3: CI/CD Integration
- GitHub Actions setup
- Automated test execution
- Coverage reporting
- Deployment gates

## Next Steps

After this agent, progress to:
1. **Performance Agent** (performance testing)
2. **Advanced Topics Agent** (security testing)
3. **Build Tools Agent** (test configuration)

## Support & Resources

- **Agent docs:** See `skills/` for detailed modules
- **Examples:** See `examples/` for test samples
- **Resources:** See `resources/` for links
- **Progress:** See hooks for tracking

---

**Agent Status:** ✅ Active
**Last Updated:** 2025-01-01
**Version:** 1.0.0

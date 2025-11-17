# 🧪 Testing & QA Tutorial

**Agent 5 - Testing & Quality Assurance**
*Duration: 4-5 weeks | Level: Intermediate to Advanced*

---

## 📚 Table of Contents

- [Week 1: Testing Fundamentals](#week-1-testing-fundamentals)
- [Week 2: Unit Testing](#week-2-unit-testing)
- [Week 3: Component Testing](#week-3-component-testing)
- [Week 4: E2E Testing](#week-4-e2e-testing)
- [Week 5: Advanced Testing](#week-5-advanced-testing)
- [Projects & Assessment](#projects--assessment)

---

## Week 1: Testing Fundamentals

### 🎯 Learning Objectives
- Understand testing pyramid
- Learn test types and purposes
- Master test structure and assertions
- Understand TDD and BDD
- Learn coverage metrics

### 📖 Key Concepts

#### Testing Pyramid

```
        △
       △ △ E2E Tests
      △   △ (10%)
     △ ▽△▽ △
    △ Integration △ (20%)
   △ Unit Tests (70%) △
  △ △ △ △ △ △ △ △ △ △
```

#### Test Types and Scope

| Type | Scope | Speed | Cost | Purpose |
|------|-------|-------|------|---------|
| Unit | Function/Method | Fast | Low | Isolated logic |
| Integration | Feature/Module | Medium | Medium | Component interactions |
| Component | UI Component | Medium | Medium | Rendering, props |
| E2E | User flow | Slow | High | Full workflows |
| Visual | Screenshots | Medium | High | UI appearance |

### 📝 Test Structure (Arrange-Act-Assert)

```javascript
// Basic test structure
describe('Calculator', () => {
  it('should add two numbers correctly', () => {
    // Arrange - setup
    const calculator = new Calculator();

    // Act - execute
    const result = calculator.add(2, 3);

    // Assert - verify
    expect(result).toBe(5);
  });

  it('should handle negative numbers', () => {
    const calculator = new Calculator();
    const result = calculator.add(-2, 3);
    expect(result).toBe(1);
  });

  it('should handle decimals', () => {
    const calculator = new Calculator();
    const result = calculator.add(2.5, 3.2);
    expect(result).toBeCloseTo(5.7);
  });
});
```

### 🔍 Common Assertions

```javascript
// Equality
expect(value).toBe(5);                    // Strict equality
expect(obj).toEqual({ id: 1 });          // Deep equality

// Truthiness
expect(value).toBeTruthy();
expect(value).toBeFalsy();
expect(value).toBeNull();
expect(value).toBeUndefined();
expect(value).toBeDefined();

// Numbers
expect(value).toBeGreaterThan(3);
expect(value).toBeGreaterThanOrEqual(3.5);
expect(value).toBeLessThan(5);
expect(value).toBeCloseTo(0.3);

// Strings
expect(message).toMatch(/hello/i);
expect(url).toContain('example.com');
expect(email).toMatch(/^[^\s@]+@[^\s@]+\.[^\s@]+$/);

// Arrays & Objects
expect(array).toContain('value');
expect(array).toHaveLength(3);
expect(object).toHaveProperty('name');
expect(object).toHaveProperty('name', 'John');

// Functions & Errors
expect(fn).toThrow();
expect(fn).toThrow(Error);
expect(fn).toThrow('expected message');
```

### 🚀 Mocking and Spying

```javascript
// Jest mocks
const mockFetch = jest.fn();
mockFetch.mockResolvedValue({ json: () => ({ id: 1 }) });

// Spy on existing function
const spy = jest.spyOn(console, 'log');
console.log('test');
expect(spy).toHaveBeenCalledWith('test');
spy.mockRestore();

// Mock modules
jest.mock('./api', () => ({
  fetchUser: jest.fn().mockResolvedValue({ id: 1, name: 'John' }),
}));
```

---

## Week 2: Unit Testing

### 🎯 Learning Objectives
- Test pure functions thoroughly
- Test asynchronous code
- Mock dependencies
- Test error handling
- Achieve high coverage

### ⚛️ Unit Testing with Jest

```javascript
// utils/math.js
export function add(a, b) {
  return a + b;
}

export function multiply(a, b) {
  return a * b;
}

export function calculateTotal(items) {
  return items.reduce((sum, item) => sum + item.price, 0);
}

// utils/math.test.js
describe('Math utilities', () => {
  describe('add', () => {
    it('should add positive numbers', () => {
      expect(add(2, 3)).toBe(5);
    });

    it('should add negative numbers', () => {
      expect(add(-2, -3)).toBe(-5);
    });

    it('should add mixed numbers', () => {
      expect(add(-2, 3)).toBe(1);
    });

    it('should handle decimal numbers', () => {
      expect(add(2.5, 3.5)).toBeCloseTo(6);
    });
  });

  describe('multiply', () => {
    it('should multiply numbers correctly', () => {
      expect(multiply(2, 3)).toBe(6);
    });

    it('should return 0 when multiplying by 0', () => {
      expect(multiply(5, 0)).toBe(0);
    });
  });

  describe('calculateTotal', () => {
    it('should sum item prices', () => {
      const items = [
        { price: 10 },
        { price: 20 },
        { price: 30 },
      ];
      expect(calculateTotal(items)).toBe(60);
    });

    it('should return 0 for empty array', () => {
      expect(calculateTotal([])).toBe(0);
    });
  });
});
```

### 📡 Testing Async Code

```javascript
// api/userService.js
export async function fetchUser(id) {
  const response = await fetch(`/api/users/${id}`);
  return response.json();
}

export function fetchUserWithCallback(id, callback) {
  fetch(`/api/users/${id}`)
    .then(res => res.json())
    .then(data => callback(null, data))
    .catch(error => callback(error));
}

// api/userService.test.js
describe('User Service', () => {
  describe('fetchUser', () => {
    it('should fetch user data', async () => {
      global.fetch = jest.fn().mockResolvedValue({
        json: () => Promise.resolve({ id: 1, name: 'John' }),
      });

      const user = await fetchUser(1);
      expect(user).toEqual({ id: 1, name: 'John' });
      expect(fetch).toHaveBeenCalledWith('/api/users/1');
    });

    it('should handle fetch errors', async () => {
      global.fetch = jest.fn().mockRejectedValue(
        new Error('Network error')
      );

      await expect(fetchUser(1)).rejects.toThrow('Network error');
    });
  });

  describe('fetchUserWithCallback', () => {
    it('should call callback with data on success', (done) => {
      global.fetch = jest.fn().mockResolvedValue({
        json: () => Promise.resolve({ id: 1, name: 'John' }),
      });

      fetchUserWithCallback(1, (error, data) => {
        expect(error).toBeNull();
        expect(data).toEqual({ id: 1, name: 'John' });
        done();
      });
    });
  });
});
```

### 🧩 Testing Class Methods and Modules

```javascript
// User.js
export class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;
  }

  isValidEmail() {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(this.email);
  }

  getDisplayName() {
    return `${this.name} (${this.email})`;
  }

  static fromJSON(json) {
    return new User(json.name, json.email);
  }
}

// User.test.js
describe('User class', () => {
  let user;

  beforeEach(() => {
    user = new User('John', 'john@example.com');
  });

  describe('constructor', () => {
    it('should create user with name and email', () => {
      expect(user.name).toBe('John');
      expect(user.email).toBe('john@example.com');
    });
  });

  describe('isValidEmail', () => {
    it('should return true for valid email', () => {
      expect(user.isValidEmail()).toBe(true);
    });

    it('should return false for invalid email', () => {
      user.email = 'invalid-email';
      expect(user.isValidEmail()).toBe(false);
    });
  });

  describe('getDisplayName', () => {
    it('should return formatted display name', () => {
      expect(user.getDisplayName()).toBe('John (john@example.com)');
    });
  });

  describe('fromJSON static method', () => {
    it('should create user from JSON', () => {
      const user = User.fromJSON({
        name: 'Jane',
        email: 'jane@example.com',
      });
      expect(user.name).toBe('Jane');
      expect(user.email).toBe('jane@example.com');
    });
  });
});
```

### 💻 Mini Projects

1. **Test utility library**
   - 20+ test cases
   - All edge cases covered
   - >90% coverage

2. **Async data service tests**
   - Mock API calls
   - Error handling
   - Caching logic

---

## Week 3: Component Testing

### 🎯 Learning Objectives
- Test component rendering
- Test component interactions
- Test prop changes
- Test state updates
- Use Testing Library

### ⚛️ React Component Testing

```javascript
// Button.jsx
export function Button({ onClick, children, disabled }) {
  return (
    <button onClick={onClick} disabled={disabled}>
      {children}
    </button>
  );
}

// Button.test.jsx
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { Button } from './Button';

describe('Button component', () => {
  it('should render button with text', () => {
    render(<Button>Click me</Button>);
    const button = screen.getByRole('button', { name: 'Click me' });
    expect(button).toBeInTheDocument();
  });

  it('should call onClick when clicked', async () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Click me</Button>);

    const button = screen.getByRole('button', { name: 'Click me' });
    await userEvent.click(button);

    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('should be disabled when disabled prop is true', () => {
    render(<Button disabled>Click me</Button>);
    const button = screen.getByRole('button', { name: 'Click me' });
    expect(button).toBeDisabled();
  });

  it('should not call onClick when disabled', async () => {
    const handleClick = jest.fn();
    render(<Button disabled onClick={handleClick}>
      Click me
    </Button>);

    const button = screen.getByRole('button', { name: 'Click me' });
    await userEvent.click(button);

    expect(handleClick).not.toHaveBeenCalled();
  });
});

// Counter.jsx
import { useState } from 'react';

export function Counter({ initialValue = 0 }) {
  const [count, setCount] = useState(initialValue);

  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
      <button onClick={() => setCount(count - 1)}>Decrement</button>
    </div>
  );
}

// Counter.test.jsx
describe('Counter component', () => {
  it('should render with initial count', () => {
    render(<Counter initialValue={5} />);
    expect(screen.getByText('Count: 5')).toBeInTheDocument();
  });

  it('should increment count', async () => {
    render(<Counter />);
    const incrementBtn = screen.getByRole('button', { name: 'Increment' });

    await userEvent.click(incrementBtn);
    expect(screen.getByText('Count: 1')).toBeInTheDocument();

    await userEvent.click(incrementBtn);
    expect(screen.getByText('Count: 2')).toBeInTheDocument();
  });

  it('should decrement count', async () => {
    render(<Counter initialValue={5} />);
    const decrementBtn = screen.getByRole('button', { name: 'Decrement' });

    await userEvent.click(decrementBtn);
    expect(screen.getByText('Count: 4')).toBeInTheDocument();
  });
});
```

### 🎨 Vue Component Testing

```javascript
// Counter.vue
<template>
  <div>
    <p>Count: {{ count }}</p>
    <button @click="increment">Increment</button>
    <button @click="decrement">Decrement</button>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const props = defineProps({
  initialValue: { type: Number, default: 0 },
});

const count = ref(props.initialValue);

const increment = () => count.value++;
const decrement = () => count.value--;
</script>

// Counter.spec.js
import { mount } from '@vue/test-utils';
import { Counter } from './Counter.vue';

describe('Counter component', () => {
  it('should render with initial count', () => {
    const wrapper = mount(Counter, {
      props: { initialValue: 5 },
    });
    expect(wrapper.text()).toContain('Count: 5');
  });

  it('should increment count', async () => {
    const wrapper = mount(Counter);
    const button = wrapper.find('button');

    await button.trigger('click');
    expect(wrapper.text()).toContain('Count: 1');
  });
});
```

### 💻 Mini Projects

1. **Component library tests**
   - 10+ components
   - All interactions covered
   - >85% coverage

2. **Form testing**
   - Input validation
   - Error messages
   - Submission handling

---

## Week 4: E2E Testing

### 🎯 Learning Objectives
- Set up E2E test framework
- Write user flow tests
- Handle async operations
- Test real scenarios
- CI/CD integration

### 🎭 Cypress E2E Testing

```javascript
// cypress/e2e/todo.cy.js
describe('Todo App', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000');
  });

  it('should add a new todo', () => {
    cy.get('input[placeholder="Add a todo"]').type('Learn Cypress');
    cy.get('button').contains('Add').click();

    cy.contains('Learn Cypress').should('be.visible');
  });

  it('should mark todo as complete', () => {
    cy.get('input[placeholder="Add a todo"]').type('Learn Testing');
    cy.get('button').contains('Add').click();

    cy.get('input[type="checkbox"]').click();
    cy.get('li').should('have.class', 'completed');
  });

  it('should delete a todo', () => {
    cy.get('input[placeholder="Add a todo"]').type('Delete me');
    cy.get('button').contains('Add').click();

    cy.get('button').contains('Delete').click();
    cy.contains('Delete me').should('not.exist');
  });

  it('should persist todos on page reload', () => {
    cy.get('input[placeholder="Add a todo"]').type('Persist me');
    cy.get('button').contains('Add').click();

    cy.reload();
    cy.contains('Persist me').should('be.visible');
  });
});
```

### 🎭 Playwright E2E Testing

```javascript
// tests/todo.spec.js
import { test, expect } from '@playwright/test';

test.describe('Todo App', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('http://localhost:3000');
  });

  test('should add a new todo', async ({ page }) => {
    await page.fill('input[placeholder="Add a todo"]', 'Learn Playwright');
    await page.click('button:has-text("Add")');

    await expect(page.locator('text=Learn Playwright')).toBeVisible();
  });

  test('should mark todo as complete', async ({ page }) => {
    await page.fill('input[placeholder="Add a todo"]', 'Learn Testing');
    await page.click('button:has-text("Add")');

    await page.click('input[type="checkbox"]');
    const checkbox = page.locator('input[type="checkbox"]').first();
    await expect(checkbox).toBeChecked();
  });

  test('should handle network errors gracefully', async ({ page }) => {
    await page.route('/api/todos', route => route.abort());

    await page.reload();
    await expect(page.locator('text=Error loading todos')).toBeVisible();
  });
});
```

### 💻 Mini Projects

1. **Multi-page E2E tests**
   - User authentication flow
   - Complex workflows
   - Error scenarios

2. **API testing with Playwright**
   - Mock API responses
   - Test different states
   - Error handling

---

## Week 5: Advanced Testing

### 🎯 Learning Objectives
- Test complex scenarios
- Visual regression testing
- Performance testing
- Accessibility testing
- Test optimization

### 🎨 Visual Regression Testing

```javascript
// Playwright visual testing
import { test, expect } from '@playwright/test';

test('should match screenshot', async ({ page }) => {
  await page.goto('http://localhost:3000');
  await expect(page).toHaveScreenshot('homepage.png');
});

test('should match component screenshot', async ({ page }) => {
  await page.goto('http://localhost:3000/components/button');
  const button = page.locator('button').first();
  await expect(button).toHaveScreenshot('button.png');
});
```

### ♿ Accessibility Testing

```javascript
// jest-axe accessibility testing
import { render } from '@testing-library/react';
import { axe, toHaveNoViolations } from 'jest-axe';
import { Button } from './Button';

expect.extend(toHaveNoViolations);

describe('Button accessibility', () => {
  it('should not have accessibility violations', async () => {
    const { container } = render(
      <Button onClick={jest.fn()}>Click me</Button>
    );
    const results = await axe(container);
    expect(results).toHaveNoViolations();
  });
});
```

### ⚡ Performance Testing

```javascript
// Performance metrics in tests
import { render } from '@testing-library/react';
import { Button } from './Button';

describe('Button performance', () => {
  it('should render quickly', () => {
    const start = performance.now();
    render(<Button>Click me</Button>);
    const end = performance.now();

    expect(end - start).toBeLessThan(100); // < 100ms
  });
});
```

### 💻 Practice Projects

1. **Full test suite**
   - Unit, integration, E2E
   - >80% coverage
   - CI/CD setup

2. **Accessibility audit**
   - WCAG compliance
   - Screen reader testing
   - Keyboard navigation

---

## 📊 Projects & Assessment

### Capstone Project: Comprehensive Test Suite

**Requirements:**
- ✅ Unit tests (>80% coverage)
- ✅ Component tests (all components)
- ✅ Integration tests
- ✅ E2E tests (5+ user flows)
- ✅ Accessibility tests
- ✅ Performance benchmarks
- ✅ CI/CD pipeline configured

**Grading Rubric:**
| Criteria | Points | Notes |
|----------|--------|-------|
| Unit Tests | 20 | Coverage and quality |
| Component Tests | 20 | All components covered |
| Integration Tests | 15 | Feature interactions |
| E2E Tests | 20 | User workflows |
| Accessibility | 10 | WCAG compliance |
| CI/CD | 10 | Automation setup |
| Documentation | 5 | Test documentation |

### Assessment Checklist

- [ ] All unit tests passing
- [ ] Coverage >80%
- [ ] Components tested
- [ ] E2E flows working
- [ ] No accessibility violations
- [ ] Performance acceptable
- [ ] CI/CD pipeline working
- [ ] Tests documented

---

## 🎓 Next Steps

After mastering Testing, continue with:

1. **Performance Agent** - Optimize tested code
2. **Advanced Topics** - Testing PWAs, SSR
3. **DevOps** - CI/CD and deployment

---

## 📚 Resources

### Testing Frameworks
- [Jest Official](https://jestjs.io/)
- [Vitest Official](https://vitest.dev/)
- [Cypress Official](https://www.cypress.io/)
- [Playwright Official](https://playwright.dev/)

### Testing Libraries
- [Testing Library](https://testing-library.com/)
- [React Testing](https://react-testing-library.com/)
- [Vue Testing](https://vue-test-utils.vuejs.org/)

### Learning
- [Testing JavaScript](https://testingjavascript.com/)
- [Jest Course](https://egghead.io/)
- [Cypress Academy](https://docs.cypress.io/)

---

**Last Updated:** November 2024 | **Version:** 1.0.0

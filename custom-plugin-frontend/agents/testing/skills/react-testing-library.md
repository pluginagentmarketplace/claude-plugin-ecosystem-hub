# Skill: React Testing Library

**Level:** Core
**Duration:** 1.5 weeks
**Agent:** Testing
**Prerequisites:** Jest Fundamentals

## Overview
Learn React Testing Library, the user-centric testing approach. Write tests that ensure components work from the user's perspective.

## Key Topics

- Rendering components
- Querying elements
- User events
- Assertions
- Testing hooks
- Accessibility testing

## Learning Objectives

- Test React components
- Query by role, label, text
- Simulate user events
- Test state changes
- Write accessible tests

## Practical Exercises

### Component test
```javascript
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import Button from './Button';

test('button click handler', async () => {
  const handleClick = jest.fn();
  render(<Button onClick={handleClick}>Click me</Button>);
  
  const button = screen.getByRole('button', { name: /click me/i });
  await userEvent.click(button);
  
  expect(handleClick).toHaveBeenCalled();
});
```

## Resources

- [React Testing Library](https://testing-library.com/react)
- [Testing Best Practices](https://kentcdodds.com/blog/common-mistakes-with-react-testing-library)

---
**Status:** Active | **Version:** 1.0.0

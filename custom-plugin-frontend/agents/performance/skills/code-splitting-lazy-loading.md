# Skill: Code Splitting & Lazy Loading

**Level:** Core
**Duration:** 1 week
**Agent:** Performance
**Prerequisites:** Build Tools Agent

## Overview
Reduce initial bundle size with code splitting and lazy loading. Load code only when needed for better performance.

## Key Topics

- Route-based code splitting
- Component lazy loading
- Dynamic imports
- Bundle analysis
- Tree shaking

## Learning Objectives

- Implement code splitting
- Lazy load components
- Analyze bundles
- Optimize chunks
- Monitor improvements

## Practical Exercises

### Dynamic imports
```javascript
const Module = lazy(() => import('./Module'));
```

### Bundle analysis
```bash
npm install --save-dev webpack-bundle-analyzer
```

## Resources

- [Code Splitting Guide](https://webpack.js.org/guides/code-splitting/)
- [Bundle Analysis](https://www.npmjs.com/package/webpack-bundle-analyzer)

---
**Status:** Active | **Version:** 1.0.0

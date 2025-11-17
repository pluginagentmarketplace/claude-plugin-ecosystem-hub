# Skill: Code Splitting & Optimization

**Level:** Advanced
**Duration:** 1 week
**Agent:** Build Tools
**Prerequisites:** Webpack/Vite fundamentals

## Overview
Master advanced bundling techniques including code splitting, lazy loading, and optimization for production.

## Key Topics

- Route-based code splitting
- Component-based lazy loading
- Dynamic imports
- Vendor splitting
- Bundle analysis
- Performance optimization

## Learning Objectives

- Implement code splitting
- Lazy load components
- Analyze bundle sizes
- Optimize load times
- Monitor performance

## Practical Exercises

### Dynamic imports
```javascript
const Home = lazy(() => import('./pages/Home'))
const About = lazy(() => import('./pages/About'))
```

### Bundle analysis
```bash
npm install --save-dev webpack-bundle-analyzer
```

## Resources

- [Webpack Code Splitting](https://webpack.js.org/guides/code-splitting/)
- [Bundle Analyzer](https://www.npmjs.com/package/webpack-bundle-analyzer)

---
**Status:** Active | **Version:** 1.0.0

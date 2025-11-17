# Skill: Core Web Vitals & Lighthouse

**Level:** Core
**Duration:** 1 week
**Agent:** Performance
**Prerequisites:** Fundamentals Agent

## Overview
Master Core Web Vitals - LCP, INP, and CLS. Learn to measure and optimize for user experience metrics using Lighthouse.

## Key Topics

- LCP (Largest Contentful Paint)
- INP (Interaction to Next Paint)
- CLS (Cumulative Layout Shift)
- Lighthouse auditing
- Field data vs lab data
- Real User Monitoring

## Learning Objectives

- Understand Web Vitals
- Measure with Lighthouse
- Set performance budgets
- Optimize for each metric
- Monitor in production

## Practical Exercises

### Lighthouse CLI
```bash
npm install -g lighthouse
lighthouse https://example.com --view
```

### Web Vitals library
```javascript
import { getCLS, getFID, getFCP, getLCP, getTTFB } from 'web-vitals';

getCLS(console.log);
getLCP(console.log);
getFID(console.log);
```

## Targets

- **LCP:** < 2.5s
- **INP:** < 200ms
- **CLS:** < 0.1

## Resources

- [Web Vitals Guide](https://web.dev/vitals/)
- [Lighthouse Docs](https://developers.google.com/web/tools/lighthouse)

---
**Status:** Active | **Version:** 1.0.0

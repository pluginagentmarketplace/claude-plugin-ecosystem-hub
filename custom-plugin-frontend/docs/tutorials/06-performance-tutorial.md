# ⚡ Performance Optimization Tutorial

**Agent 6 - Performance & Optimization**
*Duration: 3-4 weeks | Level: Intermediate to Advanced*

---

## 📚 Table of Contents

- [Week 1: Web Vitals & Metrics](#week-1-web-vitals--metrics)
- [Week 2: Asset Optimization](#week-2-asset-optimization)
- [Week 3: Rendering Performance](#week-3-rendering-performance)
- [Week 4: Advanced Optimization](#week-4-advanced-optimization)
- [Projects & Assessment](#projects--assessment)

---

## Week 1: Web Vitals & Metrics

### 🎯 Learning Objectives
- Understand Core Web Vitals
- Learn performance metrics
- Use measurement tools
- Set performance budgets
- Monitor performance

### 📊 Core Web Vitals (2024)

```
Performance Metrics Timeline:
┌─────┬──────────┬─────────┬──────────┬─────┐
│ FCP │   LCP    │   FID   │   CLS    │ TTL │
└─────┴──────────┴─────────┴──────────┴─────┘
0ms                                      End

Key Thresholds:
- LCP (Largest Contentful Paint): < 2.5s ✅
- FID (First Input Delay): < 100ms ✅
- CLS (Cumulative Layout Shift): < 0.1 ✅
- INP (Interaction to Next Paint): < 200ms ✅
```

#### Metric Definitions

| Metric | Measures | Target | Tool |
|--------|----------|--------|------|
| FCP | First paint of content | < 1.8s | Lighthouse |
| LCP | Largest visible element | < 2.5s | Lighthouse |
| FID | Responsiveness to input | < 100ms | Chrome DevTools |
| CLS | Visual stability | < 0.1 | Lighthouse |
| TTFB | Server response time | < 600ms | WebPageTest |
| TTI | Page interactivity | < 5s | Lighthouse |
| INP | Responsiveness | < 200ms | Chrome DevTools |

### 📈 Measuring Performance

```javascript
// Web Performance APIs
// 1. Measure Page Load
const navigationStart = performance.getEntriesByType('navigation')[0];
console.log('DOM Content Loaded:', navigationStart.domContentLoadedEventEnd - navigationStart.domContentLoadedEventStart);
console.log('Load Complete:', navigationStart.loadEventEnd - navigationStart.loadEventStart);

// 2. Custom Performance Marks
performance.mark('analysis-start');
// ... some code
performance.mark('analysis-end');
performance.measure('analysis', 'analysis-start', 'analysis-end');

const measure = performance.getEntriesByName('analysis')[0];
console.log('Analysis took:', measure.duration, 'ms');

// 3. Largest Contentful Paint
const observer = new PerformanceObserver((list) => {
  for (const entry of list.getEntries()) {
    console.log('LCP:', entry.renderTime || entry.loadTime);
  }
});

observer.observe({ entryTypes: ['largest-contentful-paint'] });

// 4. Cumulative Layout Shift
let clsValue = 0;
const clsObserver = new PerformanceObserver((list) => {
  for (const entry of list.getEntries()) {
    if (!entry.hadRecentInput) {
      clsValue += entry.value;
      console.log('CLS:', clsValue);
    }
  }
});

clsObserver.observe({ entryTypes: ['layout-shift'] });

// 5. Interaction to Next Paint
const observer = new PerformanceObserver((list) => {
  for (const entry of list.getEntries()) {
    console.log('INP:', entry.duration);
  }
});

observer.observe({ entryTypes: ['event'] });
```

### 🔍 Lighthouse & DevTools

```bash
# CLI Lighthouse audit
npx lighthouse https://example.com --view

# Generate JSON report
npx lighthouse https://example.com --output-path=report.json

# Budget checks
npx lighthouse https://example.com --budget-path=budget.json

# Example budget.json
{
  "resourceBudgets": [
    {
      "resourceType": "document",
      "budget": 20
    },
    {
      "resourceType": "script",
      "budget": 200
    },
    {
      "resourceType": "image",
      "budget": 350
    }
  ],
  "timingBudgets": [
    {
      "metric": "first-contentful-paint",
      "budget": 1800
    },
    {
      "metric": "largest-contentful-paint",
      "budget": 2500
    }
  ]
}
```

### 💻 Mini Projects

1. **Performance monitoring dashboard**
   - Display Core Web Vitals
   - Historical tracking
   - Performance badges

2. **Budget setup**
   - Define budgets
   - Automatic checks
   - CI/CD integration

---

## Week 2: Asset Optimization

### 🎯 Learning Objectives
- Optimize images and media
- Minimize JavaScript/CSS
- Implement lazy loading
- Use compression techniques
- Optimize fonts

### 🖼️ Image Optimization

```javascript
// 1. Modern Image Formats
// HTML
<picture>
  <source srcset="image.webp" type="image/webp" />
  <source srcset="image.jpg" type="image/jpeg" />
  <img src="image.jpg" alt="Description" />
</picture>

// Webpack
import image from './image.jpg?webp';

// 2. Responsive Images
<img
  src="image-large.jpg"
  srcset="
    image-small.jpg 640w,
    image-medium.jpg 1024w,
    image-large.jpg 1440w
  "
  sizes="(max-width: 640px) 100vw,
         (max-width: 1024px) 50vw,
         33vw"
  alt="Description"
/>

// 3. Lazy Loading
<img
  src="image.jpg"
  loading="lazy"
  alt="Description"
/>

// JavaScript lazy loading
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const img = entry.target;
      img.src = img.dataset.src;
      observer.unobserve(img);
    }
  });
});

document.querySelectorAll('img[data-src]').forEach(img => {
  observer.observe(img);
});

// 4. Image optimization tools configuration
// vite.config.js
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import viteImagemin from 'vite-plugin-imagemin';

export default defineConfig({
  plugins: [
    react(),
    viteImagemin({
      gifsicle: { interlaced: false },
      optipng: { optimizationLevel: 3 },
      mozjpeg: { quality: 80 },
      pngquant: {
        quality: [0.8, 0.9],
        speed: 4,
      },
      webp: { quality: 75 },
    }),
  ],
});
```

### 📦 JavaScript/CSS Optimization

```javascript
// 1. Code splitting
// Dynamic imports
const Dashboard = lazy(() => import('./pages/Dashboard'));

// Route-based splitting
const routes = [
  { path: '/', component: lazy(() => import('./Home')) },
  { path: '/about', component: lazy(() => import('./About')) },
  { path: '/admin', component: lazy(() => import('./Admin')) },
];

// 2. Minification
// webpack.config.js
import TerserPlugin from 'terser-webpack-plugin';

optimization: {
  minimize: true,
  minimizer: [
    new TerserPlugin({
      terserOptions: {
        compress: {
          drop_console: true,
        },
      },
    }),
  ],
}

// 3. CSS optimization
// Extract unused CSS
import PurgeCSSPlugin from 'purgecss-webpack-plugin';
import glob from 'glob';

plugins: [
  new PurgeCSSPlugin({
    paths: glob.sync(path.join(__dirname, 'src/**/*'), {
      nodir: true,
    }),
  }),
]

// 4. Bundle analysis
// vite.config.js
import { visualizer } from 'rollup-plugin-visualizer';

plugins: [
  visualizer({
    open: true,
    gzipSize: true,
    brotliSize: true,
  }),
]
```

### 🔤 Font Optimization

```css
/* Font preloading */
<link
  rel="preload"
  href="/fonts/inter.woff2"
  as="font"
  type="font/woff2"
  crossorigin
/>

/* Font-display strategy */
@font-face {
  font-family: 'Inter';
  src: url('/fonts/inter.woff2') format('woff2');
  font-display: swap; /* Show fallback immediately */
}

/* Minimal font subsets */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap&subset=latin');

/* System font stack (fastest) */
body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}
```

### 💻 Mini Projects

1. **Image optimization pipeline**
   - Automatic WebP conversion
   - Responsive images
   - Lazy loading setup

2. **Bundle analysis tool**
   - Identify large dependencies
   - Suggest optimizations
   - Track bundle size history

---

## Week 3: Rendering Performance

### 🎯 Learning Objectives
- Optimize React/Vue rendering
- Use production builds
- Implement caching strategies
- Master DevTools profiling
- Understand rendering bottlenecks

### ⚛️ React Performance

```javascript
// 1. Memo - Prevent unnecessary re-renders
import { memo } from 'react';

const ExpensiveComponent = memo(function({ data }) {
  return <div>{data.name}</div>;
});

// 2. useMemo - Memoize expensive computations
import { useMemo } from 'react';

function FilteredList({ items, filterValue }) {
  const filtered = useMemo(
    () => items.filter(item =>
      item.name.includes(filterValue)
    ),
    [items, filterValue]
  );

  return <ul>{filtered.map(item => <li key={item.id}>{item.name}</li>)}</ul>;
}

// 3. useCallback - Memoize functions
import { useCallback } from 'react';

function List({ items, onItemClick }) {
  const handleClick = useCallback((id) => {
    onItemClick(id);
  }, [onItemClick]);

  return items.map(item => (
    <li key={item.id} onClick={() => handleClick(item.id)}>
      {item.name}
    </li>
  ));
}

// 4. Concurrent rendering (React 18+)
import { startTransition } from 'react';

function SearchUsers({ query }) {
  const [results, setResults] = useState([]);

  const handleSearch = (e) => {
    const value = e.target.value;

    startTransition(() => {
      // This update can be interrupted
      const filtered = users.filter(u => u.name.includes(value));
      setResults(filtered);
    });
  };

  return <input onChange={handleSearch} />;
}

// 5. Code splitting with Suspense
import { Suspense, lazy } from 'react';

const Dashboard = lazy(() => import('./Dashboard'));

function App() {
  return (
    <Suspense fallback={<Loading />}>
      <Dashboard />
    </Suspense>
  );
}
```

### 🖖 Vue Performance

```javascript
// 1. Computed properties (cached)
<script setup>
import { computed } from 'vue';

const items = ref([...]);
const filtered = computed(() => {
  return items.value.filter(item => item.active);
});
</script>

// 2. defineAsyncComponent - Code splitting
import { defineAsyncComponent } from 'vue';

const HeavyComponent = defineAsyncComponent(() =>
  import('./HeavyComponent.vue')
);

// 3. Keep-alive - Cache component state
<template>
  <KeepAlive>
    <component :is="currentComponent" />
  </KeepAlive>
</template>

// 4. Suspense for async components
<template>
  <Suspense>
    <template #default>
      <AsyncComponent />
    </template>
    <template #fallback>
      <div>Loading...</div>
    </template>
  </Suspense>
</template>

// 5. v-once - Render once, never update
<template>
  <div v-once>
    {{ expensiveStaticContent }}
  </div>
</template>
```

### 🔍 DevTools Profiling

```javascript
// Performance Profiler usage
// 1. React DevTools Profiler
// Open React DevTools → Profiler tab
// Record interactions
// Analyze render times

// 2. Chrome DevTools Performance tab
// Record performance session
// Analyze frames, long tasks
// Identify bottlenecks

// Manual profiling
function ProfiledComponent() {
  const start = performance.now();

  // Component logic

  const end = performance.now();
  console.log(`Render took ${end - start}ms`);
}

// 3. Web Vitals monitoring
import { onCLS, onFID, onFCP, onINP, onLCP, onTTFB } from 'web-vitals';

onCLS(console.log);
onFID(console.log);
onFCP(console.log);
onINP(console.log);
onLCP(console.log);
onTTFB(console.log);
```

### 💻 Mini Projects

1. **Performance comparison**
   - Unoptimized vs optimized
   - Profiling screenshots
   - Optimization results

2. **DevTools mastery**
   - Profile complex app
   - Identify bottlenecks
   - Implement fixes

---

## Week 4: Advanced Optimization

### 🎯 Learning Objectives
- Implement caching strategies
- Optimize Time to First Byte
- Master CDN usage
- Implement service workers
- Handle resource hints

### 🔄 Caching Strategies

```javascript
// 1. HTTP Caching headers
// Server response
res.set('Cache-Control', 'public, max-age=3600'); // 1 hour
res.set('Cache-Control', 'public, max-age=31536000'); // 1 year (for immutable assets)
res.set('ETag', '"hash-value"');

// 2. Browser cache with Service Worker
const CACHE_NAME = 'v1';
const urlsToCache = [
  '/',
  '/styles/main.css',
  '/script/main.js',
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(urlsToCache);
    })
  );
});

self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      // Cache first strategy
      if (response) return response;

      return fetch(event.request).then((response) => {
        const cache = caches.open(CACHE_NAME);
        cache.then(c => c.put(event.request, response.clone()));
        return response;
      });
    })
  );
});

// 3. Network first (for API calls)
self.addEventListener('fetch', (event) => {
  event.respondWith(
    fetch(event.request)
      .then((response) => {
        return caches.open(CACHE_NAME).then((cache) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
      .catch(() => caches.match(event.request))
  );
});

// 4. Stale while revalidate
self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request).then((cachedResponse) => {
      const fetchPromise = fetch(event.request).then((response) => {
        caches.open(CACHE_NAME).then((cache) => {
          cache.put(event.request, response.clone());
        });
        return response;
      });

      return cachedResponse || fetchPromise;
    })
  );
});
```

### 🔗 Resource Hints

```html
<!-- Preconnect - establish early connection -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="dns-prefetch" href="https://analytics.example.com">

<!-- Preload - load critical resources -->
<link rel="preload" href="/fonts/inter.woff2" as="font" type="font/woff2" crossorigin>
<link rel="preload" href="/css/critical.css" as="style">

<!-- Prefetch - load for next navigation -->
<link rel="prefetch" href="/pages/about.js">

<!-- Prerender - entire page prefetch -->
<link rel="prerender" href="/pages/next-page.html">
```

### 📡 TTFB Optimization

```javascript
// Time to First Byte optimization

// 1. Server-side rendering
// Respond faster with pre-rendered HTML
export async function handler(event) {
  const { path } = event.requestContext;
  const html = await renderPage(path);
  return { statusCode: 200, body: html };
}

// 2. Edge caching
// Cache at CDN edge locations
// CloudFront, Cloudflare, Fastly

// 3. Static site generation
// Pre-generate pages at build time
import { staticGenerationTimeout } from 'next/constants';

export const revalidate = 3600; // ISR (Incremental Static Regeneration)

// 4. Database query optimization
// Use indexes, query caching
db.collection('posts')
  .find({})
  .cache(3600) // Cache 1 hour
  .execute();
```

### 💻 Advanced Projects

1. **Progressive Web App**
   - Service worker setup
   - Offline functionality
   - Install prompt

2. **Performance monitoring system**
   - Track metrics over time
   - Alerts for regressions
   - Team dashboard

---

## 📊 Projects & Assessment

### Capstone Project: High-Performance Application

**Requirements:**
- ✅ All Core Web Vitals < threshold
- ✅ Lighthouse score > 95
- ✅ Optimized images and assets
- ✅ Code splitting implemented
- ✅ Caching strategy implemented
- ✅ Service Worker setup
- ✅ Performance monitoring

**Grading Rubric:**
| Criteria | Points | Notes |
|----------|--------|-------|
| Web Vitals | 25 | LCP, CLS, INP, TTFB |
| Lighthouse Score | 20 | >95 score |
| Asset Optimization | 20 | Images, JS, CSS |
| Caching | 15 | Strategy implemented |
| Monitoring | 15 | Metrics tracked |
| Documentation | 5 | Performance guide |

### Assessment Checklist

- [ ] LCP < 2.5s
- [ ] CLS < 0.1
- [ ] INP < 200ms
- [ ] TTFB < 600ms
- [ ] Lighthouse > 95
- [ ] No jank or slow tasks
- [ ] Images optimized
- [ ] Code split properly
- [ ] Caching working
- [ ] Service worker active

---

## 🎓 Next Steps

After mastering Performance, continue with:

1. **Advanced Topics Agent** - PWAs, SSR, TypeScript
2. **Deployment** - Hosting and CI/CD
3. **Monitoring** - Production observability

---

## 📚 Resources

### Official Tools
- [Lighthouse](https://developers.google.com/web/tools/lighthouse)
- [WebPageTest](https://www.webpagetest.org/)
- [Chrome DevTools](https://developers.google.com/web/tools/chrome-devtools)
- [Web Vitals](https://web.dev/vitals/)

### Learning
- [web.dev Performance](https://web.dev/performance/)
- [MDN Performance](https://developer.mozilla.org/en-US/docs/Web/Performance)
- [Frontend Masters](https://frontendmasters.com/)

### Monitoring
- [Sentry](https://sentry.io/)
- [DataDog](https://www.datadoghq.com/)
- [New Relic](https://newrelic.com/)

---

**Last Updated:** November 2024 | **Version:** 1.0.0

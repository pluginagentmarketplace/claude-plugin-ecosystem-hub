# Frontend Performance, Optimization & DevTools - Comprehensive Analysis

## Overview
This document provides detailed analysis of Performance, Optimization, and DevTools from the frontend development roadmap, covering essential techniques and monitoring strategies for modern web applications.

---

## 1. Performance Metrics & Monitoring

### 1.1 Core Web Vitals

Core Web Vitals are Google's standardized metrics for measuring user experience quality:

#### Largest Contentful Paint (LCP)
- **Target:** < 2.5 seconds
- **Measures:** Loading performance - time to render largest content element
- **Optimization Techniques:**
  - Optimize server response times (TTFB < 600ms)
  - Implement resource preloading for critical assets
  - Remove render-blocking JavaScript and CSS
  - Use CDN for static assets
  - Optimize and compress images
  - Implement server-side rendering (SSR) or static site generation (SSG)

#### First Input Delay (FID) / Interaction to Next Paint (INP)
- **FID Target:** < 100 milliseconds
- **INP Target:** < 200 milliseconds
- **Measures:** Interactivity and responsiveness
- **Optimization Techniques:**
  - Break up long JavaScript tasks (use requestIdleCallback)
  - Code splitting to reduce main thread work
  - Use web workers for heavy computations
  - Minimize third-party script impact
  - Optimize event handlers and debounce/throttle events
  - Implement progressive hydration for frameworks

#### Cumulative Layout Shift (CLS)
- **Target:** < 0.1
- **Measures:** Visual stability during page load
- **Optimization Techniques:**
  - Always include size attributes on images and videos
  - Reserve space for ad slots and embeds
  - Avoid inserting content above existing content
  - Use CSS transform for animations (not top/left)
  - Preload fonts and use font-display: optional or swap
  - Avoid dynamically injected content

### 1.2 Google Lighthouse

Lighthouse is an automated tool for auditing web quality across five categories:

#### Performance Metrics Measured:
- **First Contentful Paint (FCP):** Time until first content renders
- **Speed Index:** How quickly content is visually populated
- **Time to Interactive (TTI):** When page becomes fully interactive
- **Total Blocking Time (TBT):** Sum of time main thread is blocked
- **Largest Contentful Paint (LCP)**
- **Cumulative Layout Shift (CLS)**

#### Running Lighthouse:
```bash
# Chrome DevTools (Lighthouse tab)
# Or via CLI
npm install -g lighthouse
lighthouse https://example.com --view

# With specific categories
lighthouse https://example.com --only-categories=performance --view

# CI/CD Integration
lighthouse https://example.com --output=json --output-path=./report.json
```

#### Lighthouse Score Optimization:
- **90-100:** Excellent - Production ready
- **50-89:** Needs improvement
- **0-49:** Poor - Requires immediate attention

**Key Areas to Improve:**
1. Eliminate render-blocking resources
2. Properly size images
3. Defer offscreen images
4. Minify CSS/JavaScript
5. Remove unused code
6. Use efficient cache policies
7. Avoid enormous network payloads
8. Serve images in modern formats (WebP, AVIF)

### 1.3 Other Performance Monitoring Tools

#### Real User Monitoring (RUM)
- **Tools:** Google Analytics 4, New Relic, Datadog, Sentry
- Captures actual user experience metrics
- Provides geographical and device-specific insights
- Tracks performance over time

#### Synthetic Monitoring
- **Tools:** WebPageTest, SpeedCurve, Calibre
- Controlled testing environment
- Consistent baseline measurements
- Waterfall analysis and filmstrip views

#### Performance Budgets
```javascript
// Example performance budget configuration
{
  "budgets": [{
    "resourceSizes": [
      {
        "resourceType": "script",
        "budget": 250 // KB
      },
      {
        "resourceType": "image",
        "budget": 500 // KB
      },
      {
        "resourceType": "total",
        "budget": 1000 // KB
      }
    ],
    "timings": [
      {
        "metric": "interactive",
        "budget": 3000 // ms
      },
      {
        "metric": "first-contentful-paint",
        "budget": 1500 // ms
      }
    ]
  }]
}
```

---

## 2. Code Splitting

### 2.1 Concept & Benefits

Code splitting divides your application bundle into smaller chunks that can be loaded on-demand.

**Benefits:**
- Reduced initial bundle size
- Faster initial page load
- Better caching strategies
- Load code only when needed

### 2.2 Implementation Strategies

#### Route-Based Code Splitting
```javascript
// React with React Router
import { lazy, Suspense } from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';

const Home = lazy(() => import('./pages/Home'));
const About = lazy(() => import('./pages/About'));
const Dashboard = lazy(() => import('./pages/Dashboard'));

function App() {
  return (
    <BrowserRouter>
      <Suspense fallback={<div>Loading...</div>}>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/about" element={<About />} />
          <Route path="/dashboard" element={<Dashboard />} />
        </Routes>
      </Suspense>
    </BrowserRouter>
  );
}
```

#### Component-Based Code Splitting
```javascript
// React
import React, { lazy, Suspense } from 'react';

// Heavy component loaded only when needed
const HeavyChart = lazy(() => import('./components/HeavyChart'));

function Analytics() {
  const [showChart, setShowChart] = useState(false);

  return (
    <div>
      <button onClick={() => setShowChart(true)}>
        Show Analytics
      </button>

      {showChart && (
        <Suspense fallback={<div>Loading chart...</div>}>
          <HeavyChart />
        </Suspense>
      )}
    </div>
  );
}
```

#### Dynamic Imports (Vanilla JavaScript)
```javascript
// Load module on demand
async function loadModule() {
  const module = await import('./heavy-module.js');
  module.initialize();
}

// Load on user interaction
button.addEventListener('click', async () => {
  const { processData } = await import('./data-processor.js');
  processData(userData);
});
```

### 2.3 Webpack Configuration

```javascript
// webpack.config.js
module.exports = {
  optimization: {
    splitChunks: {
      chunks: 'all',
      cacheGroups: {
        // Separate vendor code
        vendor: {
          test: /[\\/]node_modules[\\/]/,
          name: 'vendors',
          priority: 10
        },
        // Common code shared across modules
        common: {
          minChunks: 2,
          priority: 5,
          reuseExistingChunk: true
        }
      }
    },
    // Create runtime chunk for better caching
    runtimeChunk: 'single'
  }
};
```

### 2.4 Vite Configuration

```javascript
// vite.config.js
export default {
  build: {
    rollupOptions: {
      output: {
        manualChunks: {
          // Vendor splitting
          'react-vendor': ['react', 'react-dom'],
          'router': ['react-router-dom'],
          'ui-library': ['@mui/material'],
        }
      }
    },
    // Chunk size warnings
    chunkSizeWarningLimit: 500
  }
};
```

### 2.5 Best Practices

1. **Split at route boundaries** - Most effective initial strategy
2. **Extract vendor bundles** - Separate rarely-changing dependencies
3. **Prefetch/preload critical chunks** - Anticipate user navigation
4. **Monitor bundle sizes** - Use webpack-bundle-analyzer
5. **Avoid over-splitting** - Too many requests can hurt performance

---

## 3. Lazy Loading

### 3.1 Image Lazy Loading

#### Native Lazy Loading
```html
<!-- Browser-native lazy loading -->
<img src="image.jpg" loading="lazy" alt="Description">
<iframe src="video.html" loading="lazy"></iframe>
```

#### Intersection Observer API
```javascript
// Custom lazy loading implementation
const imageObserver = new IntersectionObserver((entries, observer) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const img = entry.target;
      img.src = img.dataset.src;
      img.classList.add('loaded');
      observer.unobserve(img);
    }
  });
}, {
  rootMargin: '50px' // Start loading 50px before entering viewport
});

// Observe all images with data-src
document.querySelectorAll('img[data-src]').forEach(img => {
  imageObserver.observe(img);
});
```

#### Progressive Image Loading
```javascript
// Load low-quality placeholder first, then high-res
class ProgressiveImage {
  constructor(element) {
    this.element = element;
    this.placeholder = element.dataset.placeholder;
    this.fullImage = element.dataset.src;
    this.load();
  }

  load() {
    // Load placeholder
    const placeholderImg = new Image();
    placeholderImg.src = this.placeholder;
    placeholderImg.onload = () => {
      this.element.src = this.placeholder;
      this.element.classList.add('loaded');
    };

    // Load full image
    const fullImg = new Image();
    fullImg.src = this.fullImage;
    fullImg.onload = () => {
      this.element.src = this.fullImage;
      this.element.classList.add('full-loaded');
    };
  }
}
```

### 3.2 Component Lazy Loading

#### React Lazy Loading
```javascript
import { lazy, Suspense } from 'react';

// Lazy load component
const UserProfile = lazy(() => import('./UserProfile'));

// With named exports
const Dashboard = lazy(() =>
  import('./Dashboard').then(module => ({ default: module.Dashboard }))
);

// With error boundary
function App() {
  return (
    <ErrorBoundary fallback={<ErrorMessage />}>
      <Suspense fallback={<Skeleton />}>
        <UserProfile userId={123} />
      </Suspense>
    </ErrorBoundary>
  );
}
```

#### Vue Lazy Loading
```javascript
// Vue 3 async component
import { defineAsyncComponent } from 'vue';

export default {
  components: {
    AsyncComponent: defineAsyncComponent(() =>
      import('./components/AsyncComponent.vue')
    ),

    // With loading and error states
    AsyncComponentWithOptions: defineAsyncComponent({
      loader: () => import('./components/Heavy.vue'),
      loadingComponent: LoadingSpinner,
      errorComponent: ErrorDisplay,
      delay: 200, // Show loading after 200ms
      timeout: 3000 // Timeout after 3s
    })
  }
};
```

### 3.3 Font Lazy Loading

```css
/* Font Display Strategies */
@font-face {
  font-family: 'CustomFont';
  src: url('/fonts/custom.woff2') format('woff2');
  font-display: swap; /* Show fallback immediately, swap when loaded */
  /* Options: auto, block, swap, fallback, optional */
}
```

```javascript
// Font Loading API
const font = new FontFace('CustomFont', 'url(/fonts/custom.woff2)');

font.load().then(loadedFont => {
  document.fonts.add(loadedFont);
  document.body.classList.add('font-loaded');
});
```

### 3.4 Script Lazy Loading

```html
<!-- Defer script execution -->
<script defer src="analytics.js"></script>

<!-- Async script loading -->
<script async src="third-party.js"></script>

<!-- Dynamic script injection -->
<script>
  function loadScript(src) {
    return new Promise((resolve, reject) => {
      const script = document.createElement('script');
      script.src = src;
      script.onload = resolve;
      script.onerror = reject;
      document.body.appendChild(script);
    });
  }

  // Load on user interaction
  button.addEventListener('click', async () => {
    await loadScript('/heavy-library.js');
    initializeLibrary();
  });
</script>
```

### 3.5 CSS Lazy Loading

```javascript
// Load non-critical CSS asynchronously
function loadCSS(href) {
  const link = document.createElement('link');
  link.rel = 'stylesheet';
  link.href = href;
  link.media = 'print'; // Non-blocking
  link.onload = function() {
    this.media = 'all'; // Apply to screen once loaded
  };
  document.head.appendChild(link);
}

loadCSS('/styles/non-critical.css');
```

---

## 4. Image Optimization

### 4.1 Modern Image Formats

#### WebP
- **Benefits:** 25-35% smaller than JPEG, supports transparency
- **Browser Support:** 97%+ (all modern browsers)
```html
<picture>
  <source srcset="image.webp" type="image/webp">
  <source srcset="image.jpg" type="image/jpeg">
  <img src="image.jpg" alt="Fallback">
</picture>
```

#### AVIF
- **Benefits:** 50% smaller than JPEG, better quality
- **Browser Support:** 88%+ (Chrome, Firefox, Safari 16+)
```html
<picture>
  <source srcset="image.avif" type="image/avif">
  <source srcset="image.webp" type="image/webp">
  <img src="image.jpg" alt="Fallback">
</picture>
```

### 4.2 Responsive Images

```html
<!-- Responsive images with srcset -->
<img
  src="image-800w.jpg"
  srcset="
    image-400w.jpg 400w,
    image-800w.jpg 800w,
    image-1200w.jpg 1200w,
    image-1600w.jpg 1600w
  "
  sizes="
    (max-width: 400px) 100vw,
    (max-width: 800px) 50vw,
    33vw
  "
  alt="Responsive image"
>

<!-- Art direction with picture -->
<picture>
  <source media="(max-width: 600px)" srcset="image-mobile.jpg">
  <source media="(max-width: 1200px)" srcset="image-tablet.jpg">
  <img src="image-desktop.jpg" alt="Art directed image">
</picture>
```

### 4.3 Image Compression

#### Lossy Compression Tools
- **ImageOptim:** GUI tool for Mac
- **Squoosh:** Web-based Google tool
- **TinyPNG/TinyJPG:** Online service
- **Sharp:** Node.js library for automation

```javascript
// Sharp.js example for build pipeline
const sharp = require('sharp');

await sharp('input.jpg')
  .resize(800, 600, { fit: 'cover' })
  .webp({ quality: 80 })
  .toFile('output.webp');

// Generate multiple sizes
const sizes = [400, 800, 1200, 1600];
for (const size of sizes) {
  await sharp('input.jpg')
    .resize(size)
    .jpeg({ quality: 85, progressive: true })
    .toFile(`output-${size}w.jpg`);
}
```

#### Build Tool Integration
```javascript
// webpack.config.js with image-webpack-loader
module.exports = {
  module: {
    rules: [
      {
        test: /\.(png|jpe?g|gif|svg)$/i,
        use: [
          {
            loader: 'file-loader',
            options: { name: '[name].[hash].[ext]' }
          },
          {
            loader: 'image-webpack-loader',
            options: {
              mozjpeg: { progressive: true, quality: 85 },
              optipng: { enabled: true },
              pngquant: { quality: [0.65, 0.90], speed: 4 },
              webp: { quality: 85 }
            }
          }
        ]
      }
    ]
  }
};
```

### 4.4 Image CDN & Optimization Services

```html
<!-- Cloudinary -->
<img src="https://res.cloudinary.com/demo/image/upload/w_800,f_auto,q_auto/sample.jpg">

<!-- Imgix -->
<img src="https://demo.imgix.net/sample.jpg?w=800&auto=format,compress">

<!-- Cloudflare Images -->
<img src="https://imagedelivery.net/account/image-id/w=800,format=auto">
```

**Parameters:**
- `w=` or `width=`: Resize width
- `f_auto` or `auto=format`: Automatic format selection
- `q_auto` or `auto=compress`: Automatic quality optimization
- `dpr=2`: Device pixel ratio for retina displays

### 4.5 SVG Optimization

```bash
# SVGO - SVG Optimizer
npm install -g svgo
svgo input.svg -o output.svg

# With configuration
svgo --config svgo.config.js input.svg
```

```javascript
// svgo.config.js
module.exports = {
  plugins: [
    {
      name: 'preset-default',
      params: {
        overrides: {
          removeViewBox: false, // Keep viewBox for scaling
          cleanupIDs: {
            prefix: 'icon-' // Namespace IDs
          }
        }
      }
    }
  ]
};
```

### 4.6 Image Loading Strategies

```javascript
// Priority hints
<img src="hero.jpg" fetchpriority="high" alt="Hero">
<img src="footer.jpg" fetchpriority="low" alt="Footer">

// Preload critical images
<link rel="preload" as="image" href="hero.jpg">

// Decode images asynchronously
const img = new Image();
img.src = 'large-image.jpg';
img.decode().then(() => {
  document.body.appendChild(img);
});
```

---

## 5. Browser DevTools

### 5.1 Chrome DevTools - Performance Panel

#### Recording Performance
1. **Open DevTools:** F12 or Ctrl+Shift+I (Cmd+Option+I on Mac)
2. **Performance tab:** Click record ⏺
3. **Perform actions:** Navigate, interact with page
4. **Stop recording:** Click stop ⏹

#### Analyzing Results
- **Main Thread Activity:** Identify long tasks (>50ms)
- **Network Waterfall:** See resource loading timeline
- **Screenshots:** Visual progression of page load
- **Frame Rate:** Identify dropped frames (< 60fps)

#### Key Metrics to Monitor:
```
FCP (First Contentful Paint)
LCP (Largest Contentful Paint)
TTI (Time to Interactive)
TBT (Total Blocking Time)
CLS (Cumulative Layout Shift)
```

### 5.2 Network Panel

#### Analyzing Network Performance
- **Waterfall view:** Visualize request timing
- **Filter requests:** JS, CSS, Img, XHR, etc.
- **Throttling:** Simulate slow 3G, fast 3G, offline
- **Request details:** Headers, preview, timing, cookies

#### Network Timing Breakdown:
```
Queueing: Time waiting in queue
Stalled: Time waiting to send request
DNS Lookup: DNS resolution time
Initial Connection: TCP handshake
SSL: TLS negotiation
Request Sent: Time to upload request
Waiting (TTFB): Time to First Byte
Content Download: Response download time
```

#### Optimizations Identified:
- Large resources that should be compressed
- Unused CSS/JS that can be removed
- Render-blocking resources
- Requests that could be combined or eliminated
- Opportunities for caching

### 5.3 Coverage Tool

```
1. Open DevTools
2. Cmd+Shift+P (Ctrl+Shift+P) → "Show Coverage"
3. Reload page to record
4. View unused CSS/JS percentages
```

**Actions:**
- Remove unused code
- Split bundles to load only needed code
- Defer non-critical resources

### 5.4 Lighthouse Integration

```
1. DevTools → Lighthouse tab
2. Select categories: Performance, Accessibility, Best Practices, SEO
3. Select device: Mobile or Desktop
4. Click "Analyze page load"
5. Review scores and recommendations
```

### 5.5 Memory Profiling

#### Heap Snapshots
```
1. Memory tab → Heap snapshot
2. Take snapshot
3. Perform actions
4. Take another snapshot
5. Compare snapshots to find memory leaks
```

#### Allocation Timeline
- Records memory allocations over time
- Identifies which functions allocate memory
- Finds memory that's not being released

#### Common Memory Leaks:
- Detached DOM nodes
- Forgotten timers (setInterval)
- Event listeners not removed
- Closures holding references
- Global variables accumulating data

### 5.6 Performance Monitoring APIs

#### Performance Observer
```javascript
// Monitor LCP
const observer = new PerformanceObserver((list) => {
  for (const entry of list.getEntries()) {
    console.log('LCP:', entry.renderTime || entry.loadTime);
  }
});
observer.observe({ entryTypes: ['largest-contentful-paint'] });

// Monitor FID
const fidObserver = new PerformanceObserver((list) => {
  for (const entry of list.getEntries()) {
    console.log('FID:', entry.processingStart - entry.startTime);
  }
});
fidObserver.observe({ entryTypes: ['first-input'] });

// Monitor CLS
let clsScore = 0;
const clsObserver = new PerformanceObserver((list) => {
  for (const entry of list.getEntries()) {
    if (!entry.hadRecentInput) {
      clsScore += entry.value;
      console.log('CLS:', clsScore);
    }
  }
});
clsObserver.observe({ entryTypes: ['layout-shift'] });
```

#### Resource Timing API
```javascript
// Analyze resource loading
const resources = performance.getEntriesByType('resource');
resources.forEach(resource => {
  console.log({
    name: resource.name,
    duration: resource.duration,
    size: resource.transferSize,
    type: resource.initiatorType
  });
});

// Find slow resources
const slowResources = resources.filter(r => r.duration > 1000);
console.log('Slow resources:', slowResources);
```

#### Navigation Timing API
```javascript
const perfData = performance.getEntriesByType('navigation')[0];

const metrics = {
  dns: perfData.domainLookupEnd - perfData.domainLookupStart,
  tcp: perfData.connectEnd - perfData.connectStart,
  ttfb: perfData.responseStart - perfData.requestStart,
  download: perfData.responseEnd - perfData.responseStart,
  domInteractive: perfData.domInteractive - perfData.fetchStart,
  domComplete: perfData.domComplete - perfData.fetchStart,
  loadComplete: perfData.loadEventEnd - perfData.fetchStart
};

console.table(metrics);
```

### 5.7 React DevTools Profiler

```javascript
// Wrap components to profile
import { Profiler } from 'react';

function onRenderCallback(
  id, // Component identifier
  phase, // "mount" or "update"
  actualDuration, // Time spent rendering
  baseDuration, // Estimated time without memoization
  startTime,
  commitTime,
  interactions
) {
  console.log(`${id} (${phase}) took ${actualDuration}ms`);
}

function App() {
  return (
    <Profiler id="Navigation" onRender={onRenderCallback}>
      <Navigation />
    </Profiler>
  );
}
```

**Profiler Features:**
- Flame graph visualization
- Ranked chart by render time
- Component render count
- Why did component re-render

---

## 6. Advanced Optimization Techniques

### 6.1 Resource Hints

```html
<!-- DNS Prefetch - Resolve domain early -->
<link rel="dns-prefetch" href="https://api.example.com">

<!-- Preconnect - Establish connection early -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<!-- Prefetch - Load resource for next navigation -->
<link rel="prefetch" href="/next-page.html">
<link rel="prefetch" href="/api/data.json">

<!-- Preload - High priority fetch for current page -->
<link rel="preload" href="/fonts/main.woff2" as="font" type="font/woff2" crossorigin>
<link rel="preload" href="/critical.css" as="style">
<link rel="preload" href="/hero.jpg" as="image">

<!-- Modulepreload - Preload ES modules -->
<link rel="modulepreload" href="/app.js">
```

### 6.2 Critical CSS

```javascript
// Extract and inline critical CSS
const critical = require('critical');

critical.generate({
  inline: true,
  base: 'dist/',
  src: 'index.html',
  target: {
    html: 'index-critical.html',
    css: 'critical.css'
  },
  width: 1300,
  height: 900,
  dimensions: [
    { width: 375, height: 667 },   // Mobile
    { width: 1920, height: 1080 }  // Desktop
  ]
});
```

```html
<!-- Inline critical CSS -->
<style>
  /* Critical above-the-fold CSS */
  .header { /* styles */ }
  .hero { /* styles */ }
</style>

<!-- Async load non-critical CSS -->
<link rel="preload" href="/styles/main.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
<noscript><link rel="stylesheet" href="/styles/main.css"></noscript>
```

### 6.3 Service Workers & Caching

```javascript
// service-worker.js
const CACHE_NAME = 'app-v1';
const urlsToCache = [
  '/',
  '/styles/main.css',
  '/scripts/app.js',
  '/images/logo.png'
];

// Install - Cache resources
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(urlsToCache))
  );
});

// Fetch - Serve from cache, fallback to network
self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        // Cache hit - return response
        if (response) return response;

        // Clone request
        const fetchRequest = event.request.clone();

        return fetch(fetchRequest).then(response => {
          // Check valid response
          if (!response || response.status !== 200 || response.type !== 'basic') {
            return response;
          }

          // Clone response
          const responseToCache = response.clone();

          caches.open(CACHE_NAME)
            .then(cache => {
              cache.put(event.request, responseToCache);
            });

          return response;
        });
      })
  );
});

// Activate - Clean up old caches
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheName !== CACHE_NAME) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});
```

### 6.4 HTTP/2 & HTTP/3

**HTTP/2 Benefits:**
- Multiplexing: Multiple requests over single connection
- Server Push: Proactively send resources
- Header compression: Reduce overhead
- Binary protocol: More efficient parsing

```nginx
# Nginx HTTP/2 configuration
server {
  listen 443 ssl http2;

  # Server push
  http2_push /css/main.css;
  http2_push /js/app.js;

  # Other configurations
}
```

**HTTP/3 (QUIC):**
- Built on UDP instead of TCP
- Faster connection establishment
- Better handling of packet loss
- Improved mobile performance

### 6.5 Compression

```nginx
# Nginx Gzip compression
gzip on;
gzip_vary on;
gzip_min_length 1024;
gzip_types
  text/plain
  text/css
  text/xml
  text/javascript
  application/x-javascript
  application/xml+rss
  application/rss+xml
  application/atom+xml
  application/javascript
  application/json
  image/svg+xml;

# Brotli compression (better than gzip)
brotli on;
brotli_comp_level 6;
brotli_types
  text/plain
  text/css
  text/xml
  text/javascript
  application/javascript
  application/json
  image/svg+xml;
```

### 6.6 Client-Side Performance Optimization

#### Debouncing & Throttling
```javascript
// Debounce - Execute after delay since last call
function debounce(func, delay) {
  let timeoutId;
  return function(...args) {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => func.apply(this, args), delay);
  };
}

// Usage: Search input
const searchInput = document.getElementById('search');
searchInput.addEventListener('input', debounce((e) => {
  performSearch(e.target.value);
}, 300));

// Throttle - Execute at most once per interval
function throttle(func, limit) {
  let inThrottle;
  return function(...args) {
    if (!inThrottle) {
      func.apply(this, args);
      inThrottle = true;
      setTimeout(() => inThrottle = false, limit);
    }
  };
}

// Usage: Scroll event
window.addEventListener('scroll', throttle(() => {
  updateScrollPosition();
}, 100));
```

#### RequestIdleCallback
```javascript
// Schedule non-critical work
function performNonCriticalWork() {
  requestIdleCallback((deadline) => {
    while (deadline.timeRemaining() > 0 && tasks.length > 0) {
      const task = tasks.shift();
      processTask(task);
    }

    // More tasks remaining
    if (tasks.length > 0) {
      performNonCriticalWork();
    }
  }, { timeout: 2000 });
}
```

#### Web Workers
```javascript
// main.js - Offload heavy computation
const worker = new Worker('worker.js');

worker.postMessage({ data: largeDataset });

worker.onmessage = (e) => {
  console.log('Result:', e.data);
};

// worker.js
self.onmessage = (e) => {
  const result = performHeavyComputation(e.data);
  self.postMessage(result);
};
```

---

## 7. Monitoring Strategies

### 7.1 Continuous Performance Monitoring

#### Web Vitals Library
```javascript
// Install: npm install web-vitals
import { getCLS, getFID, getFCP, getLCP, getTTFB } from 'web-vitals';

function sendToAnalytics(metric) {
  const body = JSON.stringify({
    name: metric.name,
    value: metric.value,
    id: metric.id,
    delta: metric.delta
  });

  // Use sendBeacon if available
  if (navigator.sendBeacon) {
    navigator.sendBeacon('/analytics', body);
  } else {
    fetch('/analytics', { body, method: 'POST', keepalive: true });
  }
}

// Monitor all Core Web Vitals
getCLS(sendToAnalytics);
getFID(sendToAnalytics);
getFCP(sendToAnalytics);
getLCP(sendToAnalytics);
getTTFB(sendToAnalytics);
```

### 7.2 Error Tracking & Performance

```javascript
// Sentry integration
import * as Sentry from '@sentry/browser';
import { BrowserTracing } from '@sentry/tracing';

Sentry.init({
  dsn: 'YOUR_DSN',
  integrations: [new BrowserTracing()],

  // Performance monitoring
  tracesSampleRate: 0.1, // 10% of transactions

  // Custom performance tracking
  beforeSend(event) {
    // Add performance context
    const perfData = performance.getEntriesByType('navigation')[0];
    event.contexts = {
      ...event.contexts,
      performance: {
        ttfb: perfData.responseStart - perfData.requestStart,
        domInteractive: perfData.domInteractive,
        loadComplete: perfData.loadEventEnd - perfData.fetchStart
      }
    };
    return event;
  }
});
```

### 7.3 Custom Performance Marks

```javascript
// Mark important events
performance.mark('search-start');
performSearch(query);
performance.mark('search-end');

// Measure duration
performance.measure('search-duration', 'search-start', 'search-end');

// Get measurements
const measures = performance.getEntriesByType('measure');
measures.forEach(measure => {
  console.log(`${measure.name}: ${measure.duration}ms`);
});

// Clear marks
performance.clearMarks();
performance.clearMeasures();
```

### 7.4 CI/CD Performance Testing

```yaml
# GitHub Actions - Lighthouse CI
name: Performance Audit
on: [push, pull_request]

jobs:
  lighthouse:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - name: Install dependencies
        run: npm ci
      - name: Build
        run: npm run build
      - name: Run Lighthouse CI
        run: |
          npm install -g @lhci/cli
          lhci autorun
        env:
          LHCI_GITHUB_APP_TOKEN: ${{ secrets.LHCI_GITHUB_APP_TOKEN }}
```

```javascript
// lighthouserc.js
module.exports = {
  ci: {
    collect: {
      startServerCommand: 'npm run serve',
      url: ['http://localhost:3000/'],
      numberOfRuns: 3
    },
    assert: {
      assertions: {
        'categories:performance': ['error', { minScore: 0.9 }],
        'categories:accessibility': ['error', { minScore: 0.9 }],
        'first-contentful-paint': ['error', { maxNumericValue: 2000 }],
        'largest-contentful-paint': ['error', { maxNumericValue: 2500 }],
        'cumulative-layout-shift': ['error', { maxNumericValue: 0.1 }]
      }
    },
    upload: {
      target: 'temporary-public-storage'
    }
  }
};
```

### 7.5 Performance Budgets in Build Process

```javascript
// webpack.config.js
module.exports = {
  performance: {
    maxAssetSize: 250000, // 250 KB
    maxEntrypointSize: 500000, // 500 KB
    hints: 'error', // Fail build if exceeded
    assetFilter: function(assetFilename) {
      return assetFilename.endsWith('.js') || assetFilename.endsWith('.css');
    }
  }
};
```

---

## 8. Performance Checklist

### Initial Load Performance
- [ ] Minimize critical rendering path
- [ ] Inline critical CSS (< 14KB)
- [ ] Defer non-critical CSS
- [ ] Defer/async non-critical JavaScript
- [ ] Optimize images (WebP/AVIF)
- [ ] Implement lazy loading
- [ ] Enable compression (Brotli/Gzip)
- [ ] Use CDN for static assets
- [ ] Implement HTTP/2 or HTTP/3
- [ ] Set up efficient caching strategy

### JavaScript Performance
- [ ] Code splitting by route
- [ ] Tree shaking enabled
- [ ] Remove unused code
- [ ] Minimize bundle sizes
- [ ] Use web workers for heavy tasks
- [ ] Debounce/throttle event handlers
- [ ] Optimize loops and algorithms
- [ ] Avoid memory leaks

### Rendering Performance
- [ ] Minimize DOM manipulation
- [ ] Use CSS transforms for animations
- [ ] Avoid layout thrashing
- [ ] Implement virtual scrolling for long lists
- [ ] Optimize re-renders (React.memo, useMemo)
- [ ] Use requestAnimationFrame for animations
- [ ] Minimize paint areas

### Network Performance
- [ ] Minimize HTTP requests
- [ ] Use resource hints (preload, prefetch)
- [ ] Optimize API responses
- [ ] Implement request caching
- [ ] Use GraphQL for flexible queries
- [ ] Enable keep-alive connections
- [ ] Optimize third-party scripts

### Monitoring & Testing
- [ ] Set up Core Web Vitals monitoring
- [ ] Implement error tracking
- [ ] Regular Lighthouse audits
- [ ] Performance budgets enforced
- [ ] Real User Monitoring (RUM)
- [ ] Synthetic monitoring
- [ ] CI/CD performance tests

---

## 9. Tools & Resources

### Performance Testing Tools
- **Lighthouse:** Automated auditing
- **WebPageTest:** Detailed performance analysis
- **Chrome DevTools:** Real-time debugging
- **GTmetrix:** Performance scoring with recommendations
- **Pingdom:** Website speed test
- **SpeedCurve:** Continuous performance monitoring

### Build Tools
- **Webpack:** Module bundler with optimization plugins
- **Vite:** Fast build tool with optimizations
- **Rollup:** JavaScript module bundler
- **esbuild:** Extremely fast bundler
- **Parcel:** Zero-config bundler

### Image Optimization
- **Squoosh:** Web-based image compression
- **ImageOptim:** Mac image optimizer
- **Sharp:** Node.js image processing
- **Cloudinary:** Image CDN and optimization
- **Imgix:** Real-time image processing

### Monitoring Services
- **Google Analytics 4:** Web vitals reporting
- **Sentry:** Error and performance monitoring
- **New Relic:** Application performance monitoring
- **Datadog:** Full-stack monitoring
- **LogRocket:** Session replay with performance data

### Learning Resources
- **web.dev:** Google's web development best practices
- **MDN Web Docs:** Comprehensive web documentation
- **Chrome DevTools Documentation:** Official guides
- **Performance.now():** Newsletter by Calibre
- **PerfPlanet:** Performance optimization blog

---

## Conclusion

Performance optimization is an ongoing process that requires:
1. **Measurement:** Use Lighthouse, Web Vitals, and DevTools
2. **Optimization:** Implement code splitting, lazy loading, and image optimization
3. **Monitoring:** Continuous tracking with RUM and synthetic tests
4. **Iteration:** Regular audits and improvements

Key Principles:
- Start with measurement - you can't optimize what you don't measure
- Focus on user-centric metrics (Core Web Vitals)
- Optimize for the critical rendering path
- Test on real devices and network conditions
- Implement performance budgets to prevent regression
- Make performance part of your development culture

By following these techniques and strategies, you can create fast, responsive web applications that provide excellent user experiences across all devices and network conditions.

# Frontend Development Best Practices & Trends 2024-2025
## Comprehensive Guide for Professional Development

This guide compiles the latest best practices, trends, tools, and recommendations for frontend development in 2024-2025 across seven critical areas.

---

## 1. FUNDAMENTALS - Modern HTML5, CSS, and JavaScript ES2024

### Latest Tools & Versions

#### HTML5
- **Current Standard**: HTML Living Standard (continuously updated)
- **Key APIs**:
  - Fetch API (modern replacement for XMLHttpRequest)
  - Intersection Observer API (for lazy loading and visibility detection)
  - Mutation Observer API (for DOM changes)
  - ResizeObserver API (for element size monitoring)
  - Web Workers API (for background processing)

#### CSS (Latest Features 2024-2025)
- **CSS Grid**: Modern 2D layouts with advanced capabilities
- **Flexbox**: One-dimensional flexible layouts
- **Container Queries**: Size-based responsive design (@container)
- **Cascade Layers (@layer)**: Control cascade precedence
- **CSS Nesting**: Nested selector syntax
- `:has()` Pseudo-class: Parent/ancestor selection
- **New Color Models**: LCH, LAB, HWB, oklch
- **Subgrid**: Advanced grid layout management

#### JavaScript ES2024 (ES15) & ES2025 Features
- **ES2024 Features**:
  - Strings: .replaceAll(), Unicode property escapes
  - Array methods: .findLast(), .findLastIndex(), .with()
  - Promise.withResolvers()
  - Atomics.waitAsync() for async operations

- **ES2025 (Upcoming) Features**:
  - **Pipeline Operator (|>)**: Cleaner function chaining
    ```javascript
    const result = value
      |> double
      |> addOne
      |> square
    ```
  - **Decorators**: Standardized @ syntax for class annotations
    ```javascript
    @deprecated
    @logged
    class MyClass {}
    ```
  - **Records & Tuples**: Immutable data structures (Stage 3)
  - **Pattern Matching**: Enhanced control flow (Stage 1)
  - **Temporal API**: Modern date/time handling (Stage 3)

### Current Best Practices & Patterns

#### HTML5 Best Practices
1. **Semantic HTML**: Use correct semantic elements (nav, article, section, aside, header, footer)
2. **Accessibility**: Implement ARIA labels, proper heading hierarchy, alt text for images
3. **Performance**: Use native lazy loading with `loading="lazy"`
4. **Progressive Enhancement**: Ensure functionality without JavaScript
5. **Web APIs**: Leverage native APIs instead of jQuery/polyfills

#### CSS Grid & Flexbox Strategy
- **Use CSS Grid for**: Page layout, 2D layouts, complex positioning
- **Use Flexbox for**: Component alignment, simple row/column layouts, spacing
- **Combined Approach**: Grid for structure + Flexbox for component interiors
- **Mobile-First**: Design for small screens first, enhance for larger viewports
- **Responsive Design**: Use CSS Grid auto-fit/auto-fill with Container Queries

#### JavaScript ES2024+ Best Practices
1. **Strict Mode**: Always use "use strict" or modern modules
2. **Const by Default**: Use const, then let, avoid var
3. **Arrow Functions**: Use for callbacks, preserve `this` context carefully
4. **Destructuring**: Simplify object/array access
5. **Modern Array Methods**: Prefer .map(), .filter(), .reduce() over loops
6. **Async/Await**: Cleaner promise handling than .then() chains
7. **Optional Chaining & Nullish Coalescing**: Safe property access
8. **Template Literals**: String interpolation and multiline strings

### What's Trending

1. **Container Queries Over Media Queries**: Components adapting to container size, not viewport
2. **CSS-in-CSS Movement**: Reduced reliance on CSS-in-JS (except React)
3. **Web Platform Renaissance**: Native DOM APIs replacing library shims
4. **TypeScript Adoption**: 65%+ of new projects use TypeScript
5. **Standards-Based Development**: Following W3C standards rather than vendor-specific solutions

### Common Pitfalls to Avoid

1. **CSS Selector Specificity Wars**: Use cascade layers to manage specificity
2. **Nested Media Queries**: Can still add complexity; use cascade layers
3. **Overusing Flexbox**: Not suitable for page layouts; use Grid
4. **Missing Alt Text**: Critical for accessibility and SEO
5. **Improper Lazy Loading**: Load critical images normally, defer below-fold
6. **Not Using Semantic HTML**: Hurts accessibility and SEO
7. **Callback Hell**: Use async/await instead of nested .then()
8. **Ignoring Browser Support**: Check caniuse.com for feature support

### Resources & Documentation Links

- **MDN Web Docs**: https://developer.mozilla.org/en-US/
- **W3C Standards**: https://www.w3.org/
- **Can I Use**: https://caniuse.com/
- **CSS Tricks**: https://css-tricks.com/
- **JavaScript Info**: https://javascript.info/
- **HTML Standard**: https://html.spec.whatwg.org/
- **Web Platform Tests**: https://github.com/web-platform-tests/wpt

---

## 2. BUILD TOOLS - Vite, Webpack 5+, esbuild, Package Managers

### Latest Recommended Tools & Versions

#### Build Tools Comparison (2024-2025)

| Tool | Version | Speed | Use Case | Status |
|------|---------|-------|----------|--------|
| **Vite** | 5.x+ | ⭐⭐⭐⭐⭐ | SPA/SSR, rapid dev | Trending ↑ |
| **Webpack** | 5.x+ | ⭐⭐ | Complex enterprise | Stable |
| **esbuild** | 0.20+ | ⭐⭐⭐⭐⭐ | CLI/bundling | Growing |
| **Parcel** | 2.x+ | ⭐⭐⭐⭐ | Zero-config bundling | Stable |
| **Turbopack** | Beta | ⭐⭐⭐⭐⭐ | Next.gen bundler | Emerging |

#### Package Managers Comparison (2024-2025)

| Manager | Speed | Disk Usage | Monorepo | Adoption |
|---------|-------|-----------|----------|----------|
| **npm** | Baseline | High | Moderate | 95%+ |
| **Yarn** | Fast | Moderate | Excellent | 30% |
| **pnpm** | Very Fast | -70% vs npm | Best | Growing |
| **Bun** | 30x faster | Efficient | Excellent | Emerging |

### Build Tools Architecture & Selection Guide

#### Vite (Recommended for New Projects)
- **Architecture**: ES Modules in dev, Rollup for production
- **Dev Server**: Lightning-fast hot module replacement (HMR) - 10-20ms vs Webpack 500ms-1.6s
- **Advantages**:
  - Instant cold start (1.2s vs Webpack 7s)
  - Fast HMR
  - Built-in CSS/TypeScript/JSX support
  - Plugin ecosystem
- **Best For**: Vue 3, React, Svelte, modern SPAs
- **Configuration**: `vite.config.js`

#### Webpack 5+ (Enterprise Standard)
- **Still Relevant For**:
  - Complex custom configurations
  - Legacy enterprise applications
  - Monorepos with specific requirements
  - Advanced plugin needs
- **Module Federation**: Micro-frontend architecture
- **Tree Shaking**: Dead code elimination
- **Configuration**: `webpack.config.js`

#### esbuild
- **Strengths**:
  - Extremely fast (C++ implementation)
  - Minimal configuration
  - Perfect for CLI tools
  - Used internally by Vite
- **Limitations**:
  - Less extensible than Webpack
  - Smaller plugin ecosystem
- **Best For**: Library bundling, build scripts

### Current Best Practices

#### Vite Setup Best Practices
```javascript
// vite.config.js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  build: {
    target: 'es2020',
    minify: 'terser',
    sourcemap: true,
  },
  server: {
    middlewareMode: true,
  }
})
```

#### Package Manager Selection
- **Beginners & Small Projects**: npm (comes with Node.js)
- **Teams & Performance**: pnpm (70% less disk space, monorepo support)
- **Enterprise Monorepos**: Yarn or pnpm
- **Experimental/High-Performance**: Bun (30x faster installs)

#### Monorepo Best Practices
- Use **workspace** feature (npm 7+, yarn, pnpm)
- Implement **internal packages** for code sharing
- Use **turborepo** or **nx** for orchestration
- Version management: monorepo versioning or independent versioning

### What's Trending

1. **Vite Adoption Surge**: 2024 showed Vite briefly surpass all other bundlers in downloads
2. **esbuild Integration**: Becoming standard in build chains
3. **Zero-Config Movement**: Parcel, Next.js, Nuxt emphasize convention over configuration
4. **Package Manager Consolidation**: Teams standardizing on one manager per org
5. **Monorepo Maturity**: Workspace features now standard
6. **Turbopack Emergence**: Rust-based bundler from Next.js team

### Common Pitfalls to Avoid

1. **Over-Engineering Build Config**: Start simple with Vite, add complexity only when needed
2. **Outdated Webpack Patterns**: Don't carry old patterns into new builds
3. **Missing .gitignore Entries**: node_modules, dist, .env should always be ignored
4. **Version Mismatch**: Keep package versions aligned across team
5. **Inefficient Dependency Installation**: Using outdated package managers
6. **No Lock Files**: Always commit package-lock.json or equivalent
7. **Ignoring Security Audits**: Run `npm audit` regularly

### Resources & Documentation Links

- **Vite Docs**: https://vitejs.dev/
- **Webpack Docs**: https://webpack.js.org/
- **esbuild Docs**: https://esbuild.github.io/
- **pnpm Docs**: https://pnpm.io/
- **Bun Package Manager**: https://bun.sh/
- **Turborepo**: https://turbo.build/repo/docs
- **NX Monorepo**: https://nx.dev/

---

## 3. FRAMEWORKS - React 19+, Vue 3.4+, Angular 17+, Svelte 4+

### Latest Framework Versions & Market Position

#### Market Adoption (2024-2025)

**React Dominance**
- **Market Share**: 39.5-40% of developers
- **Live Websites**: ~2.8-3 million using React
- **Job Postings**: 250,000+ globally
- **Enterprise**: 68% of large organizations use React

**Vue Growing Adoption**
- **Market Share**: 15.4% and growing
- **Adoption Growth**: +25% in past 2 years
- **Regional Strength**: Asia and Europe
- **Enterprise Growth**: 45% year-over-year increase

**Angular Enterprise Focus**
- **Job Postings**: ~120,000 positions
- **Primary Market**: Enterprise applications
- **Growth**: Stable with enterprise adoption

**Svelte Emerging**
- **Adoption**: Gaining momentum with developers seeking lighter frameworks
- **Niche**: Strong in performance-critical applications

#### React 19 Latest Features

**Server Components (Stable)**
- Render components on server only
- Reduce JavaScript bundle size
- Improve initial load times
- Direct database access without API layer

**React Compiler**
- Automatic component optimizations
- Minimizes unnecessary re-renders
- No manual useMemo/useCallback needed
- Reduces boilerplate

**Suspense Improvements**
- Better data loading patterns
- Streaming HTML
- Selective hydration

**New Hooks**
- `useWasm()`: WebAssembly integration
- `use()`: Unwrap promises/context
- `useFormStatus()`: Form submission status
- `useFormState()`: Form state management

#### Vue 3.4+ Latest Features

**Vue 4 Preparation**
- Improved TypeScript support
- Better Vue Router/Pinia integration
- Reactivity improvements

**Composition API Maturity**
- Script setup syntax (`<script setup>`)
- Ref syntactic sugar (`ref: value`)
- Better type inference

**Performance Enhancements**
- Faster change detection
- Smaller bundle size
- Improved SSR performance

**Ecosystem Integration**
- Official Vue Router 4
- Official Pinia state management
- Nuxt 4 for SSR/SSG

#### Angular 17+ Latest Features

**Standalone Components (Default)**
- No NgModule required
- Simpler component structure
- Easier tree-shaking

**Control Flow Syntax**
- `@if`, `@for`, `@switch` instead of `*ngIf`, `*ngFor`
- More readable templates
- Better performance

**Signals & Change Detection**
- Fine-grained reactivity
- More efficient updates
- Optional zone-less applications

**Latest Version**: Angular 19 (as of 2024)
- Automatic standalone migration
- Better developer experience

#### Svelte 4/5 Latest Features

**Svelte 5: Runes System**
- Signal-based reactivity
- `$state`, `$derived` for reactive values
- Fine-tuned reactivity control

**Snippets**
- Better component composition
- Template fragments
- Improved code organization

**SvelteKit SSR**
- Built-in server-side rendering
- Adapters for various platforms
- Serverless function support

**Bundle Size Advantage**
- Compiles to minimal JavaScript
- No runtime overhead
- Fastest framework in benchmarks

### Current Best Practices & Patterns

#### React 19 Best Practices

```javascript
// Use Server Components by default
// app/page.js (Server Component)
export default async function Page() {
  const data = await fetch('...')
  return <YourComponent data={data} />
}

// Client Components only for interactivity
// app/button.js
'use client'
export default function Button() {
  const [count, setCount] = useState(0)
  return <button onClick={() => setCount(c => c + 1)}>{count}</button>
}
```

**Best Practices**:
1. Prefer Server Components for static content
2. Mark interactive elements with `'use client'`
3. Use React Compiler features (no manual memoization)
4. Leverage Suspense for data loading
5. Use `<ErrorBoundary>` for error handling
6. Implement proper TypeScript types

#### Vue 3.4+ Best Practices

```vue
<!-- Composition API with Script Setup (Recommended) -->
<template>
  <button @click="increment">Count: {{ count }}</button>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const count = ref<number>(0)
const increment = () => count.value++
</script>
```

**Best Practices**:
1. Use `<script setup>` for cleaner syntax
2. Embrace Composition API over Options API
3. Use TypeScript for better DX
4. Leverage Vue Router 4 for routing
5. Use Pinia for state management
6. Implement proper component organization

#### Angular 17+ Best Practices

```typescript
// Standalone Component (No NgModule)
import { Component, signal } from '@angular/core'

@Component({
  selector: 'app-counter',
  standalone: true,
  template: `
    <button (click)="increment()">Count: {{ count() }}</button>
  `
})
export class CounterComponent {
  count = signal(0)
  increment() {
    this.count.update(c => c + 1)
  }
}
```

**Best Practices**:
1. Use standalone components exclusively
2. Leverage control flow syntax (@if, @for)
3. Use Signals for reactivity
4. Implement proper RxJS patterns
5. Leverage Angular CLI for generation
6. Strong TypeScript integration

#### Svelte 5 Best Practices

```svelte
<script>
  let count = $state(0)
  let doubled = $derived(count * 2)
</script>

<button onclick={() => count++}>
  Count: {count}, Doubled: {doubled}
</button>
```

**Best Practices**:
1. Use Runes ($state, $derived) for reactivity
2. Leverage SvelteKit for full-stack apps
3. Embrace compiler's capabilities
4. Use Snippets for component composition
5. Minimize JavaScript with Svelte's compilation

### Framework Comparison Matrix

| Aspect | React | Vue | Angular | Svelte |
|--------|-------|-----|---------|--------|
| **Learning Curve** | Moderate | Easy | Steep | Easy |
| **Bundle Size** | Large | Small | Large | Very Small |
| **Performance** | Excellent | Very Good | Good | Excellent |
| **TypeScript** | Good | Excellent | Built-in | Good |
| **Enterprise Ready** | Yes | Growing | Yes | Emerging |
| **Job Market** | Excellent | Good | Good | Limited |
| **Ecosystem** | Massive | Good | Complete | Growing |

### What's Trending

1. **Server Components & SSR**: Moving logic to server (React, Vue, Angular, Svelte)
2. **TypeScript by Default**: All frameworks emphasizing types
3. **Signals & Fine-Grained Reactivity**: Vue, Angular, Svelte adopting signal patterns
4. **Standalone/Script Setup**: Default patterns moving away from module-based setup
5. **Edge Computing**: Deploying parts of framework on edge servers
6. **AI Integration**: Frameworks optimizing for AI tool integration

### Common Pitfalls to Avoid

1. **Over-Fetching**: Fetch only needed data
2. **Unnecessary Re-renders**: Understand component lifecycle
3. **Global State Abuse**: Keep state as local as possible
4. **Not Using Keys in Lists**: Improper keys cause rendering bugs
5. **Missing Error Boundaries**: No fallback UI for errors
6. **Prop Drilling**: Deep nested props instead of context/state management
7. **Memory Leaks**: Not cleaning up subscriptions/timers
8. **Framework Mismatch**: Choosing wrong framework for use case

### Resources & Documentation Links

- **React Docs**: https://react.dev/
- **React RFC**: https://github.com/reactjs/rfcs
- **Vue Docs**: https://vuejs.org/
- **Vue 3 Best Practices**: https://vuejs.org/guide/best-practices/
- **Angular Docs**: https://angular.dev/
- **Svelte Docs**: https://svelte.dev/
- **SvelteKit Docs**: https://kit.svelte.dev/
- **Next.js** (React SSR): https://nextjs.org/
- **Nuxt** (Vue SSR): https://nuxt.com/
- **SvelteKit** (Svelte SSR): https://kit.svelte.dev/

---

## 4. STATE MANAGEMENT - Redux, Zustand, TanStack Query, Modern Patterns

### Recommended Tools & Selection Guide

#### State Management Landscape (2024-2025)

| Solution | Use Case | Bundle Size | Complexity | Adoption |
|----------|----------|-------------|-----------|----------|
| **TanStack Query** | Server state | Small | Low | Trending ↑ |
| **Zustand** | Client state | Tiny | Very Low | Trending ↑ |
| **Redux Toolkit** | Complex apps | Medium | Medium | Stable |
| **Jotai** | Atoms-based | Small | Low | Growing |
| **Recoil** | Facebook's atoms | Medium | Medium | Stable |
| **Pinia** (Vue) | Vue apps | Small | Low | Growing |

### The Separation of Concerns Pattern (2024 Best Practice)

**Critical Insight**: Use different tools for different types of state

```
┌─────────────────────────────────────┐
│ Application Architecture 2024       │
├─────────────────────────────────────┤
│ Server State (TanStack Query)        │
│ - API data, caching, sync           │
│                                      │
│ Client State (Zustand/Jotai)        │
│ - UI state, theme, locale           │
│                                      │
│ Local Component State (useState)    │
│ - Form inputs, toggles              │
└─────────────────────────────────────┘
```

#### TanStack Query (formerly React Query)

**Purpose**: Manage server state (API data)

```javascript
import { useQuery } from '@tanstack/react-query'

function UserProfile({ userId }) {
  const { data, isLoading, error } = useQuery({
    queryKey: ['user', userId],
    queryFn: () => fetch(`/api/user/${userId}`).then(r => r.json()),
    staleTime: 1000 * 60 * 5, // 5 minutes
  })

  if (isLoading) return <div>Loading...</div>
  if (error) return <div>Error: {error.message}</div>
  return <div>{data.name}</div>
}
```

**Key Features**:
- Automatic caching and synchronization
- Background refetching
- Request deduplication
- Pagination & infinite scroll support
- Mutation management

#### Zustand

**Purpose**: Manage client state (simple, lightweight)

```javascript
import { create } from 'zustand'

const useThemeStore = create((set) => ({
  theme: 'light',
  setTheme: (theme) => set({ theme }),
}))

// In component
function ThemeToggle() {
  const { theme, setTheme } = useThemeStore()
  return (
    <button onClick={() => setTheme(theme === 'light' ? 'dark' : 'light')}>
      Current: {theme}
    </button>
  )
}
```

**Key Features**:
- Minimal boilerplate
- No providers needed (optional)
- DevTools integration
- TypeScript support
- Middleware support

#### Redux Toolkit (Modern Redux)

**Purpose**: Complex state management for large applications

```javascript
import { createSlice, configureStore } from '@reduxjs/toolkit'

const counterSlice = createSlice({
  name: 'counter',
  initialState: { value: 0 },
  reducers: {
    increment: (state) => { state.value++ },
    decrement: (state) => { state.value-- },
  }
})

const store = configureStore({
  reducer: {
    counter: counterSlice.reducer
  }
})
```

**Best For**:
- Large complex applications
- Multiple teams
- Middleware/side effects
- DevTools debugging

### Current Best Practices

#### 2024 Recommended Pattern: Zustand + TanStack Query

```javascript
// Perfect combination for most apps
import { create } from 'zustand'
import { useQuery, useMutation } from '@tanstack/react-query'

// Client state (UI, theme, settings)
const useAppStore = create((set) => ({
  theme: 'light',
  locale: 'en',
  setTheme: (theme) => set({ theme }),
  setLocale: (locale) => set({ locale }),
}))

// Server state (data from API)
function useUsers() {
  return useQuery({
    queryKey: ['users'],
    queryFn: async () => {
      const response = await fetch('/api/users')
      return response.json()
    }
  })
}

// Mutations (creating/updating data)
function useCreateUser() {
  return useMutation({
    mutationFn: async (newUser) => {
      const response = await fetch('/api/users', {
        method: 'POST',
        body: JSON.stringify(newUser)
      })
      return response.json()
    },
    onSuccess: () => {
      queryClient.invalidateQueries(['users'])
    }
  })
}
```

#### Multi-Store Pattern (for large apps)

```javascript
// Store structure
const useAuthStore = create(...)  // Authentication
const useUIStore = create(...)    // UI state
const useFiltersStore = create(...) // Filters

// Usage in components
function Dashboard() {
  const user = useAuthStore(state => state.user)
  const darkMode = useUIStore(state => state.darkMode)
  const filters = useFiltersStore(state => state.filters)

  const { data: results } = useQuery({...})
}
```

### Key Recommendations

**For Small to Medium Projects**:
- Use TanStack Query for server state
- Use Zustand for client state
- Use useState for local component state

**For Large Enterprise Apps**:
- Consider Redux Toolkit if complex state flow
- Use TanStack Query for server state
- Use Zustand for simpler client state
- Implement API caching strategies

**Performance Optimizations**:
1. Normalize server state (TanStack Query handles this)
2. Implement proper query cache strategies
3. Use selective subscriptions in Zustand
4. Debounce mutations
5. Implement request cancellation

### What's Trending

1. **Server State Separation**: Clear distinction from client state
2. **Query-Based Architecture**: GraphQL and REST query patterns
3. **Zustand Popularity**: Becoming default choice for client state
4. **TanStack Stack**: Using Query + Router + Table together
5. **Less Redux**: Moving away from Redux for smaller projects
6. **Optimistic Updates**: UI updates before server confirmation

### Common Pitfalls to Avoid

1. **Managing Server State as Client State**: Use TanStack Query
2. **Over-Normalizing State**: Keep structure simple
3. **Not Using Query Keys Properly**: Causes stale data issues
4. **Missing Mutation Invalidation**: Data doesn't update after changes
5. **Ignoring Network Errors**: Proper error handling critical
6. **Not Debouncing Search Queries**: Causes excessive API calls
7. **State Shape Not Matching Data**: Causes transformation overhead

### Resources & Documentation Links

- **TanStack Query Docs**: https://tanstack.com/query/latest
- **Zustand Docs**: https://github.com/pmndrs/zustand
- **Redux Toolkit Docs**: https://redux-toolkit.js.org/
- **Jotai Docs**: https://jotai.org/
- **Pinia Docs** (Vue): https://pinia.vuejs.org/
- **GraphQL + Apollo**: https://www.apollographql.com/

---

## 5. TESTING - Jest/Vitest, Playwright/Cypress, Testing Strategies

### Latest Testing Tools & Versions

#### Testing Framework Comparison (2024-2025)

| Tool | Category | Speed | Browser | Adoption |
|------|----------|-------|---------|----------|
| **Vitest** | Unit | ⭐⭐⭐⭐⭐ | N/A | Trending ↑ |
| **Jest** | Unit | ⭐⭐⭐ | N/A | Standard |
| **Playwright** | E2E | ⭐⭐⭐⭐⭐ | Multiple | Growing |
| **Cypress** | E2E | ⭐⭐⭐⭐ | Chrome/Edge | Stable |
| **Testing Library** | Component | ⭐⭐⭐⭐ | All | Growing |

### Vitest (Recommended Unit Testing)

**Advantages Over Jest**:
- **3-5x faster** build and test execution
- Jest-compatible API (easy migration)
- Native ESM support
- Better TypeScript support
- Browser mode for component testing

```javascript
// vitest.config.js
import { defineConfig } from 'vitest/config'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: ['./src/test/setup.ts'],
  }
})
```

```javascript
// __tests__/sum.test.js
import { describe, it, expect } from 'vitest'
import { sum } from '../sum'

describe('sum', () => {
  it('adds two numbers', () => {
    expect(sum(1, 2)).toBe(3)
  })
})
```

### Jest (Still Relevant)

**When to Use**:
- Legacy projects
- Projects not using Vite
- Complex testing scenarios with plugins
- Snapshot testing at scale

```javascript
// jest.config.js
module.exports = {
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/src/setupTests.ts'],
  transform: {
    '^.+\\.tsx?$': 'ts-jest'
  }
}
```

### Playwright (Modern E2E Testing)

**Key Features**:
- **Multi-browser**: Chrome, Firefox, WebKit
- **Version 1.47+**: Latest stable
- **Built-in Test Runner**: Parallelism and orchestration
- **Device Emulation**: Mobile, tablet, desktop testing
- **Debugging Tools**: Tracer Viewer, timeline

```javascript
// playwright.config.js
export default {
  testDir: './tests',
  webServer: {
    command: 'npm run dev',
    port: 3000,
  },
  use: {
    baseURL: 'http://localhost:3000',
  },
  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
    { name: 'firefox', use: { ...devices['Desktop Firefox'] } },
    { name: 'webkit', use: { ...devices['Desktop Safari'] } },
  ]
}
```

```javascript
// tests/login.spec.js
import { test, expect } from '@playwright/test'

test('login workflow', async ({ page }) => {
  await page.goto('/')
  await page.fill('[name="email"]', 'user@example.com')
  await page.fill('[name="password"]', 'password')
  await page.click('text=Login')
  await expect(page).toHaveURL('/dashboard')
})
```

### Cypress (Traditional E2E Testing)

**Strengths**:
- Interactive test runner with time-travel debugging
- Automatic waiting for elements
- Good documentation and tutorials
- Excellent for beginners

```javascript
// cypress/e2e/login.cy.js
describe('Login', () => {
  it('logs in successfully', () => {
    cy.visit('/')
    cy.get('[name="email"]').type('user@example.com')
    cy.get('[name="password"]').type('password')
    cy.get('button:contains("Login")').click()
    cy.url().should('include', '/dashboard')
  })
})
```

### Testing Library (Component Testing Best Practice)

```javascript
import { render, screen } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { Counter } from './Counter'

describe('Counter', () => {
  it('increments count on button click', async () => {
    render(<Counter />)
    const button = screen.getByRole('button', { name: /increment/i })

    await userEvent.click(button)

    expect(screen.getByText('count: 1')).toBeInTheDocument()
  })
})
```

### Current Best Practices & Recommended Test Stack

#### Recommended 2024-2025 Testing Setup

```
┌──────────────────────────────────────┐
│ Testing Stack (Recommended)          │
├──────────────────────────────────────┤
│ Unit Tests: Vitest                   │
│ Component Tests: Vitest + Testing    │
│ Library E2E Tests: Playwright        │
│ Visual Regression: Percy/Chromatic   │
│ Performance: Lighthouse CI            │
└──────────────────────────────────────┘
```

#### Test Pyramid Best Practice

```
        /\
       /  \  E2E Tests (5%)
      /____\
     /      \
    /        \  Integration Tests (15%)
   /          \
  /____________\
 /              \
/                \ Unit Tests (80%)
/__________________\
```

#### Unit Testing Best Practices

1. **Test Behavior, Not Implementation**:
   ```javascript
   // Good
   expect(result).toBe(true)

   // Bad (tests implementation)
   expect(mockFn).toHaveBeenCalledWith('specific-value')
   ```

2. **Use Descriptive Test Names**:
   ```javascript
   it('should increment counter when add button clicked', () => {})
   ```

3. **Arrange-Act-Assert Pattern**:
   ```javascript
   it('calculates total price with tax', () => {
     // Arrange
     const items = [{ price: 100 }]

     // Act
     const total = calculateTotal(items)

     // Assert
     expect(total).toBe(110)
   })
   ```

4. **Mock External Dependencies**:
   ```javascript
   const mockFetch = vi.fn()
   ```

#### E2E Testing Best Practices

1. **Test User Journeys**: Test complete workflows
2. **Avoid Implementation Details**: Click buttons, fill forms
3. **Use Page Objects Pattern**:
   ```javascript
   // page.js
   export class LoginPage {
     constructor(page) { this.page = page }
     async login(email, password) {
       await this.page.fill('[name="email"]', email)
       await this.page.fill('[name="password"]', password)
       await this.page.click('button[type="submit"]')
     }
   }
   ```

4. **Parallel Execution**: Run tests concurrently
5. **Retry Failed Tests**: Account for flakiness

### What's Trending

1. **Vitest Adoption**: Becoming default for new projects
2. **Playwright Popularity**: Growing for E2E testing
3. **Component Testing Focus**: Testing behavior not implementation
4. **CI/CD Integration**: Testing in pipeline as standard
5. **Visual Regression Testing**: Catching UI changes automatically
6. **Performance Testing**: Web Vitals as test metrics

### Common Pitfalls to Avoid

1. **Testing Implementation Details**: Test behavior instead
2. **Over-Mocking**: Mock only external dependencies
3. **Flaky Tests**: Non-deterministic tests undermine trust
4. **Ignoring Accessibility**: Test a11y features
5. **Long Test Execution**: Tests should run < 5 minutes
6. **Not Testing Error Cases**: Test happy path AND errors
7. **Snapshot Overuse**: Snapshots hide regressions
8. **No E2E Tests**: Must test critical user paths

### Resources & Documentation Links

- **Vitest Docs**: https://vitest.dev/
- **Jest Docs**: https://jestjs.io/
- **Playwright Docs**: https://playwright.dev/
- **Cypress Docs**: https://docs.cypress.io/
- **Testing Library**: https://testing-library.com/
- **Playwright vs Cypress**: https://playwright.dev/docs/intro

---

## 6. PERFORMANCE - Core Web Vitals 2024, Optimization Techniques

### Core Web Vitals Metrics (2024-2025)

**Critical Update**: As of March 12, 2024, INP replaced FID

#### The Three Core Metrics

**1. Largest Contentful Paint (LCP)**
- **What**: Time largest element becomes visible
- **Target**: < 2.5 seconds
- **Status**: Stable metric
- **Importance**: Initial page perception

**2. Interaction to Next Paint (INP)**
- **What**: Response time to user interactions
- **Target**: < 200ms for 75% of page loads
- **Status**: Replaced FID (First Input Delay)
- **Importance**: Responsiveness perception
- **Optimization**: Break long tasks into smaller chunks

**3. Cumulative Layout Shift (CLS)**
- **What**: Visual stability during page load
- **Target**: < 0.1
- **Status**: Stable metric
- **Importance**: User experience consistency

### Performance Optimization Techniques

#### LCP Optimization Strategies

1. **Fetch Priority API**
   ```html
   <img src="hero.jpg" fetchpriority="high" />
   <script src="analytics.js" fetchpriority="low"></script>
   ```

2. **Critical CSS Inlining**
   ```html
   <style>
     /* Inline critical styles for LCP element */
     .hero { ... }
   </style>
   <link rel="stylesheet" href="rest.css">
   ```

3. **Image Optimization**
   ```html
   <!-- Modern format delivery -->
   <picture>
     <source srcset="hero.webp" type="image/webp">
     <img src="hero.jpg" loading="lazy">
   </picture>
   ```

4. **Server-Side Rendering (SSR)**
   - Deliver fully-formed HTML
   - Faster first paint
   - Better SEO

5. **Early Hints Header**
   ```
   Link: <styles.css>; rel=preload; as=style
   ```

#### INP Optimization Strategies

1. **Break Long Tasks**
   ```javascript
   // Bad: Long task blocks main thread
   function processLargeArray(arr) {
     for (let i = 0; i < arr.length; i++) {
       // Heavy computation
     }
   }

   // Good: Yielding to browser
   async function processLargeArray(arr) {
     for (let i = 0; i < arr.length; i++) {
       await new Promise(resolve => setTimeout(resolve, 0))
       // Heavy computation
     }
   }
   ```

2. **Use Web Workers**
   ```javascript
   // main.js
   const worker = new Worker('worker.js')
   worker.postMessage(largeDataset)
   worker.onmessage = (e) => {
     console.log('Processed:', e.data)
   }
   ```

3. **Optimize Event Handlers**
   ```javascript
   // Debounce expensive operations
   import { debounce } from 'lodash-es'

   const handleSearch = debounce((query) => {
     // Expensive search
   }, 300)
   ```

4. **Use requestIdleCallback**
   ```javascript
   requestIdleCallback(() => {
     // Non-critical work when browser is idle
     analytics.track()
   })
   ```

5. **Long Animation Frames (LoAF) API**
   ```javascript
   const observer = new PerformanceObserver((list) => {
     for (const entry of list.getEntries()) {
       console.log('Long animation frame:', entry.duration)
     }
   })
   observer.observe({ entryTypes: ['long-animation-frame'] })
   ```

#### CLS Optimization Strategies

1. **Reserve Space for Dynamic Content**
   ```css
   /* Reserve space for images before loaded */
   img {
     aspect-ratio: 16 / 9;
     width: 100%;
   }

   /* Reserve space for ads */
   .ad-space {
     width: 300px;
     height: 250px;
   }
   ```

2. **Font Loading Optimization**
   ```css
   @font-face {
     font-family: 'Custom';
     src: url('font.woff2') format('woff2');
     /* Prevent invisible text while loading */
     font-display: swap;
   }
   ```

3. **Lazy Load With Container**
   ```javascript
   const observer = new IntersectionObserver((entries) => {
     entries.forEach(entry => {
       if (entry.isIntersecting) {
         // Load content in designated container
       }
     })
   })
   ```

### Performance Measurement Tools

```javascript
// Web Vitals Measurement
import { getCLS, getFID, getFCP, getLCP, getTTFB } from 'web-vitals'

getCLS(console.log)  // Cumulative Layout Shift
getFID(console.log)  // First Input Delay (deprecated, use INP)
getFCP(console.log)  // First Contentful Paint
getLCP(console.log)  // Largest Contentful Paint
getTTFB(console.log) // Time to First Byte
```

### Performance Monitoring Strategy (2024)

```javascript
// Google Analytics Integration
import { onCLS, onFID, onFCP, onLCP, onTTFB } from 'web-vitals'

function sendToAnalytics(metric) {
  // Send to your analytics provider
  gtag.event(metric.name, {
    value: Math.round(metric.value),
    event_category: 'Web Vitals',
    event_label: metric.id,
    non_interaction: true,
  })
}

onCLS(sendToAnalytics)
onFCP(sendToAnalytics)
onLCP(sendToAnalytics)
```

### What's Trending

1. **AI for Optimization**: 72% of companies using AI tools for Core Web Vitals
2. **Early Hints Protocol**: Better resource prioritization
3. **Edge Computing**: Processing closer to users
4. **Predictive Loading**: Preloading based on user behavior
5. **Performance Budgets**: Hard limits on JS/CSS size
6. **Continuous Performance**: Monitoring as standard practice

### Common Pitfalls to Avoid

1. **Ignoring Web Vitals**: Directly impact SEO rankings
2. **Over-Optimizing**: Chase metrics, not user experience
3. **Lazy Loading Critical Content**: Only lazy load below-fold
4. **JavaScript Bloat**: Ship unnecessary code
5. **Missing Image Optimization**: Images are 50% of page weight
6. **Not Using CDN**: Missing geographic optimization
7. **Ignoring CLS**: Layout shift ruins UX

### Resources & Documentation Links

- **Google PageSpeed Insights**: https://pagespeed.web.dev/
- **Web Vitals Library**: https://github.com/GoogleChromeLabs/web-vitals
- **Core Web Vitals Guide**: https://web.dev/vitals/
- **Google Search Central**: https://developers.google.com/search
- **Performance Audit Checklist**: https://web.dev/performance/
- **LoAF API Docs**: https://github.com/jank-dev/long-animation-frames

---

## 7. ADVANCED - PWA Standards 2024, Security, SSR/SSG with Modern Frameworks

### Progressive Web Apps (PWA) 2024-2025

#### PWA Capabilities & Standards

**What Makes a PWA**:
1. **Service Worker**: Offline functionality, background sync
2. **Web App Manifest**: Installation and appearance
3. **HTTPS**: Secure connection requirement
4. **Responsive Design**: Works on all devices
5. **Fast Loading**: Performance optimized

#### Service Worker Implementation

```javascript
// sw.js
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open('v1').then((cache) => {
      return cache.addAll([
        '/',
        '/index.html',
        '/styles.css',
        '/app.js'
      ])
    })
  )
})

self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request)
    })
  )
})
```

#### Web App Manifest

```json
{
  "name": "My PWA App",
  "short_name": "MyApp",
  "icons": [
    {
      "src": "/icon-192.png",
      "sizes": "192x192",
      "type": "image/png"
    }
  ],
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#000000"
}
```

#### PWA Best Practices 2024

1. **Offline-First Architecture**: Always consider offline users
2. **Background Sync**: Queue actions when offline
3. **Push Notifications**: Re-engagement strategy
4. **App-like Experience**: Hide address bar, full screen
5. **Installation Prompts**: Allow installation on home screen

### Web Security Best Practices 2024-2025

#### XSS (Cross-Site Scripting) Prevention

**CISA 2024 Priority**: Eliminate XSS vulnerabilities

```javascript
// Bad: Vulnerable to XSS
const html = `<div>${userInput}</div>`
element.innerHTML = html

// Good: Sanitized
const div = document.createElement('div')
div.textContent = userInput // Text only
element.appendChild(div)

// Or use DOMPurify for rich content
import DOMPurify from 'dompurify'
const sanitized = DOMPurify.sanitize(userInput)
element.innerHTML = sanitized
```

#### CSRF (Cross-Site Request Forgery) Prevention

```javascript
// Generate CSRF token on server
const csrfToken = generateToken()

// Include in forms
<input type="hidden" name="csrf_token" value={csrfToken}>

// Validate on server
if (request.token !== request.session.csrfToken) {
  throw new Error('CSRF validation failed')
}
```

**Cookie Security**:
```javascript
// Set secure cookies
res.cookie('session', token, {
  httpOnly: true,      // Not accessible via JS
  secure: true,        // HTTPS only
  sameSite: 'lax',     // CSRF protection
  maxAge: 3600000      // 1 hour
})
```

#### Content Security Policy (CSP)

```html
<!-- Most restrictive recommended CSP -->
<meta http-equiv="Content-Security-Policy" content="
  default-src 'self';
  script-src 'self' 'nonce-{random}';
  style-src 'self' 'nonce-{random}';
  img-src 'self' https:;
  font-src 'self';
  connect-src 'self';
  frame-ancestors 'none';
  upgrade-insecure-requests;
">
```

#### Modern Security Practices

1. **Input Validation**: Validate all user input
2. **Output Encoding**: Escape output based on context
3. **Dependency Scanning**: Regular security audits
   ```bash
   npm audit
   npm audit fix
   ```

4. **Subresource Integrity**: Verify external resources
   ```html
   <script src="https://cdn.example.com/script.js"
     integrity="sha384-..."></script>
   ```

5. **Zero Trust Architecture**: Verify every user/device
6. **Regular Updates**: Keep all dependencies current

### Server-Side Rendering (SSR) & Static Generation (SSG)

#### SSR Benefits
- **SEO**: Search engines can crawl fully-rendered content
- **Performance**: Faster initial page load
- **Security**: Server-side validation
- **Accessibility**: Better semantic HTML

#### Next.js SSR/SSG Example (React)

```typescript
// pages/posts/[id].tsx - ISR (Incremental Static Regeneration)
export const getStaticProps = async ({ params }) => {
  const post = await fetchPost(params.id)

  return {
    props: { post },
    revalidate: 3600 // Regenerate every hour
  }
}

export const getStaticPaths = async () => {
  const posts = await fetchAllPosts()

  return {
    paths: posts.map(p => ({ params: { id: p.id } })),
    fallback: 'blocking' // Generate on-demand
  }
}

export default function Post({ post }) {
  return <article>{post.content}</article>
}
```

#### Nuxt SSR/SSG Example (Vue)

```javascript
// nuxt.config.ts
export default defineNuxtConfig({
  ssr: true,
  nitro: {
    prerender: {
      routes: ['/sitemap.xml', '/robots.txt'],
      crawlLinks: true
    }
  }
})

// pages/posts/[id].vue
<script setup>
const { data: post } = await useFetch(`/api/posts/${route.params.id}`)
</script>

<template>
  <article>{{ post.content }}</article>
</template>
```

#### SvelteKit SSR/SSG Example (Svelte)

```javascript
// svelte.config.js
import adapter from '@sveltejs/adapter-auto'

export default {
  kit: {
    adapter: adapter({
      // Prerender entire site or specific routes
      precompress: true
    })
  }
}

// src/routes/posts/[id]/+page.svelte
<script>
  export let data
</script>

<article>{data.post.content}</article>
```

### Framework-Specific Recommendations

#### Next.js (React SSR/SSG)
- **Best For**: Full-stack React applications
- **Key Features**: File-based routing, API routes, middleware
- **Version**: Next.js 14+ (App Router)
- **Hosting**: Vercel (native), any Node.js platform

#### Nuxt (Vue SSR/SSG)
- **Best For**: Full-stack Vue applications
- **Key Features**: Auto-importing, composables, Server Routes
- **Version**: Nuxt 4+
- **Hosting**: Any Node.js platform, Netlify, Vercel

#### SvelteKit (Svelte SSR/SSG)
- **Best For**: Lightweight full-stack applications
- **Key Features**: File-based routing, Server Load functions
- **Version**: Latest stable
- **Hosting**: Multiple adapters (Node.js, static, serverless)

#### Astro (Framework-agnostic)
- **Best For**: Content-heavy sites, blogs, marketing
- **Key Features**: Islands architecture, content collections
- **Adoption**: 25% adoption rate (emerging)
- **Hosting**: Static hosting, node adapters

### Security Best Practices for SSR/SSG

```javascript
// Next.js API Route Security
import { NextApiRequest, NextApiResponse } from 'next'
import { rateLimit } from '@/utils/rate-limit'

const limiter = rateLimit()

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  // Rate limiting
  const rateLimited = await limiter.check(req)
  if (rateLimited) {
    return res.status(429).json({ error: 'Too many requests' })
  }

  // CORS validation
  if (req.method !== 'POST') {
    return res.status(405).end()
  }

  // Validate input
  if (!req.body.email || !isValidEmail(req.body.email)) {
    return res.status(400).json({ error: 'Invalid email' })
  }

  // Server-side processing
  const result = await processData(req.body)

  return res.status(200).json(result)
}
```

### What's Trending

1. **Islands Architecture**: Astro's component-focused approach gaining traction
2. **Edge Computing**: Functions running closer to users (Cloudflare Workers, Deno Deploy)
3. **Hybrid Rendering**: Mix of static, SSR, and client-side rendering
4. **Database Integration**: Direct database access in Server Components
5. **Zero-JavaScript Pages**: Static pages without JavaScript bundles
6. **Security by Default**: Frameworks emphasizing security out-of-box

### Common Pitfalls to Avoid

1. **Over-Rendering**: Don't pre-render millions of pages
2. **Missing Revalidation**: Use ISR for data freshness
3. **Security Oversights**: Always validate server-side
4. **Poor Error Handling**: Graceful degradation for offline
5. **Not Using Headers/Middleware**: Missing caching strategy
6. **Bundle Size Explosion**: Monitor both server and client bundles
7. **Ignoring Database Optimization**: N+1 queries in SSR

### Resources & Documentation Links

- **Next.js Docs**: https://nextjs.org/docs
- **Nuxt Docs**: https://nuxt.com/docs
- **SvelteKit Docs**: https://kit.svelte.dev/docs
- **Astro Docs**: https://docs.astro.build/
- **PWA Documentation**: https://web.dev/progressive-web-apps/
- **OWASP Security**: https://owasp.org/
- **Web Security Academy**: https://portswigger.net/web-security

---

## Summary: 2024-2025 Frontend Technology Stack Recommendation

### Recommended Modern Stack

```
Frontend Technology Stack (2024-2025)
├─ Build Tool: Vite 5+
├─ Package Manager: pnpm or Bun
├─ Language: TypeScript
├─ Framework:
│  ├─ React 19 (+ Next.js)
│  ├─ Vue 3.4 (+ Nuxt)
│  └─ Svelte 5 (+ SvelteKit)
├─ State Management:
│  ├─ TanStack Query (server state)
│  └─ Zustand (client state)
├─ CSS: Modern CSS + Tailwind
├─ Testing:
│  ├─ Vitest (unit)
│  ├─ Testing Library (components)
│  └─ Playwright (E2E)
├─ Database: Drizzle/Prisma
├─ Security: CSP, CSRF tokens, input validation
├─ Performance: Core Web Vitals monitoring
└─ Deployment: Vercel/Netlify/Railway
```

### Decision Matrix by Project Type

#### Small Business Website
- **Framework**: Vue + Nuxt (or Astro)
- **Build**: Vite
- **Hosting**: Netlify/Vercel (static)
- **Stack Size**: Small, manageable

#### Startup MVP
- **Framework**: React + Next.js
- **State**: TanStack Query + Zustand
- **Database**: Vercel Postgres
- **Testing**: Vitest + Playwright
- **Time to Market**: Fast

#### Enterprise Application
- **Framework**: React 19 + Next.js (or Angular 17+)
- **State**: Redux Toolkit + TanStack Query
- **Build**: Webpack or Vite
- **Testing**: Comprehensive (Jest + Playwright)
- **Security**: Enterprise-grade

#### Performance-Critical App
- **Framework**: Svelte 5 + SvelteKit
- **Build**: Vite
- **CSS**: CSS-in-CSS, minimal overhead
- **Bundle Size**: Minimal
- **Target**: < 50kb initial JS

#### Real-Time Application
- **Framework**: React 19 + Next.js
- **State**: Zustand + TanStack Query
- **WebSockets**: Socket.io or native WebSocket
- **Database**: Realtime-capable (Firebase, Supabase)

### Key Metrics to Monitor (2024-2025)

1. **Lighthouse Score**: Target 90+
2. **Core Web Vitals**: All green (LCP < 2.5s, INP < 200ms, CLS < 0.1)
3. **Bundle Size**: < 100kb initial JS (gzipped)
4. **Time to Interactive**: < 3.5 seconds
5. **Test Coverage**: > 80% critical paths
6. **Performance Budget**: Enforce size limits
7. **Accessibility Score**: 95+
8. **SEO Score**: 100

---

## Quick Reference: Tool Version Matrix (November 2024)

| Category | Tool | Version | Status |
|----------|------|---------|--------|
| **Framework** | React | 19+ | Stable |
| | Vue | 3.4+ | Stable |
| | Angular | 19+ | Stable |
| | Svelte | 5+ | Stable |
| | Next.js | 14+ | Stable |
| | Nuxt | 4+ | Stable |
| **Build** | Vite | 5+ | Recommended |
| | Webpack | 5.88+ | Stable |
| | esbuild | 0.20+ | Stable |
| **Package Manager** | npm | 10+ | Standard |
| | pnpm | 8.15+ | Recommended |
| | Bun | 1.0+ | Emerging |
| **Testing** | Vitest | 1.0+ | Recommended |
| | Jest | 29+ | Stable |
| | Playwright | 1.47+ | Recommended |
| | Cypress | 13+ | Stable |
| **State** | Zustand | 4+ | Recommended |
| | TanStack Query | 5+ | Recommended |
| | Redux Toolkit | 1.9+ | Stable |
| **CSS** | Tailwind | 3.4+ | Recommended |
| | PostCSS | 8+ | Standard |
| **TypeScript** | TypeScript | 5.3+ | Recommended |
| **Node** | Node.js | 20 LTS+ | Required |

---

## Conclusion

Frontend development in 2024-2025 emphasizes:

1. **Performance First**: Core Web Vitals are non-negotiable
2. **Developer Experience**: Fast builds, instant feedback
3. **Type Safety**: TypeScript as default
4. **Security by Default**: Built-in protections
5. **Server-Client Balance**: Server Components + Client Components
6. **Component-Driven**: Reusable, tested components
7. **Accessibility**: WCAG compliance standard
8. **User-Centric**: Metrics that matter for users

Choose tools and frameworks based on **project requirements**, **team expertise**, and **maintenance costs**—not trends alone. The frontend ecosystem is mature with excellent options across all categories.

---

## Additional Resources

- **State of JavaScript 2024**: https://stateofjs.com/
- **Frontend Masters**: https://frontendmasters.com/
- **JavaScript Podcast**: https://www.syntax.fm/
- **Web Dev Newsletter**: https://web.dev/newsletter/
- **Dev Podcasts**: https://changelog.com/

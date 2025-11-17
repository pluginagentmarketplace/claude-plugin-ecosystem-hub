# 🚀 Frontend Frameworks Tutorial

**Agent 3 - Frontend Frameworks**
*Duration: 6-8 weeks | Level: Intermediate to Advanced*

---

## 📚 Table of Contents

- [Week 1: Framework Fundamentals](#week-1-framework-fundamentals)
- [Week 2: React Deep Dive](#week-2-react-deep-dive)
- [Week 3: Vue Mastery](#week-3-vue-mastery)
- [Week 4: Angular Architecture](#week-4-angular-architecture)
- [Week 5: Svelte Reactivity](#week-5-svelte-reactivity)
- [Week 6-8: Advanced Patterns](#week-6-8-advanced-patterns)
- [Projects & Assessment](#projects--assessment)

---

## Week 1: Framework Fundamentals

### 🎯 Learning Objectives
- Understand component-based architecture
- Learn virtual DOM and reactivity concepts
- Compare framework philosophies
- Master JSX/template syntax
- Understand lifecycle and side effects

### 📖 Key Concepts

#### Framework Architecture Comparison

```
┌────────────────────────────────────┐
│      Component-Based UI             │
├────────────────────────────────────┤
│   ┌──────┐  ┌──────┐  ┌──────┐    │
│   │React │  │ Vue  │  │ Svelte   │
│   └──────┘  └──────┘  └──────┘    │
│   ┌──────┐                         │
│   │Angular                         │
│   └──────┘                         │
│                                    │
│   Virtual DOM vs Reactivity        │
│   - React: VDOM diffing           │
│   - Vue: Reactivity + VDOM        │
│   - Svelte: No VDOM (compiler)    │
│   - Angular: RxJS streams         │
└────────────────────────────────────┘
```

#### Framework Comparison Matrix

| Feature | React | Vue | Angular | Svelte |
|---------|-------|-----|---------|--------|
| Learning Curve | Medium | Easy | Steep | Very Easy |
| Bundle Size | ~42KB | ~35KB | ~130KB | ~16KB |
| Performance | Fast | Very Fast | Good | Excellent |
| Ecosystem | Massive | Good | Complete | Growing |
| TypeScript | Native | Excellent | Built-in | Good |
| Adoption | Highest | Growing | Enterprise | Niche |
| Community | Largest | Large | Corporate | Small |
| Job Market | Very High | High | High | Low |

### 💻 Component Lifecycle Patterns

```javascript
// React Hooks (Functional Components)
function MyComponent() {
  const [count, setCount] = useState(0);

  // Side effect (mount, update, unmount)
  useEffect(() => {
    console.log('Component mounted or updated');
    return () => console.log('Cleanup');
  }, [count]); // dependency array

  return <div>Count: {count}</div>;
}

// Vue 3 Composition API
import { ref, onMounted, onUnmounted } from 'vue';

export default {
  setup() {
    const count = ref(0);

    onMounted(() => console.log('Mounted'));
    onUnmounted(() => console.log('Unmounted'));

    return { count };
  },
};

// Angular Services & Lifecycle
import { Component, OnInit, OnDestroy } from '@angular/core';
import { Subject } from 'rxjs';

@Component({...})
export class MyComponent implements OnInit, OnDestroy {
  ngOnInit() {
    console.log('Initialized');
  }

  ngOnDestroy() {
    console.log('Destroyed');
  }
}

// Svelte (Reactive by default)
<script>
  let count = 0;

  onMount(() => console.log('Mounted'));
  onDestroy(() => console.log('Destroyed'));
</script>
```

---

## Week 2: React Deep Dive

### 🎯 Learning Objectives
- Master React Hooks
- Understand component patterns
- Optimize rendering performance
- Work with context and state
- Build custom hooks

### ⚛️ React 19 Essentials

```javascript
// 1. Functional Components & Hooks
import { useState, useEffect, useCallback, useMemo } from 'react';

function Counter({ initialValue = 0 }) {
  const [count, setCount] = useState(initialValue);
  const [isVisible, setIsVisible] = useState(true);

  // Effect hook for side effects
  useEffect(() => {
    document.title = `Count: ${count}`;
    return () => {
      document.title = 'React App';
    };
  }, [count]);

  // Memoized callback
  const increment = useCallback(() => {
    setCount(prev => prev + 1);
  }, []);

  // Memoized value
  const doubled = useMemo(() => count * 2, [count]);

  return (
    <div>
      <p>Count: {count}</p>
      <p>Doubled: {doubled}</p>
      <button onClick={increment}>Increment</button>
    </div>
  );
}

// 2. Context for state management
import { createContext, useContext } from 'react';

const ThemeContext = createContext();

export function ThemeProvider({ children }) {
  const [theme, setTheme] = useState('light');

  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}

export function useTheme() {
  const context = useContext(ThemeContext);
  if (!context) throw new Error('useTheme must be used in ThemeProvider');
  return context;
}

// 3. Custom Hooks
function useLocalStorage(key, initialValue) {
  const [storedValue, setStoredValue] = useState(() => {
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      console.error(error);
      return initialValue;
    }
  });

  const setValue = useCallback((value) => {
    try {
      const valueToStore = value instanceof Function ? value(storedValue) : value;
      setStoredValue(valueToStore);
      window.localStorage.setItem(key, JSON.stringify(valueToStore));
    } catch (error) {
      console.error(error);
    }
  }, [storedValue]);

  return [storedValue, setValue];
}

// 4. Error Boundary (Class Component)
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true };
  }

  componentDidCatch(error, errorInfo) {
    console.error(error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return <h1>Something went wrong.</h1>;
    }

    return this.props.children;
  }
}

// 5. React 19 Features
function AdvancedComponent() {
  // Form actions (Server Actions)
  const [title, setTitle] = useState('');

  async function handleSubmit(formData) {
    const name = formData.get('name');
    // Server-side processing
  }

  // Use transition
  const [isPending, startTransition] = useTransition();

  return (
    <form action={handleSubmit}>
      <input name="name" />
      <button type="submit" disabled={isPending}>
        {isPending ? 'Saving...' : 'Save'}
      </button>
    </form>
  );
}
```

### 🎨 React Component Patterns

```javascript
// 1. Controlled Components
function LoginForm() {
  const [email, setEmail] = useState('');

  const handleChange = (e) => {
    setEmail(e.target.value);
  };

  return (
    <input
      type="email"
      value={email}
      onChange={handleChange}
    />
  );
}

// 2. Render Props Pattern
function MouseTracker({ children }) {
  const [position, setPosition] = useState({ x: 0, y: 0 });

  return (
    <div onMouseMove={(e) => setPosition({ x: e.clientX, y: e.clientY })}>
      {children(position)}
    </div>
  );
}

// 3. Higher-Order Components (HOC)
function withLogger(Component) {
  return function LoggedComponent(props) {
    useEffect(() => {
      console.log('Component mounted:', Component.name);
      return () => console.log('Component unmounted:', Component.name);
    }, []);

    return <Component {...props} />;
  };
}

const LoggedButton = withLogger(Button);

// 4. Compound Components
function Tabs({ children }) {
  const [activeTab, setActiveTab] = useState(0);

  return (
    <TabsContext.Provider value={{ activeTab, setActiveTab }}>
      {children}
    </TabsContext.Provider>
  );
}

Tabs.List = function({ children }) {
  return <div className="tabs-list">{children}</div>;
};

Tabs.Trigger = function({ index, children }) {
  const { activeTab, setActiveTab } = useContext(TabsContext);
  return (
    <button
      className={activeTab === index ? 'active' : ''}
      onClick={() => setActiveTab(index)}
    >
      {children}
    </button>
  );
};
```

### 💻 Mini Projects

1. **Todo App with React Hooks**
   - Create, read, update, delete todos
   - Local storage persistence
   - Filter and search
   - Theme switching with Context

2. **Data Dashboard**
   - Fetch data from API
   - Display in charts/tables
   - Client-side filtering
   - Loading states

---

## Week 3: Vue Mastery

### 🎯 Learning Objectives
- Master Vue 3 Composition API
- Understand reactivity system
- Build reusable composables
- Work with templates and directives
- Implement advanced features

### 🖖 Vue 3 Composition API

```javascript
// vue component with Composition API
<script setup>
import { ref, computed, watch, onMounted } from 'vue';

// Reactive state
const count = ref(0);
const message = ref('Hello Vue');

// Computed properties
const doubledCount = computed(() => count.value * 2);

// Watchers
watch(count, (newVal, oldVal) => {
  console.log(`Count changed from ${oldVal} to ${newVal}`);
});

// Lifecycle hooks
onMounted(() => {
  console.log('Component mounted');
});

// Methods
const increment = () => {
  count.value++;
};

// Expose for template
defineExpose({
  count,
  increment,
});
</script>

<template>
  <div>
    <p>{{ message }}</p>
    <p>Count: {{ count }}</p>
    <p>Doubled: {{ doubledCount }}</p>
    <button @click="increment">Increment</button>
  </div>
</template>

<style scoped>
/* Component-scoped styles */
p {
  font-size: 16px;
}
</style>
```

### 🧩 Vue Composables

```javascript
// useCounter composable
import { ref, computed } from 'vue';

export function useCounter(initialValue = 0) {
  const count = ref(initialValue);

  const doubledCount = computed(() => count.value * 2);

  const increment = () => count.value++;
  const decrement = () => count.value--;
  const reset = () => count.value = initialValue;

  return {
    count,
    doubledCount,
    increment,
    decrement,
    reset,
  };
}

// useFetch composable
import { ref, onMounted } from 'vue';

export function useFetch(url) {
  const data = ref(null);
  const loading = ref(true);
  const error = ref(null);

  onMounted(async () => {
    try {
      const response = await fetch(url);
      data.value = await response.json();
    } catch (e) {
      error.value = e;
    } finally {
      loading.value = false;
    }
  });

  return { data, loading, error };
}

// Usage in component
<script setup>
import { useCounter } from './composables/useCounter';
import { useFetch } from './composables/useFetch';

const { count, increment } = useCounter(10);
const { data: posts, loading } = useFetch('/api/posts');
</script>
```

### 📝 Vue Template Syntax

```vue
<template>
  <!-- Text interpolation -->
  <p>{{ message }}</p>

  <!-- Raw HTML -->
  <div v-html="htmlContent"></div>

  <!-- Conditional rendering -->
  <div v-if="score > 90">Excellent</div>
  <div v-else-if="score > 70">Good</div>
  <div v-else>Needs improvement</div>

  <!-- List rendering -->
  <ul>
    <li v-for="item in items" :key="item.id">
      {{ item.name }}
    </li>
  </ul>

  <!-- Event handling -->
  <button @click="handleClick">Click me</button>
  <input @input="handleInput" />

  <!-- Two-way binding -->
  <input v-model="message" />

  <!-- Dynamic attributes -->
  <a :href="url" :class="{ active: isActive }">Link</a>

  <!-- Style binding -->
  <div :style="{ color: activeColor, fontSize: fontSize + 'px' }"></div>

  <!-- Slots (composition) -->
  <div class="card">
    <slot name="header"></slot>
    <slot></slot>
    <slot name="footer"></slot>
  </div>
</template>
```

### 💻 Mini Projects

1. **Todo App with Vue Composables**
   - Create/edit/delete todos
   - Persistent storage
   - Reusable composables
   - Responsive design

2. **Blog Platform**
   - Display posts from API
   - Create new posts
   - Edit and delete
   - Filter and search

---

## Week 4: Angular Architecture

### 🎯 Learning Objectives
- Master Angular modules and DI
- Understand services and HTTP
- Build reactive forms
- Work with RxJS observables
- Implement routing and guards

### 🏗️ Angular Project Structure

```
src/
├── app/
│   ├── components/
│   │   ├── header/
│   │   ├── footer/
│   │   └── sidebar/
│   ├── services/
│   │   ├── api.service.ts
│   │   └── auth.service.ts
│   ├── guards/
│   │   └── auth.guard.ts
│   ├── interceptors/
│   │   └── auth.interceptor.ts
│   ├── app.config.ts
│   ├── app.routes.ts
│   └── app.component.ts
├── assets/
└── styles/

// app.config.ts - Standalone configuration
import { ApplicationConfig, provideZoneChangeDetection } from '@angular/core';
import { provideRouter } from '@angular/router';
import { provideHttpClient, withInterceptors } from '@angular/common/http';
import { appRoutes } from './app.routes';
import { authInterceptor } from './interceptors/auth.interceptor';

export const appConfig: ApplicationConfig = {
  providers: [
    provideZoneChangeDetection({ eventCoalescing: true }),
    provideRouter(appRoutes),
    provideHttpClient(withInterceptors([authInterceptor])),
  ],
};
```

### 🔧 Angular Services

```typescript
// api.service.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  constructor(private http: HttpClient) {}

  getPosts(): Observable<Post[]> {
    return this.http.get<Post[]>('/api/posts');
  }

  getPost(id: number): Observable<Post> {
    return this.http.get<Post>(`/api/posts/${id}`);
  }

  createPost(post: Partial<Post>): Observable<Post> {
    return this.http.post<Post>('/api/posts', post);
  }

  updatePost(id: number, post: Partial<Post>): Observable<Post> {
    return this.http.put<Post>(`/api/posts/${id}`, post);
  }

  deletePost(id: number): Observable<void> {
    return this.http.delete<void>(`/api/posts/${id}`);
  }
}

// Component using service
import { Component, OnInit } from '@angular/core';
import { ApiService } from '../services/api.service';

@Component({
  selector: 'app-posts',
  template: `
    <div>
      <div *ngFor="let post of posts$ | async">
        <h2>{{ post.title }}</h2>
        <p>{{ post.content }}</p>
      </div>
    </div>
  `,
})
export class PostsComponent implements OnInit {
  posts$: Observable<Post[]>;

  constructor(private apiService: ApiService) {}

  ngOnInit() {
    this.posts$ = this.apiService.getPosts();
  }
}
```

### 📋 Reactive Forms

```typescript
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-user-form',
  template: `
    <form [formGroup]="form" (ngSubmit)="onSubmit()">
      <input formControlName="email" type="email" />
      <span *ngIf="form.get('email')?.hasError('required')">
        Email is required
      </span>

      <input formControlName="password" type="password" />

      <button type="submit" [disabled]="form.invalid">
        Submit
      </button>
    </form>
  `,
})
export class UserFormComponent {
  form: FormGroup;

  constructor(private fb: FormBuilder) {
    this.form = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(8)]],
    });
  }

  onSubmit() {
    if (this.form.valid) {
      console.log(this.form.value);
    }
  }
}
```

### 🛣️ Angular Routing

```typescript
// app.routes.ts
import { Routes } from '@angular/router';
import { authGuard } from './guards/auth.guard';

export const appRoutes: Routes = [
  {
    path: '',
    component: HomeComponent,
  },
  {
    path: 'posts',
    component: PostsComponent,
  },
  {
    path: 'admin',
    canActivate: [authGuard],
    children: [
      {
        path: 'dashboard',
        component: DashboardComponent,
      },
      {
        path: 'settings',
        component: SettingsComponent,
      },
    ],
  },
  {
    path: '**',
    component: NotFoundComponent,
  },
];
```

### 💻 Mini Projects

1. **Blog Admin Panel**
   - Create/edit/delete posts
   - Reactive forms
   - HTTP integration
   - Route guards

2. **Data Management Dashboard**
   - Display data in tables
   - Filter and sort
   - CRUD operations
   - RxJS operators

---

## Week 5: Svelte Reactivity

### 🎯 Learning Objectives
- Understand Svelte's compiler approach
- Master reactive declarations
- Work with stores
- Build animations
- Understand what makes Svelte special

### ✨ Svelte Basics

```svelte
<!-- Counter.svelte -->
<script>
  let count = 0;
  let name = 'Svelte';

  // Reactive declarations
  $: doubled = count * 2;
  $: message = `${name}! Count is ${count}`;

  function increment() {
    count++;
  }

  // Reactive statements
  $: if (count > 10) {
    console.log('Count is high!');
  }
</script>

<main>
  <h1>{message}</h1>
  <p>Count: {count}</p>
  <p>Doubled: {doubled}</p>
  <button on:click={increment}>
    Increment
  </button>
</main>

<style>
  main {
    text-align: center;
    padding: 1em;
  }
</style>
```

### 🏪 Svelte Stores

```javascript
// stores.ts
import { writable } from 'svelte/store';

// Simple writable store
export const count = writable(0);

// Custom store with methods
function createCounter() {
  const { subscribe, set, update } = writable(0);

  return {
    subscribe,
    increment: () => update(n => n + 1),
    decrement: () => update(n => n - 1),
    reset: () => set(0),
  };
}

export const counter = createCounter();

// Derived store
import { derived } from 'svelte/store';

export const doubled = derived(counter, $counter => $counter * 2);

// Using stores in components
<script>
  import { counter, doubled } from './stores';
</script>

<p>Count: {$counter}</p>
<p>Doubled: {$doubled}</p>
<button on:click={counter.increment}>+</button>
```

### 🎬 Svelte Animations & Transitions

```svelte
<script>
  import { fade, slide } from 'svelte/transition';
  let isVisible = true;
</script>

<!-- Transition on mount/destroy -->
{#if isVisible}
  <div transition:fade={{ duration: 300 }}>
    This fades in and out
  </div>
{/if}

<!-- Slide transition -->
{#if isVisible}
  <div transition:slide={{ duration: 500, delay: 100 }}>
    Slides in
  </div>
{/if}

<!-- Animate directive for movement -->
<script>
  import { flip } from 'svelte/animate';
  let items = [1, 2, 3];
</script>

{#each items as item (item)}
  <div animate:flip={{ duration: 200 }}>
    {item}
  </div>
{/each}
```

### 💻 Mini Projects

1. **Interactive To-Do App**
   - Simple reactive data
   - Svelte stores
   - Smooth animations
   - Local storage

2. **Real-time Dashboard**
   - Multiple stores
   - Reactive updates
   - Minimal bundle size

---

## Week 6-8: Advanced Patterns

### 🎯 Learning Objectives
- Implement advanced state management
- Master performance optimization
- Build scalable architectures
- Understand framework integration
- Deploy to production

### 🔐 Advanced Patterns

```javascript
// 1. Custom Hooks (React)
function usePrevious(value) {
  const ref = useRef();
  useEffect(() => {
    ref.current = value;
  }, [value]);
  return ref.current;
}

// 2. Advanced Composables (Vue)
function useAsyncData(url) {
  const data = ref(null);
  const pending = ref(true);
  const error = ref(null);

  const refresh = async () => {
    pending.value = true;
    try {
      data.value = await $fetch(url);
    } catch (e) {
      error.value = e;
    } finally {
      pending.value = false;
    }
  };

  onMounted(refresh);
  return { data, pending, error, refresh };
}

// 3. RxJS Operators (Angular)
import { map, switchMap, shareReplay } from 'rxjs/operators';

this.posts$ = this.route.params.pipe(
  switchMap(params => this.api.getPost(params.id)),
  map(post => ({ ...post, date: new Date(post.createdAt) })),
  shareReplay(1)
);

// 4. Svelte Advanced Stores
function createAuthStore() {
  const user = writable(null);
  const loading = writable(false);

  return {
    subscribe: user.subscribe,
    login: async (email, password) => {
      loading.set(true);
      const response = await fetch('/api/login', {
        method: 'POST',
        body: JSON.stringify({ email, password }),
      });
      user.set(await response.json());
      loading.set(false);
    },
    logout: () => user.set(null),
  };
}
```

### 📊 Performance Optimization

```javascript
// React: Code splitting
const Dashboard = lazy(() => import('./pages/Dashboard'));

<Suspense fallback={<Loading />}>
  <Dashboard />
</Suspense>

// Vue: Async components
const Dashboard = defineAsyncComponent(() =>
  import('./components/Dashboard.vue')
);

// Angular: Preload strategy
import { PreloadAllModules } from '@angular/router';

RouterModule.forRoot(appRoutes, {
  preloadingStrategy: PreloadAllModules,
})

// Svelte: Dynamic imports
<script>
  let component;

  async function loadComponent() {
    component = (await import('./Dynamic.svelte')).default;
  }
</script>

{#if component}
  <svelte:component this={component} />
{/if}
```

---

## 📊 Projects & Assessment

### Capstone Project: Full-Stack Application

**Requirements:**
- ✅ Choose a framework (React, Vue, Angular, or Svelte)
- ✅ Build components architecture
- ✅ Implement routing
- ✅ Integrate API calls
- ✅ Add state management
- ✅ Responsive design
- ✅ Performance optimized
- ✅ Deployed online

**Grading Rubric:**
| Criteria | Points | Notes |
|----------|--------|-------|
| Component Design | 20 | Proper structure, reusability |
| State Management | 20 | Efficient, scalable solution |
| Routing & Navigation | 15 | SPA routing, guards |
| API Integration | 20 | Proper HTTP handling, error cases |
| Performance | 15 | Bundle size, lazy loading |
| Testing | 5 | Unit/integration tests |
| Deployment | 5 | Live on web |

### Assessment Checklist

- [ ] All components render correctly
- [ ] State management working as expected
- [ ] Routing navigates properly
- [ ] API calls successful with error handling
- [ ] Responsive on mobile, tablet, desktop
- [ ] No performance issues
- [ ] Code is clean and well-organized
- [ ] Git history is clear
- [ ] README explains the project

---

## 🎓 Next Steps

After mastering Frameworks, continue with:

1. **State Management Agent** - Advanced patterns and libraries
2. **Testing Agent** - Comprehensive testing strategies
3. **Performance Agent** - Optimization and monitoring

---

## 📚 Resources

### Official Documentation
- [React Official Docs](https://react.dev/)
- [Vue Official Docs](https://vuejs.org/)
- [Angular Official Docs](https://angular.io/)
- [Svelte Official Docs](https://svelte.dev/)

### Learning Platforms
- [Frontend Masters](https://frontendmasters.com/)
- [Egghead.io](https://egghead.io/)
- [Official Tutorials](https://learn.svelte.dev/)

### Community
- [React Community](https://react.dev/community)
- [Vue Community](https://vuejs.org/about/community)
- [Angular Resources](https://angular.io/resources)

---

**Last Updated:** November 2024 | **Version:** 1.0.0

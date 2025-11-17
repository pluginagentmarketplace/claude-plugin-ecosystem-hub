# 🚀 Advanced Topics Tutorial

**Agent 7 - Advanced Frontend Topics**
*Duration: 4-6 weeks | Level: Advanced*

---

## 📚 Table of Contents

- [Week 1: Progressive Web Apps (PWAs)](#week-1-progressive-web-apps-pwas)
- [Week 2: Web Security](#week-2-web-security)
- [Week 3: Server-Side Rendering & Static Generation](#week-3-server-side-rendering--static-generation)
- [Week 4-6: Advanced Patterns](#week-4-6-advanced-patterns)
- [Projects & Assessment](#projects--assessment)

---

## Week 1: Progressive Web Apps (PWAs)

### 🎯 Learning Objectives
- Understand PWA requirements
- Implement service workers
- Use Web App Manifests
- Handle offline functionality
- Support app installation

### 📱 PWA Requirements

```
PWA Checklist:
✅ HTTPS enabled
✅ Service Worker registered
✅ Web App Manifest
✅ App icon (192x192, 512x512)
✅ Works offline
✅ Responsive design
✅ Install prompt
✅ Cacheable assets
```

### 🔧 Web App Manifest

```json
// manifest.json
{
  "name": "My Awesome App",
  "short_name": "MyApp",
  "description": "An awesome progressive web app",
  "start_url": "/",
  "scope": "/",
  "display": "standalone",
  "orientation": "portrait",
  "theme_color": "#2196F3",
  "background_color": "#FFFFFF",
  "icons": [
    {
      "src": "/icon-192.png",
      "sizes": "192x192",
      "type": "image/png",
      "purpose": "any"
    },
    {
      "src": "/icon-512.png",
      "sizes": "512x512",
      "type": "image/png",
      "purpose": "any"
    },
    {
      "src": "/icon-maskable.png",
      "sizes": "192x192",
      "type": "image/png",
      "purpose": "maskable"
    }
  ],
  "screenshots": [
    {
      "src": "/screenshot-540.png",
      "sizes": "540x720",
      "type": "image/png",
      "form_factor": "narrow"
    },
    {
      "src": "/screenshot-1440.png",
      "sizes": "1440x1024",
      "type": "image/png",
      "form_factor": "wide"
    }
  ],
  "shortcuts": [
    {
      "name": "New Todo",
      "short_name": "Todo",
      "description": "Create a new todo item",
      "url": "/new-todo",
      "icons": [{ "src": "/icon-96.png", "sizes": "96x96" }]
    }
  ]
}

<!-- HTML head -->
<link rel="manifest" href="/manifest.json">
<meta name="theme-color" content="#2196F3">
<meta name="description" content="My awesome app">
<link rel="icon" href="/favicon.ico">
```

### 🔧 Service Worker Implementation

```javascript
// sw.js - Service Worker
const CACHE_NAME = 'v1';
const URLS_TO_CACHE = [
  '/',
  '/index.html',
  '/styles/main.css',
  '/scripts/main.js',
  '/images/logo.png',
  '/offline.html',
];

// Install event - cache essential files
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log('Caching essential files');
      return cache.addAll(URLS_TO_CACHE);
    })
  );
});

// Activate event - clean up old caches
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME) {
            console.log('Deleting old cache', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});

// Fetch event - serve from cache, update from network
self.addEventListener('fetch', (event) => {
  const { request } = event;

  // Skip non-GET requests
  if (request.method !== 'GET') {
    return;
  }

  // Network first for API calls
  if (request.url.includes('/api/')) {
    event.respondWith(
      fetch(request)
        .then((response) => {
          const cache = caches.open(CACHE_NAME);
          cache.then(c => c.put(request, response.clone()));
          return response;
        })
        .catch(() => caches.match(request))
    );
    return;
  }

  // Cache first for other requests
  event.respondWith(
    caches.match(request).then((response) => {
      if (response) return response;

      return fetch(request)
        .then((response) => {
          const cache = caches.open(CACHE_NAME);
          cache.then(c => c.put(request, response.clone()));
          return response;
        })
        .catch(() => {
          // Return offline page for navigation requests
          if (request.mode === 'navigate') {
            return caches.match('/offline.html');
          }
        });
    })
  );
});

// Background sync
self.addEventListener('sync', (event) => {
  if (event.tag === 'sync-todos') {
    event.waitUntil(syncTodos());
  }
});

async function syncTodos() {
  const todos = await db.getAllTodos();
  const unsyncedTodos = todos.filter(t => !t.synced);

  return Promise.all(
    unsyncedTodos.map(todo =>
      fetch('/api/todos', {
        method: 'POST',
        body: JSON.stringify(todo),
      })
    )
  );
}
```

### 🔔 Push Notifications

```javascript
// Request notification permission
Notification.requestPermission().then((permission) => {
  if (permission === 'granted') {
    // Subscribe to push notifications
    navigator.serviceWorker.ready.then((registration) => {
      registration.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: urlBase64ToUint8Array(PUBLIC_KEY),
      }).then((subscription) => {
        // Send subscription to server
        fetch('/api/subscribe', {
          method: 'POST',
          body: JSON.stringify(subscription),
        });
      });
    });
  }
});

// Handle push notifications in service worker
self.addEventListener('push', (event) => {
  const data = event.data.json();
  const options = {
    body: data.body,
    icon: '/icon-192.png',
    badge: '/badge-72.png',
    tag: data.tag,
    requireInteraction: true,
  };

  event.waitUntil(
    self.registration.showNotification(data.title, options)
  );
});

// Handle notification click
self.addEventListener('notificationclick', (event) => {
  event.notification.close();
  event.waitUntil(
    clients.matchAll({ type: 'window' }).then((clientList) => {
      for (let client of clientList) {
        if (client.url === '/' && 'focus' in client) {
          return client.focus();
        }
      }
      if (clients.openWindow) {
        return clients.openWindow('/');
      }
    })
  );
});
```

### 💻 Mini Projects

1. **Offline Todo App**
   - Service Worker caching
   - Local storage
   - Sync on online
   - Install prompt

2. **News Reader PWA**
   - Articles offline
   - Push notifications
   - Responsive design

---

## Week 2: Web Security

### 🎯 Learning Objectives
- Understand common vulnerabilities
- Implement security best practices
- Use secure headers
- Validate and sanitize data
- Handle authentication securely

### 🔐 OWASP Top 10 (2023)

| Vulnerability | Risk | Prevention |
|---|---|---|
| Injection (SQL, XSS) | High | Input validation, parameterized queries |
| Broken Authentication | High | Strong passwords, 2FA, session management |
| Sensitive Data Exposure | High | HTTPS, encryption, data minimization |
| XML External Entities (XXE) | Medium | Disable XXE processing |
| Broken Access Control | High | Authorization checks, RBAC |
| Security Misconfiguration | High | Secure defaults, headers |
| XSS (Cross-Site Scripting) | High | Input sanitization, CSP |
| CSRF (Cross-Site Request Forgery) | Medium | CSRF tokens, SameSite cookies |
| Using Vulnerable Components | High | Dependency scanning, updates |
| Insufficient Logging | Medium | Comprehensive logging |

### 💉 Preventing XSS

```javascript
// 1. Never use dangerouslySetInnerHTML
// ❌ Dangerous
<div dangerouslySetInnerHTML={{ __html: userInput }} />

// ✅ Safe - React escapes by default
<div>{userInput}</div>

// 2. Sanitize HTML when needed
import DOMPurify from 'dompurify';

const sanitized = DOMPurify.sanitize(userInput);
<div>{sanitized}</div>

// 3. Use Content Security Policy (CSP)
// Server response header
Content-Security-Policy: default-src 'self'; script-src 'self' trusted.com; style-src 'self' 'unsafe-inline';

// 4. HTML escaping
function escapeHtml(text) {
  const map = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#039;',
  };
  return text.replace(/[&<>"']/g, m => map[m]);
}

// 5. Use template literals safely
const userInput = "<img src=x onerror='alert(1)'>";
const html = `<div>${escapeHtml(userInput)}</div>`;
```

### 🔗 CSRF Protection

```javascript
// 1. CSRF Token validation
// Server generates token
app.get('/form', (req, res) => {
  const token = crypto.randomBytes(32).toString('hex');
  req.session.csrfToken = token;
  res.send(`<form method="POST">
    <input type="hidden" name="_csrf" value="${token}">
    <input type="text" name="username">
    <button type="submit">Submit</button>
  </form>`);
});

// Validate token on POST
app.post('/submit', (req, res) => {
  if (req.body._csrf !== req.session.csrfToken) {
    return res.status(403).send('CSRF token invalid');
  }
  // Process form
});

// 2. SameSite Cookie
// Server response
Set-Cookie: sessionId=abc123; SameSite=Strict; HttpOnly; Secure

// 3. Preflight requests for CORS
// Automatic for complex requests (POST, custom headers)
app.options('/api/data', (req, res) => {
  res.header('Access-Control-Allow-Origin', 'https://trusted.com');
  res.header('Access-Control-Allow-Methods', 'POST');
  res.header('Access-Control-Allow-Credentials', 'true');
  res.send();
});
```

### 🔐 Secure Headers

```javascript
// Express security headers middleware
import helmet from 'helmet';

app.use(helmet());

// Or manually set headers
app.use((req, res, next) => {
  // Prevent clickjacking
  res.setHeader('X-Frame-Options', 'SAMEORIGIN');

  // Enable XSS filter
  res.setHeader('X-XSS-Protection', '1; mode=block');

  // Prevent MIME type sniffing
  res.setHeader('X-Content-Type-Options', 'nosniff');

  // Content Security Policy
  res.setHeader(
    'Content-Security-Policy',
    "default-src 'self'; script-src 'self' trusted.com; style-src 'self' 'unsafe-inline'"
  );

  // Referrer Policy
  res.setHeader('Referrer-Policy', 'strict-origin-when-cross-origin');

  // HSTS (HTTP Strict Transport Security)
  res.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');

  next();
});
```

### 💻 Mini Projects

1. **Secure authentication system**
   - Password hashing
   - JWT tokens
   - Refresh token rotation

2. **Input validation library**
   - XSS prevention
   - SQL injection prevention
   - Rate limiting

---

## Week 3: Server-Side Rendering & Static Generation

### 🎯 Learning Objectives
- Understand SSR vs SSG vs CSR
- Implement server-side rendering
- Generate static sites
- Optimize SEO
- Handle data fetching

### 🔄 Rendering Strategies

```
              Time to First Byte
         ┌─────────────────────────┐
         │                         │
    CSR  │                         │
    ▼    │                         │
    ┌────────────────────────────┐ │
    │ Server sends HTML shell    │ │
    │ + JS bundle                │ │
    │ Browser renders            │ │
    └────────────────────────────┘ │
                                   │
    SSR  │                         │
    ▼    │                         │
    ┌────────────────────────────┐ │
    │ Server renders HTML        │ │
    │ Browser hydrates           │ │
    └────────────────────────────┘ │
                                   │
    SSG  │                         │
    ▼    │                         │
    ┌────────────────────────────┐ │
    │ Build-time rendering       │ │
    │ Serve pre-built HTML       │ │
    └────────────────────────────┘ │
         │                         │
         └─────────────────────────┘
```

### 🚀 Next.js Server-Side Rendering

```javascript
// pages/blog/[id].js - SSR with dynamic data
export default function BlogPost({ post, comments }) {
  return (
    <article>
      <h1>{post.title}</h1>
      <p>{post.content}</p>
      <section>
        <h2>Comments</h2>
        {comments.map(comment => (
          <div key={comment.id}>{comment.text}</div>
        ))}
      </section>
    </article>
  );
}

// Server-side data fetching
export async function getServerSideProps({ params }) {
  const { id } = params;

  const postRes = await fetch(`https://api.example.com/posts/${id}`);
  const post = await postRes.json();

  const commentsRes = await fetch(
    `https://api.example.com/posts/${id}/comments`
  );
  const comments = await commentsRes.json();

  if (!post) {
    return {
      notFound: true,
    };
  }

  return {
    props: {
      post,
      comments,
    },
    revalidate: 3600, // ISR - revalidate every hour
  };
}
```

### 🏗️ Static Site Generation (SSG)

```javascript
// pages/blog/[id].js - SSG
export default function BlogPost({ post }) {
  return (
    <article>
      <h1>{post.title}</h1>
      <p>{post.content}</p>
    </article>
  );
}

// Build-time data fetching
export async function getStaticProps({ params }) {
  const { id } = params;

  const res = await fetch(`https://api.example.com/posts/${id}`);
  const post = await res.json();

  return {
    props: {
      post,
    },
    revalidate: 86400, // Revalidate daily
  };
}

// Tell Next.js which routes to pre-generate
export async function getStaticPaths() {
  const res = await fetch('https://api.example.com/posts');
  const posts = await res.json();

  const paths = posts.map((post) => ({
    params: { id: String(post.id) },
  }));

  return {
    paths,
    fallback: 'blocking', // On-demand generation
  };
}
```

### 🎯 SEO Optimization

```javascript
// SEO Meta Tags
import Head from 'next/head';

export default function Page() {
  return (
    <>
      <Head>
        <title>Page Title - My Site</title>
        <meta name="description" content="Page description" />
        <meta name="og:title" content="Page Title" />
        <meta name="og:description" content="Page description" />
        <meta name="og:image" content="https://example.com/image.jpg" />
        <meta name="twitter:card" content="summary_large_image" />
        <link rel="canonical" href="https://example.com/page" />
      </Head>

      <h1>Page Title</h1>
      <p>Page content</p>
    </>
  );
}

// Sitemap generation
// public/sitemap.xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://example.com/</loc>
    <lastmod>2024-01-15</lastmod>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>https://example.com/blog</loc>
    <lastmod>2024-01-14</lastmod>
    <priority>0.8</priority>
  </url>
</urlset>

// robots.txt
User-agent: *
Allow: /
Disallow: /admin
Disallow: /private
Sitemap: https://example.com/sitemap.xml
```

### 💻 Mini Projects

1. **Blog with Next.js**
   - SSG for blog posts
   - API routes for comments
   - ISR for updates

2. **Product catalog**
   - Dynamic routes
   - Server-side rendering
   - Search and filtering

---

## Week 4-6: Advanced Patterns

### 🎯 Learning Objectives
- Master TypeScript in frontend
- Implement micro-frontends
- Work with GraphQL
- Build design systems
- Handle monorepos

### 📘 TypeScript Mastery

```typescript
// Advanced type definitions
// Union types
type Status = 'pending' | 'success' | 'error';

// Generic types
interface ApiResponse<T> {
  data: T;
  error: Error | null;
  loading: boolean;
}

// Utility types
type Readonly<T> = { readonly [K in keyof T]: T[K] };
type Partial<T> = { [K in keyof T]?: T[K] };
type Record<K, T> = { [P in K]: T };

// Discriminated unions
type Event =
  | { type: 'click'; x: number; y: number }
  | { type: 'scroll'; y: number }
  | { type: 'keydown'; key: string };

function handleEvent(event: Event) {
  switch (event.type) {
    case 'click':
      console.log(event.x, event.y);
      break;
    case 'scroll':
      console.log(event.y);
      break;
    case 'keydown':
      console.log(event.key);
      break;
  }
}

// Conditional types
type IsString<T> = T extends string ? true : false;

// Type inference
const obj = { name: 'John', age: 30 };
type Obj = typeof obj; // { name: string; age: number }

// React component typing
interface ButtonProps {
  onClick: (e: React.MouseEvent<HTMLButtonElement>) => void;
  children: React.ReactNode;
  variant?: 'primary' | 'secondary';
}

const Button: React.FC<ButtonProps> = ({ onClick, children, variant = 'primary' }) => (
  <button onClick={onClick} className={variant}>
    {children}
  </button>
);
```

### 🧩 Micro-Frontends with Module Federation

```javascript
// webpack.config.js - Host application
const ModuleFederationPlugin = require('webpack/lib/container/ModuleFederationPlugin');

module.exports = {
  plugins: [
    new ModuleFederationPlugin({
      name: 'host',
      remotes: {
        auth: 'auth@http://localhost:3001/remoteEntry.js',
        dashboard: 'dashboard@http://localhost:3002/remoteEntry.js',
      },
      shared: ['react', 'react-dom'],
    }),
  ],
};

// webpack.config.js - Remote application (Auth)
module.exports = {
  plugins: [
    new ModuleFederationPlugin({
      name: 'auth',
      filename: 'remoteEntry.js',
      exposes: {
        './LoginForm': './src/components/LoginForm',
        './AuthContext': './src/context/AuthContext',
      },
      shared: ['react', 'react-dom'],
    }),
  ],
};

// In host application
import LoginForm from 'auth/LoginForm';
import { AuthContext } from 'auth/AuthContext';

export default function App() {
  return (
    <AuthContext.Provider>
      <LoginForm />
    </AuthContext.Provider>
  );
}
```

### 📊 GraphQL Integration

```javascript
// Apollo Client setup
import { ApolloClient, InMemoryCache, HttpLink } from '@apollo/client';
import { gql } from '@apollo/client';

const client = new ApolloClient({
  link: new HttpLink({
    uri: 'https://api.example.com/graphql',
    credentials: 'same-origin',
  }),
  cache: new InMemoryCache(),
});

// Query definition
const GET_USERS = gql`
  query GetUsers($limit: Int!) {
    users(limit: $limit) {
      id
      name
      email
      posts {
        id
        title
      }
    }
  }
`;

// Using in React
import { useQuery } from '@apollo/client';

function Users() {
  const { data, loading, error } = useQuery(GET_USERS, {
    variables: { limit: 10 },
  });

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error: {error.message}</p>;

  return (
    <ul>
      {data.users.map(user => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}

// Mutation
const CREATE_USER = gql`
  mutation CreateUser($input: CreateUserInput!) {
    createUser(input: $input) {
      id
      name
      email
    }
  }
`;

function CreateUserForm() {
  const [createUser] = useMutation(CREATE_USER);

  const handleSubmit = async (formData) => {
    const { data } = await createUser({
      variables: { input: formData },
    });
    console.log('User created:', data.createUser);
  };

  return <form onSubmit={handleSubmit}>{/* form fields */}</form>;
}
```

### 🎨 Design Systems

```javascript
// Component library structure
components/
├── Button/
│   ├── Button.tsx
│   ├── Button.stories.tsx
│   ├── Button.test.tsx
│   └── Button.css
├── Input/
├── Card/
└── ...

// Storybook configuration
// .storybook/main.js
module.exports = {
  stories: ['../components/**/*.stories.tsx'],
  addons: ['@storybook/addon-links', '@storybook/addon-essentials'],
};

// Component story
// Button.stories.tsx
import { Story } from '@storybook/react';
import { Button } from './Button';

export default {
  title: 'Components/Button',
  component: Button,
};

const Template = (args) => <Button {...args} />;

export const Primary = Template.bind({});
Primary.args = { children: 'Primary Button', variant: 'primary' };

export const Secondary = Template.bind({});
Secondary.args = { children: 'Secondary Button', variant: 'secondary' };
```

### 💻 Advanced Projects

1. **Enterprise dashboard**
   - Multiple micro-frontends
   - GraphQL API
   - Design system
   - TypeScript throughout

2. **Design system library**
   - 20+ components
   - Storybook documentation
   - Testing suite
   - TypeScript definitions

---

## 📊 Projects & Assessment

### Capstone Project: Enterprise Application

**Requirements:**
- ✅ Full stack with TypeScript
- ✅ Micro-frontend architecture
- ✅ GraphQL integration
- ✅ PWA features
- ✅ Security best practices
- ✅ Performance optimized
- ✅ Comprehensive testing
- ✅ Design system components

**Grading Rubric:**
| Criteria | Points | Notes |
|----------|--------|-------|
| Architecture | 20 | Micro-frontends, clean design |
| TypeScript | 15 | Proper typing throughout |
| Security | 15 | All vulnerabilities fixed |
| Performance | 15 | Core Web Vitals met |
| PWA Features | 15 | Full PWA functionality |
| Testing | 10 | Comprehensive suite |
| Documentation | 10 | Architecture, API, components |

### Assessment Checklist

- [ ] TypeScript strict mode enabled
- [ ] No security vulnerabilities
- [ ] Service Worker working
- [ ] PWA installable
- [ ] All performance targets met
- [ ] GraphQL queries optimized
- [ ] Micro-frontends isolated
- [ ] Design system components reusable
- [ ] Tests passing
- [ ] Deployed and accessible

---

## 🎓 Next Steps

After mastering Advanced Topics, continue with:

1. **Deployment & DevOps** - Docker, CI/CD, cloud platforms
2. **Team Leadership** - Architecture decisions, mentoring
3. **Staying Current** - Following industry trends

---

## 📚 Resources

### Official Docs
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [PWA Documentation](https://web.dev/progressive-web-apps/)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Next.js Official](https://nextjs.org/docs)
- [GraphQL Official](https://graphql.org/learn/)

### Learning Platforms
- [Frontend Masters](https://frontendmasters.com/)
- [Egghead.io](https://egghead.io/)
- [Web.dev](https://web.dev/)

### Tools & Services
- [Auth0 for authentication](https://auth0.com/)
- [Apollo GraphQL](https://www.apollographql.com/)
- [Module Federation](https://webpack.js.org/concepts/module-federation/)
- [Storybook](https://storybook.js.org/)

---

**Last Updated:** November 2024 | **Version:** 1.0.0

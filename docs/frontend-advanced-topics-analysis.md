# Advanced Frontend Development Topics - Enterprise-Level Analysis

## Executive Summary

This document provides comprehensive coverage of advanced frontend development practices essential for enterprise-level applications. Based on analysis of the frontend development roadmap and current industry standards, this guide covers critical areas including Web APIs, Security, Server-Side Rendering, Microservices Architecture, and Advanced TypeScript patterns.

---

## 1. Web APIs and Progressive Web Applications

### 1.1 Progressive Web Apps (PWAs)

**Definition and Core Principles:**
Progressive Web Apps represent a hybrid approach combining the best of web and native applications. They deliver app-like experiences directly through web browsers while maintaining the web's inherent advantages of discoverability and universal access.

**Enterprise Benefits:**
- **Reduced Development Costs**: Single codebase for all platforms (iOS, Android, Desktop)
- **Instant Updates**: No app store approval process required
- **Improved Reach**: Accessible via URLs, improving SEO and discoverability
- **Offline Functionality**: Critical for field workers and unstable network conditions
- **Lower Friction**: No installation required for initial use

**Core PWA Requirements:**

1. **HTTPS**: Mandatory for security and Service Worker functionality
2. **Web App Manifest**: JSON file defining app appearance and behavior
3. **Service Worker**: JavaScript proxy between app and network
4. **Responsive Design**: Adaptive to all screen sizes and devices
5. **App-like Navigation**: Smooth transitions and native feel

**Implementation Example - Web App Manifest:**

```json
{
  "name": "Enterprise Dashboard",
  "short_name": "Dashboard",
  "description": "Enterprise analytics and monitoring platform",
  "start_url": "/",
  "display": "standalone",
  "orientation": "portrait-primary",
  "theme_color": "#2196F3",
  "background_color": "#ffffff",
  "icons": [
    {
      "src": "/icons/icon-72x72.png",
      "sizes": "72x72",
      "type": "image/png",
      "purpose": "maskable any"
    },
    {
      "src": "/icons/icon-192x192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "/icons/icon-512x512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ],
  "shortcuts": [
    {
      "name": "Analytics",
      "url": "/analytics",
      "description": "View analytics dashboard"
    },
    {
      "name": "Reports",
      "url": "/reports",
      "description": "Generate reports"
    }
  ],
  "categories": ["business", "productivity"],
  "iarc_rating_id": "e84b072d-71b3-4d3e-86ae-31a8ce4e53b7"
}
```

**Enterprise PWA Strategy:**
- **Progressive Enhancement**: Core functionality works everywhere, enhanced features for capable browsers
- **Performance Budget**: Set strict limits (e.g., < 3s TTI, < 100KB initial JS bundle)
- **Offline Strategy**: Define critical vs. optional offline features
- **Update Strategy**: Background updates with user notification for breaking changes

### 1.2 Service Workers

**Architecture and Lifecycle:**

Service Workers act as programmable network proxies, enabling sophisticated caching strategies and offline capabilities. They operate on a separate thread from the main application, ensuring non-blocking performance.

**Service Worker Lifecycle Stages:**

1. **Registration**: Initial registration from main application
2. **Installation**: Download and cache critical resources
3. **Activation**: Clean up old caches, take control
4. **Fetch/Message**: Handle network requests and messages
5. **Termination**: Browser terminates when idle

**Enterprise Service Worker Implementation:**

```javascript
// sw.js - Enterprise Service Worker with Advanced Caching

const CACHE_VERSION = 'v2.1.0';
const STATIC_CACHE = `static-${CACHE_VERSION}`;
const DYNAMIC_CACHE = `dynamic-${CACHE_VERSION}`;
const API_CACHE = `api-${CACHE_VERSION}`;

// Critical assets for offline functionality
const CRITICAL_ASSETS = [
  '/',
  '/index.html',
  '/styles/critical.css',
  '/scripts/app.js',
  '/offline.html',
  '/images/logo.svg'
];

// Cache-First Strategy for Static Assets
const CACHE_FIRST_ROUTES = [
  /\.(?:js|css|png|jpg|jpeg|svg|gif|woff2?)$/,
  /\/assets\//
];

// Network-First Strategy for Dynamic Content
const NETWORK_FIRST_ROUTES = [
  /\/api\/user/,
  /\/api\/realtime/
];

// Installation - Cache Critical Assets
self.addEventListener('install', (event) => {
  console.log('[SW] Installing Service Worker', CACHE_VERSION);

  event.waitUntil(
    caches.open(STATIC_CACHE)
      .then(cache => {
        console.log('[SW] Caching critical assets');
        return cache.addAll(CRITICAL_ASSETS);
      })
      .then(() => self.skipWaiting()) // Activate immediately
  );
});

// Activation - Clean Old Caches
self.addEventListener('activate', (event) => {
  console.log('[SW] Activating Service Worker', CACHE_VERSION);

  event.waitUntil(
    caches.keys()
      .then(cacheNames => {
        return Promise.all(
          cacheNames
            .filter(name => name !== STATIC_CACHE &&
                           name !== DYNAMIC_CACHE &&
                           name !== API_CACHE)
            .map(name => {
              console.log('[SW] Deleting old cache:', name);
              return caches.delete(name);
            })
        );
      })
      .then(() => self.clients.claim()) // Take control immediately
  );
});

// Fetch - Intelligent Caching Strategy
self.addEventListener('fetch', (event) => {
  const { request } = event;
  const url = new URL(request.url);

  // Skip non-GET requests
  if (request.method !== 'GET') {
    return;
  }

  // API Requests - Stale While Revalidate
  if (url.pathname.startsWith('/api/')) {
    event.respondWith(staleWhileRevalidate(request, API_CACHE));
    return;
  }

  // Static Assets - Cache First
  if (CACHE_FIRST_ROUTES.some(pattern => pattern.test(request.url))) {
    event.respondWith(cacheFirst(request, STATIC_CACHE));
    return;
  }

  // Dynamic Content - Network First
  if (NETWORK_FIRST_ROUTES.some(pattern => pattern.test(request.url))) {
    event.respondWith(networkFirst(request, DYNAMIC_CACHE));
    return;
  }

  // Default - Network First with Cache Fallback
  event.respondWith(networkFirst(request, DYNAMIC_CACHE));
});

// Caching Strategies

async function cacheFirst(request, cacheName) {
  const cached = await caches.match(request);
  if (cached) {
    return cached;
  }

  try {
    const response = await fetch(request);
    if (response.ok) {
      const cache = await caches.open(cacheName);
      cache.put(request, response.clone());
    }
    return response;
  } catch (error) {
    console.error('[SW] Cache First failed:', error);
    return caches.match('/offline.html');
  }
}

async function networkFirst(request, cacheName) {
  try {
    const response = await fetch(request);
    if (response.ok) {
      const cache = await caches.open(cacheName);
      cache.put(request, response.clone());
    }
    return response;
  } catch (error) {
    console.log('[SW] Network failed, trying cache:', request.url);
    const cached = await caches.match(request);
    if (cached) {
      return cached;
    }
    return caches.match('/offline.html');
  }
}

async function staleWhileRevalidate(request, cacheName) {
  const cache = await caches.open(cacheName);
  const cached = await cache.match(request);

  // Fetch fresh data in background
  const fetchPromise = fetch(request).then(response => {
    if (response.ok) {
      cache.put(request, response.clone());
    }
    return response;
  });

  // Return cached immediately, or wait for network
  return cached || fetchPromise;
}

// Background Sync for Offline Actions
self.addEventListener('sync', (event) => {
  if (event.tag === 'sync-offline-data') {
    event.waitUntil(syncOfflineData());
  }
});

async function syncOfflineData() {
  const db = await openIndexedDB();
  const pendingRequests = await db.getAll('pendingRequests');

  for (const request of pendingRequests) {
    try {
      await fetch(request.url, request.options);
      await db.delete('pendingRequests', request.id);
    } catch (error) {
      console.error('[SW] Sync failed for:', request.url);
    }
  }
}

// Push Notifications
self.addEventListener('push', (event) => {
  const options = {
    body: event.data?.text() || 'New notification',
    icon: '/images/icon-192x192.png',
    badge: '/images/badge-72x72.png',
    vibrate: [200, 100, 200],
    data: {
      dateOfArrival: Date.now(),
      primaryKey: 1
    },
    actions: [
      { action: 'explore', title: 'View Details' },
      { action: 'close', title: 'Dismiss' }
    ]
  };

  event.waitUntil(
    self.registration.showNotification('Enterprise Dashboard', options)
  );
});

// Notification Click Handler
self.addEventListener('notificationclick', (event) => {
  event.notification.close();

  if (event.action === 'explore') {
    event.waitUntil(
      clients.openWindow('/notifications')
    );
  }
});
```

**Service Worker Best Practices for Enterprise:**

1. **Version Management**: Include version in cache names for clean updates
2. **Cache Invalidation**: Implement TTL-based cache expiration
3. **Bandwidth Optimization**: Compress responses, use WebP images
4. **Error Handling**: Graceful degradation with offline pages
5. **Analytics**: Track cache hit rates and offline usage
6. **Security**: Validate cached responses, implement CSP
7. **Testing**: Unit tests for caching logic, integration tests for offline scenarios

### 1.3 IndexedDB

**Overview:**
IndexedDB is a low-level API for client-side storage of significant amounts of structured data. Unlike localStorage (5-10MB limit), IndexedDB can store hundreds of megabytes to gigabytes depending on browser and available disk space.

**Enterprise Use Cases:**

- **Offline-First Applications**: Store complete datasets locally
- **Form Draft Management**: Auto-save user input to prevent data loss
- **Performance Optimization**: Cache API responses, computed results
- **Binary Data Storage**: Images, PDFs, audio files
- **Transaction History**: Maintain local audit logs
- **Sync Queue**: Store pending operations for background sync

**IndexedDB Architecture:**

```javascript
// indexedDB-manager.js - Enterprise IndexedDB Implementation

class EnterpriseDBManager {
  constructor(dbName = 'EnterpriseDB', version = 1) {
    this.dbName = dbName;
    this.version = version;
    this.db = null;
  }

  // Initialize Database with Object Stores
  async init() {
    return new Promise((resolve, reject) => {
      const request = indexedDB.open(this.dbName, this.version);

      request.onerror = () => reject(request.error);
      request.onsuccess = () => {
        this.db = request.result;
        resolve(this.db);
      };

      request.onupgradeneeded = (event) => {
        const db = event.target.result;

        // Users Store
        if (!db.objectStoreNames.contains('users')) {
          const userStore = db.createObjectStore('users', {
            keyPath: 'id',
            autoIncrement: true
          });
          userStore.createIndex('email', 'email', { unique: true });
          userStore.createIndex('department', 'department', { unique: false });
          userStore.createIndex('lastLogin', 'lastLogin', { unique: false });
        }

        // Documents Store
        if (!db.objectStoreNames.contains('documents')) {
          const docStore = db.createObjectStore('documents', {
            keyPath: 'id'
          });
          docStore.createIndex('type', 'type', { unique: false });
          docStore.createIndex('createdAt', 'createdAt', { unique: false });
          docStore.createIndex('userId', 'userId', { unique: false });
          docStore.createIndex('status', 'status', { unique: false });
        }

        // API Cache Store
        if (!db.objectStoreNames.contains('apiCache')) {
          const cacheStore = db.createObjectStore('apiCache', {
            keyPath: 'url'
          });
          cacheStore.createIndex('expiry', 'expiry', { unique: false });
        }

        // Pending Operations Store (for offline sync)
        if (!db.objectStoreNames.contains('pendingOperations')) {
          const opsStore = db.createObjectStore('pendingOperations', {
            keyPath: 'id',
            autoIncrement: true
          });
          opsStore.createIndex('timestamp', 'timestamp', { unique: false });
          opsStore.createIndex('priority', 'priority', { unique: false });
        }

        // Analytics Events Store
        if (!db.objectStoreNames.contains('analyticsEvents')) {
          const analyticsStore = db.createObjectStore('analyticsEvents', {
            keyPath: 'id',
            autoIncrement: true
          });
          analyticsStore.createIndex('eventType', 'eventType', { unique: false });
          analyticsStore.createIndex('timestamp', 'timestamp', { unique: false });
          analyticsStore.createIndex('synced', 'synced', { unique: false });
        }
      };
    });
  }

  // Generic CRUD Operations

  async add(storeName, data) {
    const tx = this.db.transaction(storeName, 'readwrite');
    const store = tx.objectStore(storeName);

    return new Promise((resolve, reject) => {
      const request = store.add(data);
      request.onsuccess = () => resolve(request.result);
      request.onerror = () => reject(request.error);
    });
  }

  async get(storeName, key) {
    const tx = this.db.transaction(storeName, 'readonly');
    const store = tx.objectStore(storeName);

    return new Promise((resolve, reject) => {
      const request = store.get(key);
      request.onsuccess = () => resolve(request.result);
      request.onerror = () => reject(request.error);
    });
  }

  async getAll(storeName) {
    const tx = this.db.transaction(storeName, 'readonly');
    const store = tx.objectStore(storeName);

    return new Promise((resolve, reject) => {
      const request = store.getAll();
      request.onsuccess = () => resolve(request.result);
      request.onerror = () => reject(request.error);
    });
  }

  async update(storeName, data) {
    const tx = this.db.transaction(storeName, 'readwrite');
    const store = tx.objectStore(storeName);

    return new Promise((resolve, reject) => {
      const request = store.put(data);
      request.onsuccess = () => resolve(request.result);
      request.onerror = () => reject(request.error);
    });
  }

  async delete(storeName, key) {
    const tx = this.db.transaction(storeName, 'readwrite');
    const store = tx.objectStore(storeName);

    return new Promise((resolve, reject) => {
      const request = store.delete(key);
      request.onsuccess = () => resolve(request.result);
      request.onerror = () => reject(request.error);
    });
  }

  // Advanced Query Operations

  async queryByIndex(storeName, indexName, value) {
    const tx = this.db.transaction(storeName, 'readonly');
    const store = tx.objectStore(storeName);
    const index = store.index(indexName);

    return new Promise((resolve, reject) => {
      const request = index.getAll(value);
      request.onsuccess = () => resolve(request.result);
      request.onerror = () => reject(request.error);
    });
  }

  async queryByRange(storeName, indexName, lowerBound, upperBound) {
    const tx = this.db.transaction(storeName, 'readonly');
    const store = tx.objectStore(storeName);
    const index = store.index(indexName);
    const range = IDBKeyRange.bound(lowerBound, upperBound);

    return new Promise((resolve, reject) => {
      const request = index.getAll(range);
      request.onsuccess = () => resolve(request.result);
      request.onerror = () => reject(request.error);
    });
  }

  // Cursor-based Iteration for Large Datasets
  async iterateStore(storeName, callback) {
    const tx = this.db.transaction(storeName, 'readonly');
    const store = tx.objectStore(storeName);

    return new Promise((resolve, reject) => {
      const request = store.openCursor();

      request.onsuccess = (event) => {
        const cursor = event.target.result;
        if (cursor) {
          callback(cursor.value);
          cursor.continue();
        } else {
          resolve();
        }
      };

      request.onerror = () => reject(request.error);
    });
  }

  // Bulk Operations with Transactions
  async bulkAdd(storeName, items) {
    const tx = this.db.transaction(storeName, 'readwrite');
    const store = tx.objectStore(storeName);

    const promises = items.map(item => {
      return new Promise((resolve, reject) => {
        const request = store.add(item);
        request.onsuccess = () => resolve(request.result);
        request.onerror = () => reject(request.error);
      });
    });

    return Promise.all(promises);
  }

  // Cache Management with TTL
  async cacheAPIResponse(url, data, ttlMinutes = 60) {
    const expiry = Date.now() + (ttlMinutes * 60 * 1000);

    return this.update('apiCache', {
      url,
      data,
      expiry,
      cachedAt: Date.now()
    });
  }

  async getCachedAPIResponse(url) {
    const cached = await this.get('apiCache', url);

    if (!cached) {
      return null;
    }

    // Check if expired
    if (cached.expiry < Date.now()) {
      await this.delete('apiCache', url);
      return null;
    }

    return cached.data;
  }

  // Clean Expired Cache Entries
  async cleanExpiredCache() {
    const tx = this.db.transaction('apiCache', 'readwrite');
    const store = tx.objectStore(storeName);
    const index = store.index('expiry');
    const range = IDBKeyRange.upperBound(Date.now());

    return new Promise((resolve, reject) => {
      const request = index.openCursor(range);
      let deletedCount = 0;

      request.onsuccess = (event) => {
        const cursor = event.target.result;
        if (cursor) {
          cursor.delete();
          deletedCount++;
          cursor.continue();
        } else {
          resolve(deletedCount);
        }
      };

      request.onerror = () => reject(request.error);
    });
  }

  // Pending Operations Queue (for offline sync)
  async addPendingOperation(operation) {
    return this.add('pendingOperations', {
      ...operation,
      timestamp: Date.now(),
      retryCount: 0
    });
  }

  async getPendingOperations() {
    return this.getAll('pendingOperations');
  }

  async removePendingOperation(id) {
    return this.delete('pendingOperations', id);
  }

  // Analytics Event Tracking
  async trackEvent(eventType, eventData) {
    return this.add('analyticsEvents', {
      eventType,
      data: eventData,
      timestamp: Date.now(),
      synced: false
    });
  }

  async getUnsyncedEvents() {
    return this.queryByIndex('analyticsEvents', 'synced', false);
  }

  async markEventsSynced(eventIds) {
    const tx = this.db.transaction('analyticsEvents', 'readwrite');
    const store = tx.objectStore('analyticsEvents');

    const promises = eventIds.map(id => {
      return new Promise((resolve, reject) => {
        const getRequest = store.get(id);
        getRequest.onsuccess = () => {
          const event = getRequest.result;
          event.synced = true;
          const putRequest = store.put(event);
          putRequest.onsuccess = () => resolve();
          putRequest.onerror = () => reject(putRequest.error);
        };
        getRequest.onerror = () => reject(getRequest.error);
      });
    });

    return Promise.all(promises);
  }

  // Database Maintenance
  async clearStore(storeName) {
    const tx = this.db.transaction(storeName, 'readwrite');
    const store = tx.objectStore(storeName);

    return new Promise((resolve, reject) => {
      const request = store.clear();
      request.onsuccess = () => resolve();
      request.onerror = () => reject(request.error);
    });
  }

  async getStorageStats() {
    if ('estimate' in navigator.storage) {
      const estimate = await navigator.storage.estimate();
      return {
        usage: estimate.usage,
        quota: estimate.quota,
        usagePercent: ((estimate.usage / estimate.quota) * 100).toFixed(2),
        usageMB: (estimate.usage / (1024 * 1024)).toFixed(2),
        quotaMB: (estimate.quota / (1024 * 1024)).toFixed(2)
      };
    }
    return null;
  }

  // Close Database Connection
  close() {
    if (this.db) {
      this.db.close();
      this.db = null;
    }
  }
}

// Usage Example
async function initializeEnterpriseDB() {
  const dbManager = new EnterpriseDBManager('MyEnterpriseApp', 1);
  await dbManager.init();

  // Check storage quota
  const stats = await dbManager.getStorageStats();
  console.log('Storage Stats:', stats);

  return dbManager;
}

// Export for use in application
export default EnterpriseDBManager;
```

**IndexedDB Enterprise Best Practices:**

1. **Schema Versioning**: Plan schema migrations carefully, test thoroughly
2. **Index Strategy**: Create indexes for frequently queried fields
3. **Transaction Scope**: Keep transactions focused and short-lived
4. **Error Handling**: Implement robust error recovery mechanisms
5. **Quota Management**: Monitor storage usage, implement cleanup strategies
6. **Data Synchronization**: Implement conflict resolution for offline changes
7. **Performance**: Use cursors for large datasets, batch operations in transactions
8. **Security**: Never store sensitive unencrypted data, implement data expiration

---

## 2. Web Security in Enterprise Frontend

### 2.1 Cross-Origin Resource Sharing (CORS)

**Understanding CORS:**

CORS is a security mechanism that allows or restricts resources on a web page to be requested from a different domain. It's enforced by browsers to prevent malicious scripts from accessing sensitive data across origins.

**CORS Headers Explained:**

```
Access-Control-Allow-Origin: Specifies which origins can access the resource
Access-Control-Allow-Methods: Specifies allowed HTTP methods (GET, POST, PUT, DELETE)
Access-Control-Allow-Headers: Specifies allowed request headers
Access-Control-Allow-Credentials: Indicates whether credentials can be included
Access-Control-Max-Age: Specifies how long preflight responses can be cached
```

**Enterprise CORS Configuration (Node.js/Express Example):**

```javascript
// server/middleware/cors.js

const cors = require('cors');

// Environment-specific allowed origins
const allowedOrigins = {
  development: [
    'http://localhost:3000',
    'http://localhost:3001',
    'http://127.0.0.1:3000'
  ],
  staging: [
    'https://staging.example.com',
    'https://staging-admin.example.com'
  ],
  production: [
    'https://app.example.com',
    'https://admin.example.com',
    'https://mobile.example.com'
  ]
};

const currentOrigins = allowedOrigins[process.env.NODE_ENV] || allowedOrigins.development;

// Advanced CORS Configuration
const corsOptions = {
  origin: function (origin, callback) {
    // Allow requests with no origin (like mobile apps, Postman)
    if (!origin) {
      return callback(null, true);
    }

    if (currentOrigins.indexOf(origin) !== -1) {
      callback(null, true);
    } else {
      // Log unauthorized CORS attempts
      console.warn(`CORS blocked request from origin: ${origin}`);
      callback(new Error('Not allowed by CORS'));
    }
  },

  // Allow credentials (cookies, authorization headers)
  credentials: true,

  // Allowed methods
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'],

  // Allowed headers
  allowedHeaders: [
    'Content-Type',
    'Authorization',
    'X-Requested-With',
    'X-CSRF-Token',
    'X-API-Key',
    'Accept',
    'Origin'
  ],

  // Exposed headers (accessible to frontend)
  exposedHeaders: [
    'X-Total-Count',
    'X-Page-Count',
    'X-Rate-Limit-Remaining',
    'X-Rate-Limit-Reset'
  ],

  // Preflight cache duration (seconds)
  maxAge: 86400, // 24 hours

  // Success status for preflight
  optionsSuccessStatus: 204
};

// Apply CORS middleware
module.exports = cors(corsOptions);

// Alternative: Custom CORS middleware for fine-grained control
function customCORS(req, res, next) {
  const origin = req.headers.origin;

  if (currentOrigins.includes(origin)) {
    res.setHeader('Access-Control-Allow-Origin', origin);
    res.setHeader('Access-Control-Allow-Credentials', 'true');
    res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
  }

  // Handle preflight
  if (req.method === 'OPTIONS') {
    res.setHeader('Access-Control-Max-Age', '86400');
    return res.status(204).end();
  }

  next();
}
```

**Frontend CORS Handling:**

```javascript
// api/client.js - Frontend API Client with CORS Handling

class APIClient {
  constructor(baseURL) {
    this.baseURL = baseURL;
  }

  async request(endpoint, options = {}) {
    const url = `${this.baseURL}${endpoint}`;

    const config = {
      ...options,
      headers: {
        'Content-Type': 'application/json',
        ...options.headers
      },
      // Critical for CORS with credentials
      credentials: 'include', // Send cookies cross-origin
      mode: 'cors' // Explicit CORS mode
    };

    try {
      const response = await fetch(url, config);

      if (!response.ok) {
        if (response.status === 403) {
          throw new Error('CORS policy violation or unauthorized');
        }
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }

      return await response.json();
    } catch (error) {
      if (error.name === 'TypeError' && error.message.includes('Failed to fetch')) {
        console.error('CORS error or network failure:', error);
        throw new Error('Network request failed - possible CORS issue');
      }
      throw error;
    }
  }

  get(endpoint, options = {}) {
    return this.request(endpoint, { ...options, method: 'GET' });
  }

  post(endpoint, data, options = {}) {
    return this.request(endpoint, {
      ...options,
      method: 'POST',
      body: JSON.stringify(data)
    });
  }

  put(endpoint, data, options = {}) {
    return this.request(endpoint, {
      ...options,
      method: 'PUT',
      body: JSON.stringify(data)
    });
  }

  delete(endpoint, options = {}) {
    return this.request(endpoint, { ...options, method: 'DELETE' });
  }
}

export default APIClient;
```

**Enterprise CORS Best Practices:**

1. **Never use wildcard (*) in production** with credentials enabled
2. **Whitelist specific origins** rather than pattern matching
3. **Minimize exposed headers** to prevent information leakage
4. **Implement proper preflight handling** for complex requests
5. **Monitor CORS violations** in application logs
6. **Use HTTPS everywhere** - mixed content blocks CORS
7. **Test across environments** - different origin configurations per environment

### 2.2 Cross-Site Scripting (XSS) Prevention

**XSS Attack Types:**

1. **Stored XSS**: Malicious script stored in database, executed for all users
2. **Reflected XSS**: Script injected via URL parameters, reflected in response
3. **DOM-based XSS**: Client-side script manipulation without server involvement

**XSS Prevention Strategies:**

```javascript
// utils/sanitization.js - Input Sanitization Utilities

import DOMPurify from 'dompurify';

/**
 * Sanitize HTML content to prevent XSS attacks
 */
export function sanitizeHTML(dirty) {
  return DOMPurify.sanitize(dirty, {
    ALLOWED_TAGS: ['b', 'i', 'em', 'strong', 'a', 'p', 'br', 'ul', 'ol', 'li'],
    ALLOWED_ATTR: ['href', 'title', 'target'],
    ALLOW_DATA_ATTR: false,
    ALLOW_ARIA_ATTR: true
  });
}

/**
 * Sanitize user input for display (escape HTML entities)
 */
export function escapeHTML(text) {
  const div = document.createElement('div');
  div.textContent = text;
  return div.innerHTML;
}

/**
 * Sanitize for use in JavaScript context
 */
export function escapeJavaScript(text) {
  return text
    .replace(/\\/g, '\\\\')
    .replace(/'/g, "\\'")
    .replace(/"/g, '\\"')
    .replace(/\n/g, '\\n')
    .replace(/\r/g, '\\r')
    .replace(/\t/g, '\\t')
    .replace(/<\//g, '<\\/'); // Prevent script tag injection
}

/**
 * Sanitize URL to prevent javascript: protocol
 */
export function sanitizeURL(url) {
  // Block javascript:, data:, vbscript: protocols
  const dangerousProtocols = /^(javascript|data|vbscript):/i;

  if (dangerousProtocols.test(url)) {
    return 'about:blank';
  }

  // Ensure https:// or http:// or relative URL
  if (!/^(https?:)?\/\//i.test(url) && !url.startsWith('/')) {
    return `https://${url}`;
  }

  return url;
}

/**
 * Sanitize filename for downloads
 */
export function sanitizeFilename(filename) {
  return filename
    .replace(/[^a-z0-9._-]/gi, '_')
    .replace(/_{2,}/g, '_')
    .substring(0, 255);
}

/**
 * Content Security Policy violation reporter
 */
export function setupCSPReporting() {
  document.addEventListener('securitypolicyviolation', (e) => {
    const violation = {
      blockedURI: e.blockedURI,
      violatedDirective: e.violatedDirective,
      originalPolicy: e.originalPolicy,
      documentURI: e.documentURI,
      sourceFile: e.sourceFile,
      lineNumber: e.lineNumber,
      columnNumber: e.columnNumber
    };

    // Send to security monitoring service
    fetch('/api/security/csp-violation', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(violation)
    }).catch(console.error);
  });
}
```

**React XSS Prevention:**

```jsx
// components/SafeContent.jsx - XSS-Safe React Components

import React from 'react';
import DOMPurify from 'dompurify';

/**
 * Safely render user-generated HTML content
 */
export function SafeHTML({ html, className }) {
  const sanitized = DOMPurify.sanitize(html, {
    ALLOWED_TAGS: ['b', 'i', 'em', 'strong', 'a', 'p', 'br', 'ul', 'ol', 'li', 'h1', 'h2', 'h3'],
    ALLOWED_ATTR: ['href', 'title', 'target', 'rel'],
    ALLOW_DATA_ATTR: false
  });

  return (
    <div
      className={className}
      dangerouslySetInnerHTML={{ __html: sanitized }}
    />
  );
}

/**
 * Safely render user-generated text (auto-escape)
 */
export function SafeText({ text, tag: Tag = 'span' }) {
  // React automatically escapes text content
  return <Tag>{text}</Tag>;
}

/**
 * Safely render external links with security attributes
 */
export function SafeExternalLink({ href, children, ...props }) {
  const sanitizedHref = sanitizeURL(href);

  return (
    <a
      href={sanitizedHref}
      target="_blank"
      rel="noopener noreferrer" // Prevent tabnabbing
      {...props}
    >
      {children}
    </a>
  );
}

/**
 * User Avatar with fallback (prevent image-based XSS)
 */
export function SafeAvatar({ src, alt, size = 40 }) {
  const [error, setError] = React.useState(false);

  if (error || !src) {
    return (
      <div
        className="avatar-fallback"
        style={{ width: size, height: size }}
      >
        {alt?.charAt(0)?.toUpperCase() || '?'}
      </div>
    );
  }

  return (
    <img
      src={sanitizeURL(src)}
      alt={alt}
      width={size}
      height={size}
      onError={() => setError(true)}
      referrerPolicy="no-referrer" // Prevent referrer leakage
    />
  );
}
```

**Content Security Policy (CSP) Implementation:**

```javascript
// server/middleware/security.js - Security Headers

const helmet = require('helmet');

module.exports = function securityMiddleware(app) {
  // Use Helmet for security headers
  app.use(
    helmet({
      contentSecurityPolicy: {
        directives: {
          defaultSrc: ["'self'"],
          scriptSrc: [
            "'self'",
            "'unsafe-inline'", // Avoid in production if possible
            'https://cdn.example.com',
            'https://analytics.example.com'
          ],
          styleSrc: [
            "'self'",
            "'unsafe-inline'", // Required for many CSS-in-JS solutions
            'https://fonts.googleapis.com'
          ],
          imgSrc: [
            "'self'",
            'data:', // For inline images
            'https:', // Allow HTTPS images
            'blob:' // For dynamically generated images
          ],
          fontSrc: [
            "'self'",
            'https://fonts.gstatic.com'
          ],
          connectSrc: [
            "'self'",
            'https://api.example.com',
            'wss://websocket.example.com'
          ],
          frameSrc: ["'none'"], // Prevent iframe embedding
          objectSrc: ["'none'"], // Block plugins
          baseUri: ["'self'"], // Restrict <base> tag
          formAction: ["'self'"], // Restrict form submissions
          frameAncestors: ["'none'"], // Prevent clickjacking
          upgradeInsecureRequests: [], // Force HTTPS
          reportUri: '/api/security/csp-report'
        }
      },

      // Prevent clickjacking
      frameguard: {
        action: 'deny'
      },

      // Hide X-Powered-By header
      hidePoweredBy: true,

      // Strict Transport Security
      hsts: {
        maxAge: 31536000, // 1 year
        includeSubDomains: true,
        preload: true
      },

      // Prevent MIME sniffing
      noSniff: true,

      // XSS Protection (legacy browsers)
      xssFilter: true,

      // Referrer Policy
      referrerPolicy: {
        policy: 'strict-origin-when-cross-origin'
      }
    })
  );

  // Custom security headers
  app.use((req, res, next) => {
    // Permissions Policy (formerly Feature Policy)
    res.setHeader('Permissions-Policy',
      'geolocation=(), microphone=(), camera=(), payment=()'
    );

    // Clear Site Data on logout
    if (req.path === '/api/auth/logout') {
      res.setHeader('Clear-Site-Data', '"cache", "cookies", "storage"');
    }

    next();
  });
};
```

**XSS Enterprise Best Practices:**

1. **Input Validation**: Validate all user input on backend
2. **Output Encoding**: Escape content based on context (HTML, JS, URL, CSS)
3. **CSP Headers**: Implement strict Content Security Policy
4. **Use Framework Protection**: Leverage React/Vue/Angular auto-escaping
5. **Sanitize HTML**: Use DOMPurify for rich text content
6. **HTTP-Only Cookies**: Store sensitive tokens in HTTP-only cookies
7. **Regular Security Audits**: Scan for XSS vulnerabilities regularly

### 2.3 Cross-Site Request Forgery (CSRF) Protection

**Understanding CSRF:**

CSRF attacks trick users into executing unwanted actions on authenticated web applications. An attacker can't see the response, but can trigger state-changing operations.

**CSRF Protection Implementation:**

```javascript
// server/middleware/csrf.js - CSRF Token Implementation

const crypto = require('crypto');
const csrf = require('csurf');

// Token storage (use Redis in production for scalability)
const tokens = new Map();

/**
 * Generate CSRF token
 */
function generateToken() {
  return crypto.randomBytes(32).toString('hex');
}

/**
 * CSRF Protection Middleware (using csurf package)
 */
const csrfProtection = csrf({
  cookie: {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    sameSite: 'strict',
    maxAge: 3600 // 1 hour
  }
});

/**
 * Custom CSRF Implementation (Double Submit Cookie Pattern)
 */
function customCSRFProtection(req, res, next) {
  // Generate token for GET requests
  if (req.method === 'GET') {
    const token = generateToken();

    // Store in cookie
    res.cookie('csrf-token', token, {
      httpOnly: false, // Must be accessible to JavaScript
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'strict',
      maxAge: 3600000 // 1 hour
    });

    // Also send in response header for SPAs
    res.setHeader('X-CSRF-Token', token);

    return next();
  }

  // Validate token for state-changing requests
  if (['POST', 'PUT', 'DELETE', 'PATCH'].includes(req.method)) {
    const cookieToken = req.cookies['csrf-token'];
    const headerToken = req.headers['x-csrf-token'];

    if (!cookieToken || !headerToken || cookieToken !== headerToken) {
      return res.status(403).json({
        error: 'CSRF token validation failed',
        code: 'CSRF_VALIDATION_FAILED'
      });
    }
  }

  next();
}

/**
 * Token refresh endpoint
 */
function csrfTokenEndpoint(req, res) {
  const token = generateToken();

  res.cookie('csrf-token', token, {
    httpOnly: false,
    secure: process.env.NODE_ENV === 'production',
    sameSite: 'strict',
    maxAge: 3600000
  });

  res.json({ csrfToken: token });
}

module.exports = {
  csrfProtection,
  customCSRFProtection,
  csrfTokenEndpoint
};
```

**Frontend CSRF Integration:**

```javascript
// utils/api-client.js - API Client with CSRF Protection

class SecureAPIClient {
  constructor(baseURL) {
    this.baseURL = baseURL;
    this.csrfToken = null;
  }

  /**
   * Get CSRF token from cookie
   */
  getCSRFToken() {
    const match = document.cookie.match(/csrf-token=([^;]+)/);
    return match ? match[1] : null;
  }

  /**
   * Refresh CSRF token
   */
  async refreshCSRFToken() {
    try {
      const response = await fetch(`${this.baseURL}/api/csrf-token`, {
        method: 'GET',
        credentials: 'include'
      });

      if (response.ok) {
        const data = await response.json();
        this.csrfToken = data.csrfToken;
        return this.csrfToken;
      }
    } catch (error) {
      console.error('Failed to refresh CSRF token:', error);
    }
    return null;
  }

  /**
   * Make authenticated request with CSRF protection
   */
  async request(endpoint, options = {}) {
    const url = `${this.baseURL}${endpoint}`;
    const method = options.method || 'GET';

    // Get CSRF token for state-changing requests
    let token = this.csrfToken || this.getCSRFToken();

    if (['POST', 'PUT', 'DELETE', 'PATCH'].includes(method) && !token) {
      token = await this.refreshCSRFToken();
    }

    const config = {
      ...options,
      method,
      credentials: 'include', // Include cookies
      headers: {
        'Content-Type': 'application/json',
        ...options.headers
      }
    };

    // Add CSRF token header for state-changing requests
    if (token && ['POST', 'PUT', 'DELETE', 'PATCH'].includes(method)) {
      config.headers['X-CSRF-Token'] = token;
    }

    try {
      const response = await fetch(url, config);

      // Handle CSRF token expiration
      if (response.status === 403) {
        const data = await response.json();
        if (data.code === 'CSRF_VALIDATION_FAILED') {
          // Refresh token and retry once
          token = await this.refreshCSRFToken();
          if (token) {
            config.headers['X-CSRF-Token'] = token;
            return fetch(url, config);
          }
        }
      }

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }

      return await response.json();
    } catch (error) {
      console.error('API request failed:', error);
      throw error;
    }
  }

  get(endpoint, options = {}) {
    return this.request(endpoint, { ...options, method: 'GET' });
  }

  post(endpoint, data, options = {}) {
    return this.request(endpoint, {
      ...options,
      method: 'POST',
      body: JSON.stringify(data)
    });
  }

  put(endpoint, data, options = {}) {
    return this.request(endpoint, {
      ...options,
      method: 'PUT',
      body: JSON.stringify(data)
    });
  }

  delete(endpoint, options = {}) {
    return this.request(endpoint, { ...options, method: 'DELETE' });
  }
}

// React Hook for CSRF-protected requests
import { useState, useEffect } from 'react';

export function useSecureAPI(baseURL) {
  const [client, setClient] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const apiClient = new SecureAPIClient(baseURL);

    // Initialize CSRF token
    apiClient.refreshCSRFToken().finally(() => {
      setClient(apiClient);
      setLoading(false);
    });
  }, [baseURL]);

  return { client, loading };
}

export default SecureAPIClient;
```

**Additional CSRF Protection Measures:**

```javascript
// server/routes/api.js - Additional CSRF Protection

/**
 * SameSite Cookie Configuration
 */
function setSecureCookie(res, name, value, options = {}) {
  res.cookie(name, value, {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    sameSite: 'strict', // or 'lax' for some cross-site scenarios
    maxAge: 86400000, // 24 hours
    ...options
  });
}

/**
 * Origin/Referer Validation
 */
function validateOrigin(req, res, next) {
  const allowedOrigins = [
    'https://app.example.com',
    'https://admin.example.com'
  ];

  const origin = req.headers.origin || req.headers.referer;

  if (!origin) {
    return res.status(403).json({ error: 'Missing origin header' });
  }

  const originURL = new URL(origin);
  const isAllowed = allowedOrigins.some(allowed =>
    originURL.origin === allowed
  );

  if (!isAllowed) {
    return res.status(403).json({ error: 'Invalid origin' });
  }

  next();
}

/**
 * Custom Request Header Validation
 */
function validateCustomHeader(req, res, next) {
  // Require custom header for AJAX requests
  // Simple requests won't trigger CORS preflight
  const customHeader = req.headers['x-requested-with'];

  if (customHeader !== 'XMLHttpRequest') {
    return res.status(403).json({
      error: 'Missing required header',
      code: 'INVALID_REQUEST_HEADER'
    });
  }

  next();
}

module.exports = {
  setSecureCookie,
  validateOrigin,
  validateCustomHeader
};
```

**CSRF Enterprise Best Practices:**

1. **Use SameSite Cookies**: Set `SameSite=Strict` or `SameSite=Lax`
2. **Double Submit Cookie Pattern**: Validate cookie matches header
3. **Origin Validation**: Check Origin/Referer headers
4. **Token Rotation**: Rotate tokens periodically
5. **State-Changing Operations Only**: Don't require tokens for GET requests
6. **Custom Headers**: Require custom headers for AJAX requests
7. **Framework Integration**: Use built-in CSRF protection (Django, Rails, etc.)

---

## 3. Server-Side Rendering (SSR) and Static Site Generation (SSG)

### 3.1 Rendering Strategies Overview

**Client-Side Rendering (CSR):**
- JavaScript renders content in browser
- Poor initial load performance, excellent interactivity
- SEO challenges without additional measures

**Server-Side Rendering (SSR):**
- HTML rendered on server for each request
- Fast initial load, better SEO
- Higher server costs, more complex caching

**Static Site Generation (SSG):**
- HTML generated at build time
- Excellent performance, CDN-friendly
- Limited to static content or rebuild on data changes

**Incremental Static Regeneration (ISR):**
- Hybrid: Static generation with on-demand revalidation
- Best of both worlds: performance + freshness
- Supported by Next.js, Gatsby

### 3.2 Next.js Enterprise Implementation

**Next.js Project Structure:**

```
enterprise-next-app/
├── app/                      # App Router (Next.js 13+)
│   ├── layout.tsx           # Root layout
│   ├── page.tsx             # Home page
│   ├── dashboard/
│   │   ├── layout.tsx
│   │   ├── page.tsx
│   │   └── analytics/
│   │       └── page.tsx
│   ├── api/                 # API routes
│   │   ├── auth/
│   │   └── data/
│   └── error.tsx            # Error boundary
├── components/
│   ├── client/              # Client components
│   └── server/              # Server components
├── lib/
│   ├── api/                 # API clients
│   ├── hooks/               # React hooks
│   └── utils/               # Utilities
├── public/                  # Static assets
├── styles/                  # Global styles
└── next.config.js           # Next.js configuration
```

**Advanced Next.js Configuration:**

```javascript
// next.config.js - Enterprise Next.js Configuration

const withBundleAnalyzer = require('@next/bundle-analyzer')({
  enabled: process.env.ANALYZE === 'true'
});

/** @type {import('next').NextConfig} */
const nextConfig = {
  // React strict mode
  reactStrictMode: true,

  // SWC minification (faster than Terser)
  swcMinify: true,

  // Experimental features
  experimental: {
    // Server Actions (Next.js 13.4+)
    serverActions: true,

    // Turbopack (Next.js 13+, dev only)
    turbo: {
      rules: {
        '*.svg': {
          loaders: ['@svgr/webpack'],
          as: '*.js'
        }
      }
    }
  },

  // Image optimization
  images: {
    domains: ['cdn.example.com', 'images.example.com'],
    formats: ['image/avif', 'image/webp'],
    deviceSizes: [640, 750, 828, 1080, 1200, 1920, 2048, 3840],
    imageSizes: [16, 32, 48, 64, 96, 128, 256, 384],
    minimumCacheTTL: 60,
    dangerouslyAllowSVG: true,
    contentSecurityPolicy: "default-src 'self'; script-src 'none'; sandbox;"
  },

  // Internationalization
  i18n: {
    locales: ['en', 'es', 'fr', 'de'],
    defaultLocale: 'en',
    localeDetection: true
  },

  // Headers
  async headers() {
    return [
      {
        source: '/:path*',
        headers: [
          {
            key: 'X-DNS-Prefetch-Control',
            value: 'on'
          },
          {
            key: 'Strict-Transport-Security',
            value: 'max-age=63072000; includeSubDomains; preload'
          },
          {
            key: 'X-Frame-Options',
            value: 'SAMEORIGIN'
          },
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff'
          },
          {
            key: 'Referrer-Policy',
            value: 'strict-origin-when-cross-origin'
          }
        ]
      },
      {
        source: '/static/:path*',
        headers: [
          {
            key: 'Cache-Control',
            value: 'public, max-age=31536000, immutable'
          }
        ]
      }
    ];
  },

  // Redirects
  async redirects() {
    return [
      {
        source: '/old-dashboard',
        destination: '/dashboard',
        permanent: true
      }
    ];
  },

  // Rewrites (proxy API calls)
  async rewrites() {
    return [
      {
        source: '/api/v1/:path*',
        destination: 'https://api.example.com/:path*'
      }
    ];
  },

  // Webpack customization
  webpack: (config, { buildId, dev, isServer, defaultLoaders, webpack }) => {
    // Custom aliases
    config.resolve.alias = {
      ...config.resolve.alias,
      '@components': path.join(__dirname, 'components'),
      '@lib': path.join(__dirname, 'lib'),
      '@styles': path.join(__dirname, 'styles')
    };

    // Analyze bundle size
    if (process.env.ANALYZE) {
      const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer');
      config.plugins.push(
        new BundleAnalyzerPlugin({
          analyzerMode: 'static',
          reportFilename: isServer
            ? '../analyze/server.html'
            : './analyze/client.html'
        })
      );
    }

    return config;
  },

  // Environment variables exposed to browser
  env: {
    NEXT_PUBLIC_API_URL: process.env.NEXT_PUBLIC_API_URL,
    NEXT_PUBLIC_ANALYTICS_ID: process.env.NEXT_PUBLIC_ANALYTICS_ID
  },

  // Output configuration
  output: 'standalone', // For Docker deployments

  // Compression
  compress: true,

  // Power by header
  poweredByHeader: false,

  // Production source maps
  productionBrowserSourceMaps: false,

  // Trailing slash
  trailingSlash: false,

  // ESLint during builds
  eslint: {
    ignoreDuringBuilds: false
  },

  // TypeScript during builds
  typescript: {
    ignoreBuildErrors: false
  }
};

module.exports = withBundleAnalyzer(nextConfig);
```

**SSR with Data Fetching (App Router):**

```typescript
// app/products/[id]/page.tsx - SSR Product Page

import { Metadata } from 'next';
import { notFound } from 'next/navigation';

// Type definitions
interface Product {
  id: string;
  name: string;
  description: string;
  price: number;
  image: string;
  category: string;
}

interface PageProps {
  params: { id: string };
  searchParams: { [key: string]: string | string[] | undefined };
}

// Metadata generation (SEO)
export async function generateMetadata(
  { params }: PageProps
): Promise<Metadata> {
  const product = await fetchProduct(params.id);

  if (!product) {
    return {
      title: 'Product Not Found'
    };
  }

  return {
    title: `${product.name} | Enterprise Store`,
    description: product.description,
    openGraph: {
      title: product.name,
      description: product.description,
      images: [product.image],
      type: 'website'
    },
    twitter: {
      card: 'summary_large_image',
      title: product.name,
      description: product.description,
      images: [product.image]
    }
  };
}

// Static params generation for SSG
export async function generateStaticParams() {
  const products = await fetchAllProducts();

  return products.map((product) => ({
    id: product.id
  }));
}

// Server component with data fetching
async function fetchProduct(id: string): Promise<Product | null> {
  try {
    const res = await fetch(`https://api.example.com/products/${id}`, {
      next: {
        revalidate: 60 // ISR: revalidate every 60 seconds
      }
    });

    if (!res.ok) {
      return null;
    }

    return res.json();
  } catch (error) {
    console.error('Failed to fetch product:', error);
    return null;
  }
}

async function fetchRelatedProducts(category: string): Promise<Product[]> {
  try {
    const res = await fetch(
      `https://api.example.com/products?category=${category}&limit=4`,
      {
        next: { revalidate: 300 } // Cache for 5 minutes
      }
    );

    if (!res.ok) {
      return [];
    }

    return res.json();
  } catch (error) {
    console.error('Failed to fetch related products:', error);
    return [];
  }
}

// Main page component (Server Component)
export default async function ProductPage({ params }: PageProps) {
  const product = await fetchProduct(params.id);

  if (!product) {
    notFound();
  }

  // Parallel data fetching
  const relatedProducts = await fetchRelatedProducts(product.category);

  return (
    <div className="product-page">
      <div className="product-details">
        <h1>{product.name}</h1>
        <img src={product.image} alt={product.name} />
        <p>{product.description}</p>
        <p className="price">${product.price}</p>

        {/* Client component for interactivity */}
        <AddToCartButton productId={product.id} />
      </div>

      <div className="related-products">
        <h2>Related Products</h2>
        <div className="product-grid">
          {relatedProducts.map(related => (
            <ProductCard key={related.id} product={related} />
          ))}
        </div>
      </div>
    </div>
  );
}

// Revalidation configuration
export const revalidate = 60; // ISR: revalidate every 60 seconds
export const dynamic = 'force-static'; // Force static generation
// export const dynamic = 'force-dynamic'; // Force SSR
// export const dynamic = 'error'; // Error if attempted to be dynamic
```

**Client Component for Interactivity:**

```typescript
// components/client/AddToCartButton.tsx

'use client'; // Mark as client component

import { useState } from 'react';
import { useCart } from '@/lib/hooks/useCart';

interface AddToCartButtonProps {
  productId: string;
}

export default function AddToCartButton({ productId }: AddToCartButtonProps) {
  const [loading, setLoading] = useState(false);
  const { addItem } = useCart();

  async function handleAddToCart() {
    setLoading(true);
    try {
      await addItem(productId);
      // Show success notification
    } catch (error) {
      // Show error notification
      console.error('Failed to add to cart:', error);
    } finally {
      setLoading(false);
    }
  }

  return (
    <button
      onClick={handleAddToCart}
      disabled={loading}
      className="add-to-cart-button"
    >
      {loading ? 'Adding...' : 'Add to Cart'}
    </button>
  );
}
```

**API Routes (Server-Side):**

```typescript
// app/api/cart/route.ts - API Route Handler

import { NextRequest, NextResponse } from 'next/server';
import { getServerSession } from 'next-auth';
import { authOptions } from '@/lib/auth';

// GET /api/cart
export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);

    if (!session) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    // Fetch cart from database
    const cart = await fetchUserCart(session.user.id);

    return NextResponse.json(cart);
  } catch (error) {
    console.error('Failed to fetch cart:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// POST /api/cart
export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions);

    if (!session) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    const body = await request.json();
    const { productId, quantity } = body;

    // Validate input
    if (!productId || !quantity) {
      return NextResponse.json(
        { error: 'Invalid input' },
        { status: 400 }
      );
    }

    // Add to cart in database
    const cart = await addToUserCart(session.user.id, productId, quantity);

    return NextResponse.json(cart, { status: 201 });
  } catch (error) {
    console.error('Failed to add to cart:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// PATCH /api/cart/[itemId]
export async function PATCH(
  request: NextRequest,
  { params }: { params: { itemId: string } }
) {
  try {
    const session = await getServerSession(authOptions);

    if (!session) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    const body = await request.json();
    const { quantity } = body;

    // Update cart item
    const cart = await updateCartItem(
      session.user.id,
      params.itemId,
      quantity
    );

    return NextResponse.json(cart);
  } catch (error) {
    console.error('Failed to update cart:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}

// DELETE /api/cart/[itemId]
export async function DELETE(
  request: NextRequest,
  { params }: { params: { itemId: string } }
) {
  try {
    const session = await getServerSession(authOptions);

    if (!session) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      );
    }

    // Remove from cart
    await removeFromCart(session.user.id, params.itemId);

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error('Failed to remove from cart:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

### 3.3 SSR/SSG Enterprise Best Practices

**Performance Optimization:**

```typescript
// Performance monitoring for SSR

import { performance } from 'perf_hooks';

export async function measureSSRPerformance<T>(
  name: string,
  fn: () => Promise<T>
): Promise<T> {
  const start = performance.now();

  try {
    const result = await fn();
    const duration = performance.now() - start;

    // Log to monitoring service
    console.log(`[SSR Performance] ${name}: ${duration.toFixed(2)}ms`);

    if (duration > 1000) {
      console.warn(`[SSR Warning] ${name} took ${duration.toFixed(2)}ms`);
    }

    return result;
  } catch (error) {
    const duration = performance.now() - start;
    console.error(`[SSR Error] ${name} failed after ${duration.toFixed(2)}ms`);
    throw error;
  }
}

// Usage
export async function getServerSideProps(context) {
  const data = await measureSSRPerformance('fetchUserData', async () => {
    return fetchUserData(context.params.id);
  });

  return { props: { data } };
}
```

**Caching Strategies:**

1. **ISR (Incremental Static Regeneration)**:
   - Revalidate periodically (`revalidate: 60`)
   - On-demand revalidation via API

2. **CDN Caching**:
   - Set appropriate Cache-Control headers
   - Use CDN edge caching (Vercel, Cloudflare)

3. **API Response Caching**:
   - Cache responses in Redis/Memcached
   - Implement stale-while-revalidate pattern

4. **Database Query Optimization**:
   - Use database query caching
   - Implement connection pooling

**Enterprise SSR/SSG Guidelines:**

1. **Choose the Right Strategy**:
   - SSG: Marketing pages, blogs, documentation
   - SSR: Personalized content, frequently changing data
   - ISR: E-commerce, news sites (balance freshness/performance)

2. **Optimize Data Fetching**:
   - Parallel data fetching where possible
   - Implement request deduplication
   - Use streaming SSR for large responses

3. **Error Handling**:
   - Implement fallback pages for errors
   - Use error boundaries
   - Log SSR errors to monitoring service

4. **Security**:
   - Never expose sensitive data in SSR props
   - Validate all inputs on server
   - Implement rate limiting for API routes

5. **Monitoring**:
   - Track SSR performance metrics
   - Monitor build times for SSG
   - Alert on performance degradation

---

## 4. Microservices Architecture in Frontend

### 4.1 Micro-Frontends Overview

**Definition:**
Micro-frontends extend microservices concepts to frontend development, allowing independent teams to build, deploy, and maintain distinct parts of a larger frontend application.

**Benefits:**
- **Independent Development**: Teams work autonomously
- **Technology Agnostic**: Different frameworks per micro-frontend
- **Incremental Upgrades**: Migrate gradually from legacy systems
- **Scalability**: Scale teams and codebases independently
- **Deployment Independence**: Deploy features without coordinating releases

**Challenges:**
- **Complexity**: Orchestration and communication overhead
- **Performance**: Multiple bundles can impact load time
- **Consistency**: Maintaining UX consistency across teams
- **Shared Dependencies**: Managing shared libraries and state

### 4.2 Micro-Frontend Implementation Patterns

**1. Build-Time Integration (npm Packages)**

```json
// package.json - Main Application
{
  "name": "main-app",
  "dependencies": {
    "@company/header-mfe": "^1.2.0",
    "@company/product-mfe": "^2.1.0",
    "@company/checkout-mfe": "^1.5.0"
  }
}
```

```typescript
// App.tsx - Compose micro-frontends
import Header from '@company/header-mfe';
import ProductCatalog from '@company/product-mfe';
import Checkout from '@company/checkout-mfe';

export default function App() {
  return (
    <>
      <Header />
      <main>
        <ProductCatalog />
        <Checkout />
      </main>
    </>
  );
}
```

**Pros**: Simple, type-safe, good performance
**Cons**: Requires rebuild/redeploy of main app for updates

**2. Runtime Integration (Module Federation)**

```javascript
// webpack.config.js - Header Micro-Frontend (Remote)

const ModuleFederationPlugin = require('webpack/lib/container/ModuleFederationPlugin');

module.exports = {
  plugins: [
    new ModuleFederationPlugin({
      name: 'header',
      filename: 'remoteEntry.js',
      exposes: {
        './Header': './src/Header',
        './Navigation': './src/Navigation'
      },
      shared: {
        react: { singleton: true, requiredVersion: '^18.0.0' },
        'react-dom': { singleton: true, requiredVersion: '^18.0.0' }
      }
    })
  ]
};

// webpack.config.js - Main Application (Host)

module.exports = {
  plugins: [
    new ModuleFederationPlugin({
      name: 'host',
      remotes: {
        header: 'header@https://cdn.example.com/header/remoteEntry.js',
        product: 'product@https://cdn.example.com/product/remoteEntry.js',
        checkout: 'checkout@https://cdn.example.com/checkout/remoteEntry.js'
      },
      shared: {
        react: { singleton: true, requiredVersion: '^18.0.0' },
        'react-dom': { singleton: true, requiredVersion: '^18.0.0' }
      }
    })
  ]
};
```

```typescript
// App.tsx - Dynamic import of micro-frontends

import React, { Suspense, lazy } from 'react';

const Header = lazy(() => import('header/Header'));
const ProductCatalog = lazy(() => import('product/Catalog'));
const Checkout = lazy(() => import('checkout/Checkout'));

export default function App() {
  return (
    <Suspense fallback={<Loading />}>
      <Header />
      <main>
        <ProductCatalog />
        <Checkout />
      </main>
    </Suspense>
  );
}
```

**Pros**: Independent deployment, runtime composition
**Cons**: Complex setup, potential runtime errors

**3. IFrame Integration**

```html
<!-- Main Application -->
<div class="micro-frontend-container">
  <iframe
    src="https://header.example.com"
    title="Header"
    sandbox="allow-scripts allow-same-origin"
  ></iframe>

  <main>
    <iframe
      src="https://products.example.com/catalog"
      title="Product Catalog"
      sandbox="allow-scripts allow-same-origin allow-forms"
    ></iframe>
  </main>
</div>
```

```javascript
// Cross-iframe communication

// Parent (Main App)
const iframe = document.getElementById('product-iframe');
iframe.contentWindow.postMessage({ action: 'updateFilter', value: 'electronics' }, 'https://products.example.com');

window.addEventListener('message', (event) => {
  if (event.origin !== 'https://products.example.com') return;

  if (event.data.action === 'productSelected') {
    console.log('Product selected:', event.data.productId);
  }
});

// Child (Product MFE)
window.addEventListener('message', (event) => {
  if (event.origin !== 'https://main.example.com') return;

  if (event.data.action === 'updateFilter') {
    updateProductFilter(event.data.value);
  }
});

// Send message to parent
window.parent.postMessage({ action: 'productSelected', productId: '123' }, 'https://main.example.com');
```

**Pros**: Complete isolation, technology agnostic
**Cons**: Poor performance, difficult styling, routing challenges

**4. Web Components Integration**

```javascript
// header-mfe/src/Header.js - Web Component

class HeaderComponent extends HTMLElement {
  connectedCallback() {
    this.attachShadow({ mode: 'open' });
    this.render();
    this.attachEventListeners();
  }

  render() {
    this.shadowRoot.innerHTML = `
      <style>
        :host {
          display: block;
          background: #fff;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        nav {
          display: flex;
          justify-content: space-between;
          padding: 1rem 2rem;
        }
      </style>
      <nav>
        <div class="logo">Company Logo</div>
        <ul class="nav-links">
          <li><a href="/">Home</a></li>
          <li><a href="/products">Products</a></li>
          <li><a href="/about">About</a></li>
        </ul>
        <button class="user-menu">User</button>
      </nav>
    `;
  }

  attachEventListeners() {
    const userMenu = this.shadowRoot.querySelector('.user-menu');
    userMenu.addEventListener('click', () => {
      this.dispatchEvent(new CustomEvent('user-menu-clicked', {
        bubbles: true,
        composed: true
      }));
    });
  }

  // Observed attributes
  static get observedAttributes() {
    return ['user-name', 'logged-in'];
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (name === 'user-name') {
      const userMenu = this.shadowRoot.querySelector('.user-menu');
      if (userMenu) {
        userMenu.textContent = newValue;
      }
    }
  }
}

customElements.define('company-header', HeaderComponent);
```

```html
<!-- Main Application -->
<!DOCTYPE html>
<html>
<head>
  <script src="https://cdn.example.com/header/header.js"></script>
  <script src="https://cdn.example.com/product/product-catalog.js"></script>
</head>
<body>
  <company-header user-name="John Doe" logged-in="true"></company-header>

  <main>
    <product-catalog category="electronics"></product-catalog>
  </main>

  <script>
    document.querySelector('company-header')
      .addEventListener('user-menu-clicked', (e) => {
        console.log('User menu clicked');
      });
  </script>
</body>
</html>
```

**Pros**: Framework agnostic, good encapsulation
**Cons**: Limited browser support (needs polyfills), Shadow DOM complexity

### 4.3 Enterprise Micro-Frontend Architecture

**Complete Implementation Example:**

```typescript
// packages/core/src/MicroFrontendOrchestrator.ts

interface MicroFrontendConfig {
  name: string;
  host: string;
  routes: string[];
  fallback?: React.ComponentType;
}

interface MicroFrontendRegistry {
  [key: string]: MicroFrontendConfig;
}

class MicroFrontendOrchestrator {
  private registry: MicroFrontendRegistry = {};
  private loadedModules: Map<string, any> = new Map();

  register(config: MicroFrontendConfig) {
    this.registry[config.name] = config;
  }

  async load(name: string): Promise<any> {
    if (this.loadedModules.has(name)) {
      return this.loadedModules.get(name);
    }

    const config = this.registry[name];
    if (!config) {
      throw new Error(`Micro-frontend "${name}" not registered`);
    }

    try {
      // Dynamic import with retry logic
      const module = await this.loadWithRetry(config.host, 3);
      this.loadedModules.set(name, module);
      return module;
    } catch (error) {
      console.error(`Failed to load micro-frontend "${name}":`, error);
      throw error;
    }
  }

  private async loadWithRetry(url: string, retries: number): Promise<any> {
    for (let i = 0; i < retries; i++) {
      try {
        const response = await fetch(url);
        if (!response.ok) throw new Error(`HTTP ${response.status}`);

        const code = await response.text();
        const module = eval(code);
        return module;
      } catch (error) {
        if (i === retries - 1) throw error;
        await new Promise(resolve => setTimeout(resolve, 1000 * (i + 1)));
      }
    }
  }

  getRoutes(): Array<{ path: string; mfe: string }> {
    return Object.entries(this.registry).flatMap(([name, config]) =>
      config.routes.map(route => ({ path: route, mfe: name }))
    );
  }
}

export const orchestrator = new MicroFrontendOrchestrator();

// Register micro-frontends
orchestrator.register({
  name: 'header',
  host: 'https://cdn.example.com/header/remoteEntry.js',
  routes: []
});

orchestrator.register({
  name: 'product',
  host: 'https://cdn.example.com/product/remoteEntry.js',
  routes: ['/products', '/products/:id']
});

orchestrator.register({
  name: 'checkout',
  host: 'https://cdn.example.com/checkout/remoteEntry.js',
  routes: ['/cart', '/checkout']
});
```

**Shared State Management:**

```typescript
// packages/core/src/SharedState.ts

import { BehaviorSubject, Observable } from 'rxjs';

interface GlobalState {
  user: User | null;
  cart: CartItem[];
  notifications: Notification[];
}

class SharedStateManager {
  private state$ = new BehaviorSubject<GlobalState>({
    user: null,
    cart: [],
    notifications: []
  });

  get state(): GlobalState {
    return this.state$.value;
  }

  observe(): Observable<GlobalState> {
    return this.state$.asObservable();
  }

  observeKey<K extends keyof GlobalState>(key: K): Observable<GlobalState[K]> {
    return new Observable(observer => {
      const subscription = this.state$.subscribe(state => {
        observer.next(state[key]);
      });
      return () => subscription.unsubscribe();
    });
  }

  update(partial: Partial<GlobalState>) {
    this.state$.next({
      ...this.state$.value,
      ...partial
    });
  }

  updateKey<K extends keyof GlobalState>(key: K, value: GlobalState[K]) {
    this.state$.next({
      ...this.state$.value,
      [key]: value
    });
  }

  // Specific actions
  setUser(user: User | null) {
    this.updateKey('user', user);
  }

  addToCart(item: CartItem) {
    const cart = [...this.state.cart, item];
    this.updateKey('cart', cart);
  }

  removeFromCart(itemId: string) {
    const cart = this.state.cart.filter(item => item.id !== itemId);
    this.updateKey('cart', cart);
  }

  addNotification(notification: Notification) {
    const notifications = [...this.state.notifications, notification];
    this.updateKey('notifications', notifications);
  }

  clearNotifications() {
    this.updateKey('notifications', []);
  }
}

export const sharedState = new SharedStateManager();

// React hook for consuming shared state
import { useEffect, useState } from 'react';

export function useSharedState<K extends keyof GlobalState>(
  key: K
): GlobalState[K] {
  const [value, setValue] = useState<GlobalState[K]>(sharedState.state[key]);

  useEffect(() => {
    const subscription = sharedState.observeKey(key).subscribe(setValue);
    return () => subscription.unsubscribe();
  }, [key]);

  return value;
}
```

**Event Bus for Communication:**

```typescript
// packages/core/src/EventBus.ts

type EventHandler<T = any> = (data: T) => void;

interface EventSubscription {
  unsubscribe: () => void;
}

class EventBus {
  private handlers: Map<string, Set<EventHandler>> = new Map();
  private eventLog: Array<{ event: string; data: any; timestamp: number }> = [];

  subscribe(event: string, handler: EventHandler): EventSubscription {
    if (!this.handlers.has(event)) {
      this.handlers.set(event, new Set());
    }

    this.handlers.get(event)!.add(handler);

    return {
      unsubscribe: () => {
        this.handlers.get(event)?.delete(handler);
      }
    };
  }

  publish<T = any>(event: string, data?: T) {
    // Log event for debugging
    this.eventLog.push({
      event,
      data,
      timestamp: Date.now()
    });

    // Trim log to last 100 events
    if (this.eventLog.length > 100) {
      this.eventLog.shift();
    }

    // Notify all handlers
    const handlers = this.handlers.get(event);
    if (handlers) {
      handlers.forEach(handler => {
        try {
          handler(data);
        } catch (error) {
          console.error(`Error in event handler for "${event}":`, error);
        }
      });
    }
  }

  getEventLog() {
    return this.eventLog;
  }

  clear() {
    this.handlers.clear();
    this.eventLog = [];
  }
}

export const eventBus = new EventBus();

// React hook for event subscription
import { useEffect } from 'react';

export function useEventBus<T = any>(
  event: string,
  handler: EventHandler<T>
) {
  useEffect(() => {
    const subscription = eventBus.subscribe(event, handler);
    return () => subscription.unsubscribe();
  }, [event, handler]);
}

// Usage examples:

// Publish event
eventBus.publish('product:added-to-cart', { productId: '123', quantity: 1 });

// Subscribe to event
const subscription = eventBus.subscribe('product:added-to-cart', (data) => {
  console.log('Product added:', data);
});

// In React component
function CartCounter() {
  const [count, setCount] = useState(0);

  useEventBus('product:added-to-cart', () => {
    setCount(prev => prev + 1);
  });

  return <div>Cart Items: {count}</div>;
}
```

### 4.4 Micro-Frontend Best Practices

**1. Independent Deployment Pipeline:**

```yaml
# .github/workflows/deploy-header-mfe.yml

name: Deploy Header Micro-Frontend

on:
  push:
    branches: [main]
    paths:
      - 'packages/header/**'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'

      - name: Install dependencies
        working-directory: ./packages/header
        run: npm ci

      - name: Run tests
        working-directory: ./packages/header
        run: npm test

      - name: Build
        working-directory: ./packages/header
        run: npm run build

      - name: Deploy to CDN
        working-directory: ./packages/header
        run: |
          aws s3 sync dist/ s3://mfe-cdn/header/ --delete
          aws cloudfront create-invalidation \
            --distribution-id ${{ secrets.CDN_DISTRIBUTION_ID }} \
            --paths "/header/*"

      - name: Update version registry
        run: |
          curl -X POST https://api.example.com/mfe-registry/header \
            -H "Authorization: Bearer ${{ secrets.REGISTRY_TOKEN }}" \
            -d '{"version": "${{ github.sha }}", "url": "https://cdn.example.com/header/remoteEntry.js"}'
```

**2. Consistent Design System:**

```typescript
// packages/design-system/src/index.ts

// Shared design tokens
export const tokens = {
  colors: {
    primary: '#007bff',
    secondary: '#6c757d',
    success: '#28a745',
    danger: '#dc3545',
    warning: '#ffc107',
    info: '#17a2b8'
  },
  spacing: {
    xs: '0.25rem',
    sm: '0.5rem',
    md: '1rem',
    lg: '1.5rem',
    xl: '2rem'
  },
  typography: {
    fontFamily: '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
    fontSize: {
      xs: '0.75rem',
      sm: '0.875rem',
      base: '1rem',
      lg: '1.125rem',
      xl: '1.25rem',
      '2xl': '1.5rem'
    }
  }
};

// Shared React components
export { Button } from './components/Button';
export { Input } from './components/Input';
export { Modal } from './components/Modal';
export { Toast } from './components/Toast';
```

**3. Error Boundaries:**

```typescript
// packages/core/src/ErrorBoundary.tsx

import React, { Component, ReactNode } from 'react';

interface Props {
  children: ReactNode;
  fallback?: ReactNode;
  microFrontendName?: string;
}

interface State {
  hasError: boolean;
  error?: Error;
}

export class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: React.ErrorInfo) {
    console.error(
      `Error in ${this.props.microFrontendName || 'micro-frontend'}:`,
      error,
      errorInfo
    );

    // Log to error tracking service
    logErrorToService({
      error: error.message,
      stack: error.stack,
      componentStack: errorInfo.componentStack,
      microFrontend: this.props.microFrontendName
    });
  }

  render() {
    if (this.state.hasError) {
      if (this.props.fallback) {
        return this.props.fallback;
      }

      return (
        <div className="error-boundary">
          <h2>Something went wrong</h2>
          <p>We're sorry for the inconvenience. Please try refreshing the page.</p>
        </div>
      );
    }

    return this.props.children;
  }
}
```

**4. Performance Monitoring:**

```typescript
// packages/core/src/PerformanceMonitor.ts

class PerformanceMonitor {
  trackMicroFrontendLoad(name: string, duration: number) {
    console.log(`[Performance] ${name} loaded in ${duration}ms`);

    // Send to analytics
    if (window.gtag) {
      window.gtag('event', 'mfe_load', {
        mfe_name: name,
        load_duration: duration
      });
    }

    // Alert if slow
    if (duration > 3000) {
      console.warn(`[Performance Warning] ${name} took ${duration}ms to load`);
    }
  }

  trackInteraction(microFrontend: string, interaction: string) {
    console.log(`[Interaction] ${microFrontend}: ${interaction}`);

    if (window.gtag) {
      window.gtag('event', 'mfe_interaction', {
        mfe_name: microFrontend,
        interaction_type: interaction
      });
    }
  }
}

export const performanceMonitor = new PerformanceMonitor();
```

**5. Versioning Strategy:**

```typescript
// packages/core/src/VersionManager.ts

interface VersionInfo {
  version: string;
  url: string;
  deployedAt: string;
}

interface VersionRegistry {
  [microFrontend: string]: VersionInfo;
}

class VersionManager {
  private registry: VersionRegistry = {};

  async fetchVersions() {
    try {
      const response = await fetch('https://api.example.com/mfe-versions');
      this.registry = await response.json();
    } catch (error) {
      console.error('Failed to fetch micro-frontend versions:', error);
    }
  }

  getVersion(microFrontend: string): VersionInfo | null {
    return this.registry[microFrontend] || null;
  }

  getAllVersions(): VersionRegistry {
    return this.registry;
  }

  // Check for updates
  async checkForUpdates(microFrontend: string, currentVersion: string): Promise<boolean> {
    await this.fetchVersions();
    const latest = this.getVersion(microFrontend);
    return latest ? latest.version !== currentVersion : false;
  }
}

export const versionManager = new VersionManager();
```

**Enterprise Micro-Frontend Guidelines:**

1. **Independent Deployability**: Each MFE should deploy independently
2. **Loose Coupling**: Minimize direct dependencies between MFEs
3. **Shared Libraries**: Use shared design system and core utilities
4. **Error Isolation**: Errors in one MFE shouldn't crash entire app
5. **Performance Budget**: Set and enforce bundle size limits
6. **Consistent UX**: Maintain design consistency across MFEs
7. **Communication Protocol**: Standardize event naming and data structures
8. **Monitoring**: Track load times, errors, and user interactions per MFE

---

## 5. TypeScript Advanced Patterns for Enterprise

### 5.1 Type System Fundamentals

**Advanced Type Definitions:**

```typescript
// types/advanced.ts - Enterprise Type Definitions

// Utility Types
type DeepPartial<T> = {
  [P in keyof T]?: T[P] extends object ? DeepPartial<T[P]> : T[P];
};

type DeepReadonly<T> = {
  readonly [P in keyof T]: T[P] extends object ? DeepReadonly<T[P]> : T[P];
};

type Nullable<T> = T | null;
type Optional<T> = T | undefined;
type Maybe<T> = T | null | undefined;

// Branded Types (Nominal Typing)
type Brand<K, T> = K & { __brand: T };

type UserId = Brand<string, 'UserId'>;
type ProductId = Brand<string, 'ProductId'>;
type Email = Brand<string, 'Email'>;

function createUserId(id: string): UserId {
  // Validation logic
  if (!id.match(/^user-[0-9a-f]{8}$/)) {
    throw new Error('Invalid user ID format');
  }
  return id as UserId;
}

function createEmail(email: string): Email {
  if (!email.includes('@')) {
    throw new Error('Invalid email format');
  }
  return email as Email;
}

// Type-safe IDs prevent mixing
function fetchUser(id: UserId): Promise<User> {
  // Implementation
}

// This would cause a type error:
// const productId: ProductId = '...' as ProductId;
// fetchUser(productId); // Type error!

// Discriminated Unions (Tagged Unions)
type Result<T, E = Error> =
  | { success: true; data: T }
  | { success: false; error: E };

function handleResult<T>(result: Result<T>) {
  if (result.success) {
    console.log('Data:', result.data); // TypeScript knows result.data exists
  } else {
    console.error('Error:', result.error); // TypeScript knows result.error exists
  }
}

// Advanced Discriminated Union
type ApiResponse<T> =
  | { status: 'loading' }
  | { status: 'success'; data: T }
  | { status: 'error'; error: string; code: number }
  | { status: 'idle' };

function renderApiResponse<T>(response: ApiResponse<T>) {
  switch (response.status) {
    case 'loading':
      return 'Loading...';
    case 'success':
      return JSON.stringify(response.data);
    case 'error':
      return `Error ${response.code}: ${response.error}`;
    case 'idle':
      return 'No data yet';
  }
}

// Conditional Types
type IsArray<T> = T extends any[] ? true : false;
type IsFunction<T> = T extends (...args: any[]) => any ? true : false;

type UnwrapPromise<T> = T extends Promise<infer U> ? U : T;
type UnwrapArray<T> = T extends Array<infer U> ? U : T;

// Example usage
type A = UnwrapPromise<Promise<string>>; // string
type B = UnwrapPromise<string>; // string
type C = UnwrapArray<string[]>; // string

// Mapped Types
type Readonly<T> = {
  readonly [P in keyof T]: T[P];
};

type Mutable<T> = {
  -readonly [P in keyof T]: T[P];
};

type RequiredFields<T, K extends keyof T> = T & {
  [P in K]-?: T[P];
};

// Template Literal Types
type HttpMethod = 'GET' | 'POST' | 'PUT' | 'DELETE';
type ApiRoute = '/users' | '/products' | '/orders';
type ApiEndpoint = `${HttpMethod} ${ApiRoute}`;

// Example: 'GET /users', 'POST /products', etc.

// More complex template literals
type EventName = 'click' | 'focus' | 'blur';
type ElementType = 'button' | 'input' | 'div';
type EventHandler = `on${Capitalize<EventName>}${Capitalize<ElementType>}`;

// Example: 'onClickButton', 'onFocusInput', etc.

// Recursive Types
type Json =
  | string
  | number
  | boolean
  | null
  | Json[]
  | { [key: string]: Json };

type NestedObject<T> = {
  [K in keyof T]: T[K] | NestedObject<T[K]>;
};

// Infer Keyword
type ReturnType<T> = T extends (...args: any[]) => infer R ? R : never;
type Parameters<T> = T extends (...args: infer P) => any ? P : never;

function exampleFunction(a: string, b: number): boolean {
  return true;
}

type ExampleReturn = ReturnType<typeof exampleFunction>; // boolean
type ExampleParams = Parameters<typeof exampleFunction>; // [string, number]
```

### 5.2 Advanced Patterns for Enterprise Applications

**1. Builder Pattern with Type Safety:**

```typescript
// patterns/Builder.ts

interface UserConfig {
  id: string;
  email: string;
  firstName: string;
  lastName: string;
  age?: number;
  address?: {
    street: string;
    city: string;
    country: string;
  };
  preferences?: {
    newsletter: boolean;
    notifications: boolean;
  };
}

// Builder with required fields tracking
type RequiredKeys = 'id' | 'email' | 'firstName' | 'lastName';
type OptionalKeys = Exclude<keyof UserConfig, RequiredKeys>;

class UserBuilder {
  private config: Partial<UserConfig> = {};

  id(id: string): this {
    this.config.id = id;
    return this;
  }

  email(email: string): this {
    this.config.email = email;
    return this;
  }

  firstName(firstName: string): this {
    this.config.firstName = firstName;
    return this;
  }

  lastName(lastName: string): this {
    this.config.lastName = lastName;
    return this;
  }

  age(age: number): this {
    this.config.age = age;
    return this;
  }

  address(address: UserConfig['address']): this {
    this.config.address = address;
    return this;
  }

  preferences(preferences: UserConfig['preferences']): this {
    this.config.preferences = preferences;
    return this;
  }

  build(): UserConfig {
    const requiredFields: RequiredKeys[] = ['id', 'email', 'firstName', 'lastName'];

    for (const field of requiredFields) {
      if (!this.config[field]) {
        throw new Error(`Required field "${field}" is missing`);
      }
    }

    return this.config as UserConfig;
  }
}

// Usage
const user = new UserBuilder()
  .id('user-123')
  .email('john@example.com')
  .firstName('John')
  .lastName('Doe')
  .age(30)
  .preferences({ newsletter: true, notifications: false })
  .build();
```

**2. Repository Pattern with Generics:**

```typescript
// patterns/Repository.ts

interface Entity {
  id: string;
  createdAt: Date;
  updatedAt: Date;
}

interface QueryOptions<T> {
  where?: Partial<T>;
  orderBy?: {
    field: keyof T;
    direction: 'asc' | 'desc';
  };
  limit?: number;
  offset?: number;
}

interface Repository<T extends Entity> {
  findById(id: string): Promise<T | null>;
  findAll(options?: QueryOptions<T>): Promise<T[]>;
  create(data: Omit<T, 'id' | 'createdAt' | 'updatedAt'>): Promise<T>;
  update(id: string, data: Partial<Omit<T, 'id' | 'createdAt' | 'updatedAt'>>): Promise<T>;
  delete(id: string): Promise<void>;
}

// Generic implementation
class BaseRepository<T extends Entity> implements Repository<T> {
  constructor(
    private apiClient: APIClient,
    private endpoint: string
  ) {}

  async findById(id: string): Promise<T | null> {
    try {
      const response = await this.apiClient.get<T>(`${this.endpoint}/${id}`);
      return response;
    } catch (error) {
      if (error.status === 404) {
        return null;
      }
      throw error;
    }
  }

  async findAll(options?: QueryOptions<T>): Promise<T[]> {
    const queryParams = this.buildQueryParams(options);
    return this.apiClient.get<T[]>(`${this.endpoint}?${queryParams}`);
  }

  async create(data: Omit<T, 'id' | 'createdAt' | 'updatedAt'>): Promise<T> {
    return this.apiClient.post<T>(this.endpoint, data);
  }

  async update(
    id: string,
    data: Partial<Omit<T, 'id' | 'createdAt' | 'updatedAt'>>
  ): Promise<T> {
    return this.apiClient.put<T>(`${this.endpoint}/${id}`, data);
  }

  async delete(id: string): Promise<void> {
    await this.apiClient.delete(`${this.endpoint}/${id}`);
  }

  private buildQueryParams(options?: QueryOptions<T>): string {
    if (!options) return '';

    const params = new URLSearchParams();

    if (options.where) {
      Object.entries(options.where).forEach(([key, value]) => {
        params.append(key, String(value));
      });
    }

    if (options.orderBy) {
      params.append('orderBy', String(options.orderBy.field));
      params.append('direction', options.orderBy.direction);
    }

    if (options.limit) {
      params.append('limit', String(options.limit));
    }

    if (options.offset) {
      params.append('offset', String(options.offset));
    }

    return params.toString();
  }
}

// Specific entity
interface User extends Entity {
  email: string;
  firstName: string;
  lastName: string;
  role: 'admin' | 'user' | 'guest';
}

// Specific repository with additional methods
class UserRepository extends BaseRepository<User> {
  constructor(apiClient: APIClient) {
    super(apiClient, '/api/users');
  }

  async findByEmail(email: string): Promise<User | null> {
    const users = await this.findAll({ where: { email } as Partial<User> });
    return users[0] || null;
  }

  async findAdmins(): Promise<User[]> {
    return this.findAll({ where: { role: 'admin' } as Partial<User> });
  }
}

// Usage
const userRepo = new UserRepository(apiClient);

const user = await userRepo.findById('user-123');
const admins = await userRepo.findAdmins();
const john = await userRepo.findByEmail('john@example.com');
```

**3. Dependency Injection Pattern:**

```typescript
// patterns/DependencyInjection.ts

// Service interfaces
interface ILogger {
  log(message: string): void;
  error(message: string, error?: Error): void;
}

interface ICache {
  get<T>(key: string): Promise<T | null>;
  set<T>(key: string, value: T, ttl?: number): Promise<void>;
  delete(key: string): Promise<void>;
}

interface IApiClient {
  get<T>(url: string): Promise<T>;
  post<T>(url: string, data: any): Promise<T>;
}

// Implementations
class ConsoleLogger implements ILogger {
  log(message: string): void {
    console.log(`[LOG] ${new Date().toISOString()} - ${message}`);
  }

  error(message: string, error?: Error): void {
    console.error(`[ERROR] ${new Date().toISOString()} - ${message}`, error);
  }
}

class RedisCache implements ICache {
  async get<T>(key: string): Promise<T | null> {
    // Redis implementation
    return null;
  }

  async set<T>(key: string, value: T, ttl?: number): Promise<void> {
    // Redis implementation
  }

  async delete(key: string): Promise<void> {
    // Redis implementation
  }
}

// Dependency Injection Container
type Constructor<T = any> = new (...args: any[]) => T;
type Factory<T = any> = () => T;

enum Lifecycle {
  Singleton,
  Transient
}

interface Registration<T> {
  factory: Factory<T>;
  lifecycle: Lifecycle;
  instance?: T;
}

class Container {
  private registrations = new Map<string, Registration<any>>();

  register<T>(
    token: string | Constructor<T>,
    factory: Factory<T>,
    lifecycle: Lifecycle = Lifecycle.Singleton
  ): void {
    const key = typeof token === 'string' ? token : token.name;
    this.registrations.set(key, { factory, lifecycle });
  }

  registerSingleton<T>(token: string | Constructor<T>, factory: Factory<T>): void {
    this.register(token, factory, Lifecycle.Singleton);
  }

  registerTransient<T>(token: string | Constructor<T>, factory: Factory<T>): void {
    this.register(token, factory, Lifecycle.Transient);
  }

  resolve<T>(token: string | Constructor<T>): T {
    const key = typeof token === 'string' ? token : token.name;
    const registration = this.registrations.get(key);

    if (!registration) {
      throw new Error(`No registration found for "${key}"`);
    }

    if (registration.lifecycle === Lifecycle.Singleton) {
      if (!registration.instance) {
        registration.instance = registration.factory();
      }
      return registration.instance;
    }

    return registration.factory();
  }
}

// Setup container
const container = new Container();

container.registerSingleton<ILogger>('ILogger', () => new ConsoleLogger());
container.registerSingleton<ICache>('ICache', () => new RedisCache());

// Service using dependencies
class UserService {
  constructor(
    private logger: ILogger,
    private cache: ICache,
    private apiClient: IApiClient
  ) {}

  async getUser(id: string): Promise<User> {
    this.logger.log(`Fetching user ${id}`);

    // Check cache
    const cached = await this.cache.get<User>(`user:${id}`);
    if (cached) {
      this.logger.log(`User ${id} found in cache`);
      return cached;
    }

    // Fetch from API
    try {
      const user = await this.apiClient.get<User>(`/api/users/${id}`);
      await this.cache.set(`user:${id}`, user, 3600);
      return user;
    } catch (error) {
      this.logger.error(`Failed to fetch user ${id}`, error);
      throw error;
    }
  }
}

// Resolve dependencies
const userService = new UserService(
  container.resolve<ILogger>('ILogger'),
  container.resolve<ICache>('ICache'),
  container.resolve<IApiClient>('IApiClient')
);
```

**4. Type-Safe Event Emitter:**

```typescript
// patterns/TypeSafeEventEmitter.ts

type EventMap = Record<string, any>;

type EventKey<T extends EventMap> = string & keyof T;
type EventHandler<T = any> = (payload: T) => void;

class TypedEventEmitter<T extends EventMap> {
  private listeners: {
    [K in keyof T]?: Set<EventHandler<T[K]>>;
  } = {};

  on<K extends EventKey<T>>(event: K, handler: EventHandler<T[K]>): () => void {
    if (!this.listeners[event]) {
      this.listeners[event] = new Set();
    }

    this.listeners[event]!.add(handler);

    // Return unsubscribe function
    return () => {
      this.listeners[event]?.delete(handler);
    };
  }

  once<K extends EventKey<T>>(event: K, handler: EventHandler<T[K]>): void {
    const wrappedHandler = (payload: T[K]) => {
      handler(payload);
      this.off(event, wrappedHandler);
    };

    this.on(event, wrappedHandler);
  }

  off<K extends EventKey<T>>(event: K, handler: EventHandler<T[K]>): void {
    this.listeners[event]?.delete(handler);
  }

  emit<K extends EventKey<T>>(event: K, payload: T[K]): void {
    this.listeners[event]?.forEach(handler => {
      try {
        handler(payload);
      } catch (error) {
        console.error(`Error in event handler for "${String(event)}":`, error);
      }
    });
  }

  removeAllListeners<K extends EventKey<T>>(event?: K): void {
    if (event) {
      this.listeners[event] = new Set();
    } else {
      this.listeners = {};
    }
  }
}

// Define event types
interface AppEvents {
  'user:login': { userId: string; timestamp: Date };
  'user:logout': { userId: string };
  'product:addedToCart': { productId: string; quantity: number };
  'order:created': { orderId: string; total: number };
}

// Usage
const emitter = new TypedEventEmitter<AppEvents>();

// Type-safe event subscription
emitter.on('user:login', (data) => {
  console.log(`User ${data.userId} logged in at ${data.timestamp}`);
  // data is fully typed!
});

// Type-safe event emission
emitter.emit('user:login', {
  userId: 'user-123',
  timestamp: new Date()
});

// This would cause a type error:
// emitter.emit('user:login', { userId: 123 }); // Error: userId must be string
```

**5. Async State Machine:**

```typescript
// patterns/StateMachine.ts

type StateMachine<TState extends string, TEvent extends string, TContext = any> = {
  initial: TState;
  states: {
    [K in TState]: {
      on?: {
        [E in TEvent]?: {
          target: TState;
          guard?: (context: TContext, event: { type: E; data?: any }) => boolean;
          action?: (context: TContext, event: { type: E; data?: any }) => TContext;
        };
      };
      onEnter?: (context: TContext) => void | Promise<void>;
      onExit?: (context: TContext) => void | Promise<void>;
    };
  };
};

class StateMachineRunner<
  TState extends string,
  TEvent extends string,
  TContext = any
> {
  private currentState: TState;
  private context: TContext;

  constructor(
    private machine: StateMachine<TState, TEvent, TContext>,
    initialContext: TContext
  ) {
    this.currentState = machine.initial;
    this.context = initialContext;
  }

  getCurrentState(): TState {
    return this.currentState;
  }

  getContext(): TContext {
    return this.context;
  }

  async send(event: { type: TEvent; data?: any }): Promise<void> {
    const currentStateConfig = this.machine.states[this.currentState];
    const transition = currentStateConfig.on?.[event.type];

    if (!transition) {
      console.warn(
        `No transition defined for event "${event.type}" in state "${this.currentState}"`
      );
      return;
    }

    // Check guard
    if (transition.guard && !transition.guard(this.context, event)) {
      console.log('Transition guard failed');
      return;
    }

    // Execute exit action
    if (currentStateConfig.onExit) {
      await currentStateConfig.onExit(this.context);
    }

    // Execute transition action
    if (transition.action) {
      this.context = transition.action(this.context, event);
    }

    // Transition to new state
    const previousState = this.currentState;
    this.currentState = transition.target;

    console.log(`State transition: ${previousState} → ${this.currentState}`);

    // Execute enter action
    const newStateConfig = this.machine.states[this.currentState];
    if (newStateConfig.onEnter) {
      await newStateConfig.onEnter(this.context);
    }
  }
}

// Example: Order state machine
type OrderState = 'idle' | 'loading' | 'success' | 'error';
type OrderEvent = 'FETCH' | 'RESOLVE' | 'REJECT' | 'RETRY';

interface OrderContext {
  order: Order | null;
  error: string | null;
  retryCount: number;
}

const orderMachine: StateMachine<OrderState, OrderEvent, OrderContext> = {
  initial: 'idle',
  states: {
    idle: {
      on: {
        FETCH: {
          target: 'loading',
          action: (context) => ({ ...context, error: null })
        }
      }
    },
    loading: {
      on: {
        RESOLVE: {
          target: 'success',
          action: (context, event) => ({
            ...context,
            order: event.data,
            retryCount: 0
          })
        },
        REJECT: {
          target: 'error',
          action: (context, event) => ({
            ...context,
            error: event.data
          })
        }
      },
      onEnter: async (context) => {
        console.log('Fetching order...');
      }
    },
    success: {
      on: {
        FETCH: {
          target: 'loading'
        }
      }
    },
    error: {
      on: {
        RETRY: {
          target: 'loading',
          guard: (context) => context.retryCount < 3,
          action: (context) => ({
            ...context,
            retryCount: context.retryCount + 1
          })
        },
        FETCH: {
          target: 'loading',
          action: (context) => ({
            ...context,
            retryCount: 0
          })
        }
      }
    }
  }
};

// Usage
const orderStateMachine = new StateMachineRunner(orderMachine, {
  order: null,
  error: null,
  retryCount: 0
});

await orderStateMachine.send({ type: 'FETCH' });
await orderStateMachine.send({ type: 'RESOLVE', data: { id: '123' } });

console.log(orderStateMachine.getContext()); // { order: { id: '123' }, ... }
```

### 5.3 TypeScript Enterprise Best Practices

**Configuration:**

```json
// tsconfig.json - Strict Enterprise Configuration
{
  "compilerOptions": {
    // Language and Environment
    "target": "ES2022",
    "lib": ["ES2022", "DOM", "DOM.Iterable"],
    "jsx": "react-jsx",

    // Modules
    "module": "ESNext",
    "moduleResolution": "node",
    "resolveJsonModule": true,

    // Emit
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "outDir": "./dist",
    "removeComments": true,
    "importHelpers": true,

    // Interop Constraints
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "forceConsistentCasingInFileNames": true,
    "isolatedModules": true,

    // Type Checking (Strict Mode)
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "strictBindCallApply": true,
    "strictPropertyInitialization": true,
    "noImplicitThis": true,
    "alwaysStrict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true,

    // Advanced
    "skipLibCheck": true,
    "allowUnreachableCode": false,
    "allowUnusedLabels": false,

    // Path Mapping
    "baseUrl": "./src",
    "paths": {
      "@components/*": ["components/*"],
      "@utils/*": ["utils/*"],
      "@types/*": ["types/*"],
      "@api/*": ["api/*"]
    }
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.spec.ts"]
}
```

**Key Enterprise TypeScript Practices:**

1. **Strict Mode Always**: Enable all strict type-checking options
2. **No Any**: Avoid `any` type; use `unknown` when type is truly unknown
3. **Explicit Return Types**: Always specify function return types
4. **Branded Types**: Use for IDs and special strings to prevent mixing
5. **Discriminated Unions**: Model state machines and API responses
6. **Utility Types**: Leverage built-in utility types (Partial, Required, etc.)
7. **Type Guards**: Implement type guards for runtime type checking
8. **Const Assertions**: Use `as const` for literal types
9. **Template Literals**: Use for type-safe string patterns
10. **Generics**: Write reusable, type-safe abstractions

---

## Conclusion

This comprehensive analysis covers enterprise-level frontend development practices across five critical domains:

1. **Web APIs & PWAs**: Service Workers, IndexedDB, offline-first architectures
2. **Security**: CORS, XSS, CSRF protection with production-ready implementations
3. **SSR/SSG**: Next.js enterprise patterns, caching strategies, performance optimization
4. **Microservices**: Micro-frontends architecture with Module Federation, shared state
5. **TypeScript**: Advanced patterns including DI, state machines, type-safe abstractions

---

**Document Version**: 1.0
**Last Updated**: November 2025
**Based on**: Enterprise frontend development best practices and advanced architectural patterns

These patterns and practices form the foundation of scalable, secure, and maintainable enterprise frontend applications.

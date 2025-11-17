# Skill: Vite - Modern Bundling

**Level:** Core
**Duration:** 1 week
**Agent:** Build Tools
**Prerequisites:** Package Managers skill

## Overview
Master Vite, the next-generation build tool. Experience blazing-fast development with Near-instant HMR and modern ES module approach.

## Key Topics

- Native ES modules in development
- Rollup for production builds
- Hot Module Replacement (HMR)
- Plugin system
- Framework integration
- Optimization strategies

## Learning Objectives

- Create Vite projects
- Configure vite.config.js
- Use framework plugins
- Implement code splitting
- Optimize production builds
- Measure performance gains

## Practical Exercises

### Initialize project
```bash
npm create vite@latest my-app -- --template react
cd my-app
npm install
npm run dev
```

### Configure vite.config.js
```javascript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  build: {
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['react', 'react-dom']
        }
      }
    }
  }
})
```

## Resources

- [Vite Docs](https://vitejs.dev/)
- [Vite Plugins](https://vitejs.dev/plugins/)

---
**Status:** Active | **Version:** 1.0.0

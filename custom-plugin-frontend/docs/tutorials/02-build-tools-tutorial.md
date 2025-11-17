# 📦 Build Tools & Package Management Tutorial

**Agent 2 - Package Managers & Build Tools**
*Duration: 3-4 weeks | Level: Intermediate*

---

## 📚 Table of Contents

- [Week 1: Package Managers Mastery](#week-1-package-managers-mastery)
- [Week 2: Webpack Deep Dive](#week-2-webpack-deep-dive)
- [Week 3: Vite & Modern Bundling](#week-3-vite--modern-bundling)
- [Week 4: Advanced Bundling](#week-4-advanced-bundling)
- [Projects & Assessment](#projects--assessment)

---

## Week 1: Package Managers Mastery

### 🎯 Learning Objectives
- Understand npm, Yarn, and pnpm ecosystems
- Master dependency management and versioning
- Learn lock files and reproducible builds
- Optimize package installation performance
- Work with monorepos and workspaces

### 📖 Key Concepts

#### Package Manager Architecture

```
┌─────────────────────────────────────┐
│   Package Manager CLI               │
│   (npm / yarn / pnpm)               │
└─────────────────┬───────────────────┘
                  │
        ┌─────────┴────────┐
        ▼                  ▼
    Registry         Lock File
   (npmjs.com)    (package-lock.json)
        │                  │
        └─────────┬────────┘
                  ▼
        node_modules/
```

#### npm vs Yarn vs pnpm Comparison

| Feature | npm | Yarn | pnpm |
|---------|-----|------|------|
| Speed | Medium | Fast | Very Fast |
| Lock File | package-lock.json | yarn.lock | pnpm-lock.yaml |
| Monorepo Support | Workspaces | Workspaces | Native Workspaces |
| Disk Usage | Duplicated | Optimized | Optimized (links) |
| Version | 10+ (built-in npm 8+) | 4.x | 8.x |
| Production Ready | Yes | Yes | Yes |

### 💻 Hands-On Exercises

**Exercise 1: Package Manager Setup**
```bash
# npm (built-in with Node)
npm init -y
npm install lodash
npm install --save-dev webpack

# Yarn 4+ installation
npm install -g yarn
yarn init -y
yarn add lodash
yarn add --dev webpack

# pnpm installation (fastest)
npm install -g pnpm
pnpm init -y
pnpm add lodash
pnpm add --save-dev webpack
```

**Exercise 2: Semantic Versioning**
```json
{
  "dependencies": {
    "lodash": "^4.17.21",     // >=4.17.21, <5.0.0
    "axios": "~1.4.0",         // >=1.4.0, <1.5.0
    "react": "18.2.0"          // exact version
  },
  "devDependencies": {
    "webpack": "5.x",          // latest 5.x
    "typescript": ">=5.0"      // 5.0 or higher
  }
}
```

**Exercise 3: Lock File Management**
```bash
# Generate lock file
npm install

# Update specific package
npm update lodash

# Audit dependencies
npm audit
npm audit fix

# Check for outdated packages
npm outdated
```

### 🏗️ Mini Project: Package.json Optimizer
**Build a tool that:**
- Analyzes package.json for outdated dependencies
- Identifies unused dependencies
- Suggests version optimizations
- Reports security vulnerabilities
- Generates dependency graph visualization

---

## Week 2: Webpack Deep Dive

### 🎯 Learning Objectives
- Configure Webpack from scratch
- Master loaders and plugins
- Implement code splitting strategies
- Optimize bundle size
- Set up development and production builds

### ⚙️ Webpack Configuration Basics

```javascript
// webpack.config.js
const path = require('path');
const HtmlPlugin = require('html-webpack-plugin');
const TerserPlugin = require('terser-webpack-plugin');

module.exports = {
  mode: 'production',

  entry: './src/index.js',

  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: '[name].[contenthash].js',
    chunkFilename: '[name].[contenthash].js',
    clean: true,
  },

  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-react', '@babel/preset-typescript'],
          },
        },
      },
      {
        test: /\.css$/,
        use: ['style-loader', 'postcss-loader', 'css-loader'],
      },
      {
        test: /\.(png|jpg|gif|svg)$/,
        type: 'asset',
        parser: { dataUrlCondition: { maxSize: 8 * 1024 } },
      },
    ],
  },

  plugins: [
    new HtmlPlugin({
      template: './public/index.html',
      minify: {
        collapseWhitespace: true,
        removeComments: true,
      },
    }),
  ],

  optimization: {
    minimize: true,
    minimizer: [new TerserPlugin()],
    splitChunks: {
      chunks: 'all',
      cacheGroups: {
        vendor: {
          test: /[\\/]node_modules[\\/]/,
          name: 'vendors',
          priority: 10,
        },
        common: {
          minChunks: 2,
          priority: 5,
          reuseExistingChunk: true,
        },
      },
    },
    runtimeChunk: 'single',
  },

  devtool: 'source-map',

  devServer: {
    port: 3000,
    hot: true,
    compress: true,
  },
};
```

### 🔧 Loaders and Plugins

#### Essential Loaders
```javascript
// Babel loader - transpile JavaScript
{
  test: /\.jsx?$/,
  use: 'babel-loader',
}

// Style loaders - handle CSS
{
  test: /\.css$/,
  use: ['style-loader', 'css-loader', 'postcss-loader'],
}

// File loader - handle assets
{
  test: /\.(png|jpg|svg|gif)$/,
  type: 'asset/resource',
}

// TypeScript loader
{
  test: /\.tsx?$/,
  use: 'ts-loader',
}
```

#### Essential Plugins
```javascript
const plugins = [
  // Generate HTML file
  new HtmlWebpackPlugin({
    template: './public/index.html',
  }),

  // Extract CSS to separate file
  new MiniCssExtractPlugin({
    filename: '[name].[contenthash].css',
  }),

  // Define environment variables
  new webpack.DefinePlugin({
    'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV),
  }),

  // Analyze bundle size
  new BundleAnalyzerPlugin(),
];
```

### 📊 Code Splitting Strategies

```javascript
// 1. Entry points
entry: {
  app: './src/app.js',
  admin: './src/admin.js',
  login: './src/login.js',
},

// 2. Dynamic imports
import(/* webpackChunkName: "admin" */ './pages/admin')
  .then(module => module.default())

// 3. Vendor splitting
splitChunks: {
  cacheGroups: {
    vendor: {
      test: /[\\/]node_modules[\\/]/,
      name: 'vendors',
    },
  },
},

// 4. Lazy route loading (React Router)
const Dashboard = lazy(() => import('./pages/Dashboard'));
```

### 💻 Practice Projects

1. **Build a multi-page Webpack setup**
   - Separate entry for each page
   - Shared vendor bundle
   - CSS extraction
   - Image optimization

2. **Implement code splitting**
   - Route-based splitting
   - Component lazy loading
   - Vendor isolation

3. **Bundle analysis**
   - Use webpack-bundle-analyzer
   - Identify large dependencies
   - Optimize imports

---

## Week 3: Vite & Modern Bundling

### 🎯 Learning Objectives
- Understand Vite's ES modules approach
- Configure Vite for different frameworks
- Leverage Vite plugins
- Master hot module replacement (HMR)
- Optimize Vite builds

### ⚡ Vite Configuration

```javascript
// vite.config.js
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import vue from '@vitejs/plugin-vue';
import { resolve } from 'path';

export default defineConfig({
  plugins: [react(), vue()],

  server: {
    port: 5173,
    open: true,
    proxy: {
      '/api': {
        target: 'http://localhost:3000',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ''),
      },
    },
  },

  build: {
    target: 'esnext',
    outDir: 'dist',
    minify: 'terser',
    sourcemap: true,
    rollupOptions: {
      output: {
        manualChunks: {
          'react-vendor': ['react', 'react-dom'],
          'ui-vendor': ['@mui/material'],
        },
      },
    },
  },

  resolve: {
    alias: {
      '@': resolve(__dirname, './src'),
      '@components': resolve(__dirname, './src/components'),
      '@utils': resolve(__dirname, './src/utils'),
    },
  },

  optimizeDeps: {
    include: ['react', 'react-dom'],
    exclude: ['some-large-library'],
  },
});
```

### 🔥 Vite vs Webpack Comparison

| Aspect | Vite | Webpack |
|--------|------|---------|
| Dev Start | <100ms | 5000+ ms |
| HMR | Instant | Several seconds |
| Learning Curve | Easy | Steep |
| Flexibility | Limited | Highly configurable |
| Plugin System | Growing | Mature |
| Ecosystem | Young, growing | Mature |
| Best For | Modern SPAs | Complex setups |

### 🎨 Vite Plugins

```javascript
// Custom plugin example
export default function myPlugin(options = {}) {
  return {
    name: 'my-plugin', // required, used as prefix

    // Vite hooks
    resolveId(id) {
      if (id === 'virtual-module') {
        return id;
      }
    },

    load(id) {
      if (id === 'virtual-module') {
        return `export const msg = "from virtual module"`;
      }
    },

    // Rollup hooks
    transform(code, id) {
      if (id.endsWith('.custom')) {
        return {
          code: transformedCode,
          map: null,
        };
      }
    },

    // Vite-specific hooks
    configResolved(resolvedConfig) {
      this.config = resolvedConfig;
    },

    transformIndexHtml(html) {
      return html.replace(
        /<title>(.*?)<\/title>/,
        `<title>Modified - $1</title>`
      );
    },
  };
}
```

### 💻 Mini Projects

1. **Build a Vite + React SPA**
   - Multiple routes with code splitting
   - Environment configuration
   - API proxy setup

2. **Create a Vite plugin**
   - Auto-import components
   - Transform markdown files
   - Virtual modules

---

## Week 4: Advanced Bundling

### 🎯 Learning Objectives
- Optimize bundle size and performance
- Implement tree-shaking effectively
- Master monorepo bundling strategies
- Handle dynamic imports and lazy loading
- Profile and analyze bundles

### 📊 Bundle Optimization Strategies

```javascript
// 1. Tree-shaking enabled
// package.json
{
  "sideEffects": false, // or ["src/index.css"]
  "exports": {
    ".": {
      "import": "./dist/index.es.js",
      "require": "./dist/index.cjs.js",
    },
  },
}

// 2. Code splitting strategy
export default {
  build: {
    rollupOptions: {
      output: {
        manualChunks: (id) => {
          if (id.includes('node_modules')) {
            if (id.includes('react')) return 'react-vendor';
            if (id.includes('lodash')) return 'lodash';
            return 'vendor';
          }
        },
      },
    },
  },
};

// 3. Dynamic import with prefetch
<link rel="prefetch" href="/path/to/chunk.js" />
import(/* webpackPrefetch: true */ './module')

// 4. Asset optimization
{
  test: /\.(png|jpg|jpeg|gif)$/i,
  type: 'asset',
  parser: {
    dataUrlCondition: {
      maxSize: 10 * 1024, // 10kb
    },
  },
  generator: {
    filename: 'images/[name].[hash][ext]',
  },
}
```

### 🔍 Bundle Analysis Tools

```bash
# webpack-bundle-analyzer
npm install --save-dev webpack-bundle-analyzer

# Then in webpack.config.js:
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer')
  .BundleAnalyzerPlugin;

plugins: [
  new BundleAnalyzerPlugin(),
];

# rollup visualizer (for Vite)
npm install --save-dev rollup-plugin-visualizer

# vite.config.js
import { visualizer } from 'rollup-plugin-visualizer';

plugins: [visualizer()],
```

### 📦 Monorepo Bundling with Workspaces

```javascript
// Root package.json
{
  "name": "monorepo",
  "private": true,
  "workspaces": [
    "packages/*"
  ]
}

// packages/ui/package.json
{
  "name": "@monorepo/ui",
  "main": "dist/index.js",
  "exports": {
    ".": "./dist/index.js",
    "./Button": "./dist/Button.js"
  }
}

// Building with pnpm workspaces
pnpm --filter "./packages/**" build
pnpm --filter @monorepo/ui build
```

### 💻 Advanced Projects

1. **Performance-optimized e-commerce site**
   - Route-based code splitting
   - Image lazy loading and optimization
   - Bundle size monitoring
   - Performance budgets

2. **Component library bundling**
   - Multiple entry points
   - Tree-shakeable exports
   - TypeScript definitions
   - Documentation generation

3. **Monorepo setup**
   - Shared components package
   - API client library
   - Utils package
   - Cross-package dependencies

---

## 📊 Projects & Assessment

### Capstone Project: Build Tool Configuration

**Requirements:**
- ✅ Webpack configuration with optimization
- ✅ Vite configuration for fast dev
- ✅ Code splitting strategy implemented
- ✅ Bundle analysis and optimization
- ✅ Both development and production builds
- ✅ Git history with meaningful commits
- ✅ Performance benchmarks documented

**Grading Rubric:**
| Criteria | Points | Notes |
|----------|--------|-------|
| Webpack Config | 20 | Proper loaders, plugins, optimization |
| Vite Setup | 20 | Fast HMR, alias, proxy configuration |
| Code Splitting | 20 | Route-based, vendor separation |
| Optimization | 20 | Bundle size, tree-shaking, lazy loading |
| Documentation | 15 | Setup guide, performance metrics |
| Git Usage | 5 | Clean commits |

### Assessment Checklist

- [ ] Webpack builds without errors
- [ ] Vite dev server starts instantly
- [ ] Code splitting creates expected chunks
- [ ] Bundle size under performance budget
- [ ] All dependencies properly handled
- [ ] Source maps work in development
- [ ] Production build is minified
- [ ] No unused dependencies
- [ ] Tree-shaking working correctly
- [ ] README explains build setup

---

## 🎓 Next Steps

After mastering Build Tools, continue with:

1. **Frameworks Agent** - Master React, Vue, Angular, or Svelte
2. **State Management Agent** - Redux, Context, Zustand patterns
3. **Advanced Topics** - TypeScript, SSR, PWAs

---

## 📚 Resources

### Official Documentation
- [npm Docs](https://docs.npmjs.com/)
- [Webpack Official](https://webpack.js.org/)
- [Vite Official](https://vitejs.dev/)
- [pnpm Docs](https://pnpm.io/)

### Learning Platforms
- [Webpack Academy](https://webpack.academy/)
- [Vite Documentation](https://vitejs.dev/guide/)
- [Frontend Masters](https://frontendmasters.com/)

### Tools
- [webpack-bundle-analyzer](https://github.com/webpack-bundle-analyzer/webpack-bundle-analyzer)
- [rollup-plugin-visualizer](https://github.com/btd/rollup-plugin-visualizer)
- [Bundle Phobia](https://bundlephobia.com/)

---

**Last Updated:** November 2024 | **Version:** 1.0.0

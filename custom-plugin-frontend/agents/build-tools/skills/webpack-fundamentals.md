# Skill: Webpack Fundamentals

**Level:** Core
**Duration:** 1 week
**Agent:** Build Tools
**Prerequisites:** Package Managers skill

## Overview
Master Webpack, the industry-standard module bundler. Learn configuration, loaders, plugins, and optimization techniques.

## Key Topics

- Entry points and outputs
- Loaders for transformations
- Plugins for advanced features
- Code splitting strategies
- Development vs production
- Source maps and debugging

## Learning Objectives

- Create webpack.config.js
- Configure loaders
- Set up plugins
- Implement code splitting
- Optimize bundle size
- Debug with DevTools

## Practical Exercises

### Basic configuration
```javascript
module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),
  },
  mode: 'development',
};
```

### Add loaders
```javascript
module: {
  rules: [
    {
      test: /\.jsx?$/,
      use: 'babel-loader'
    },
    {
      test: /\.css$/,
      use: ['style-loader', 'css-loader']
    }
  ]
}
```

## Resources

- [Webpack Docs](https://webpack.js.org/)
- [Webpack Guides](https://webpack.js.org/guides/)

---
**Status:** Active | **Version:** 1.0.0

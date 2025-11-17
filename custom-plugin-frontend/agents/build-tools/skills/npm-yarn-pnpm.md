# Skill: Package Managers (NPM, Yarn, PNPM)

**Level:** Core
**Duration:** 1 week
**Agent:** Build Tools
**Prerequisites:** Fundamentals Agent

## Overview
Master modern package managers for managing dependencies and automating tasks. Learn NPM, Yarn, and PNPM to choose the right tool for your project.

## Key Topics

- Package installation and versioning
- lock files and deterministic installs
- npm scripts and task automation
- Workspace and monorepo management
- Security auditing
- Package publishing

## Learning Objectives

- Install and update dependencies
- Create and maintain package.json
- Write effective npm scripts
- Understand semantic versioning
- Work with dev vs production dependencies
- Audit and fix security vulnerabilities

## Practical Exercises

### Install dependencies
```bash
npm install package-name
npm install --save-dev package-name
npm update
```

### Create and run scripts
```json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "test": "vitest",
    "lint": "eslint src"
  }
}
```

### Manage monorepos (Yarn/pnpm)
```bash
yarn workspaces add -W package-name
pnpm add -w package-name
```

## Real-World Projects

- Create npm package
- Set up monorepo
- Configure workspaces

## Resources

- [NPM Docs](https://docs.npmjs.com/)
- [Yarn Docs](https://yarnpkg.com/)
- [PNPM Docs](https://pnpm.io/)

---
**Status:** Active | **Version:** 1.0.0

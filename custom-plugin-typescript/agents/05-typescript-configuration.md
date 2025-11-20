# TypeScript Configuration Agent

## Role
TypeScript configuration expert specializing in tsconfig.json, compiler options, project references, build optimization, and tooling integration.

## Expertise
- tsconfig.json structure and inheritance
- Compiler options (strict mode, module resolution, target)
- Project references and composite projects
- Path mapping and module aliases
- Declaration file generation
- Source maps and debugging
- Build performance optimization
- Integration with bundlers and tools

## Approach
You teach how to configure TypeScript for different project types, from simple scripts to monorepos with multiple packages.

## Key Principles
1. **Strict by Default**: Always enable strict mode for maximum safety
2. **Incremental Adoption**: Configure for gradual migration from JavaScript
3. **Performance Matters**: Optimize compilation for faster builds
4. **Tool Integration**: Configure for seamless IDE and bundler support

## Teaching Method

### Basic Configuration
```json
{
  "compilerOptions": {
    // Language and Environment
    "target": "ES2022",
    "lib": ["ES2022", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "moduleResolution": "bundler",

    // Type Checking
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "noImplicitReturns": true,

    // Emit
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "outDir": "./dist",
    "removeComments": false,

    // Interop Constraints
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "allowSyntheticDefaultImports": true,

    // Skip Lib Check
    "skipLibCheck": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.spec.ts"]
}
```

## Learning Progression

### Level 1: Essential Options (Week 1)
```json
{
  "compilerOptions": {
    // Target: JavaScript version for output
    "target": "ES2022", // ES5, ES2015, ES2020, ES2022, ESNext

    // Module: Module system for output
    "module": "ESNext", // CommonJS, ES2015, ESNext, NodeNext

    // Lib: Type definitions to include
    "lib": ["ES2022", "DOM"],

    // Strict: Enable all strict type checking
    "strict": true,
    /* equivalent to:
      "noImplicitAny": true,
      "noImplicitThis": true,
      "alwaysStrict": true,
      "strictNullChecks": true,
      "strictFunctionTypes": true,
      "strictPropertyInitialization": true,
      "strictBindCallApply": true
    */

    // Output directory
    "outDir": "./dist",

    // Root directory
    "rootDir": "./src"
  }
}
```

### Level 2: Module Resolution (Week 2)
```json
{
  "compilerOptions": {
    // Module Resolution Strategy
    "moduleResolution": "bundler", // node, node16, nodenext, bundler

    // Base URL for relative imports
    "baseUrl": "./",

    // Path mapping
    "paths": {
      "@/*": ["src/*"],
      "@components/*": ["src/components/*"],
      "@utils/*": ["src/utils/*"],
      "@types/*": ["src/types/*"]
    },

    // Type roots
    "typeRoots": ["./node_modules/@types", "./src/types"],

    // Types to include
    "types": ["node", "jest", "express"],

    // Resolve JSON modules
    "resolveJsonModule": true,

    // Allow importing .ts files without extension
    "allowImportingTsExtensions": true // For bundler only
  }
}
```

### Level 3: Declaration Files & Emit (Week 3)
```json
{
  "compilerOptions": {
    // Generate .d.ts files
    "declaration": true,

    // Generate source maps for .d.ts files
    "declarationMap": true,

    // Generate separate .d.ts for each file
    "declarationDir": "./types",

    // Generate source maps for debugging
    "sourceMap": true,

    // Inline source maps
    "inlineSourceMap": false,

    // Include source in source maps
    "inlineSources": false,

    // Emit decorator metadata
    "emitDecoratorMetadata": true,

    // Enable experimental decorators
    "experimentalDecorators": true,

    // Remove comments from output
    "removeComments": true,

    // Do not emit output
    "noEmit": false, // Set true for type-checking only

    // Emit only .d.ts files
    "emitDeclarationOnly": false,

    // Import helpers from tslib
    "importHelpers": true
  }
}
```

### Level 4: Advanced Features (Week 4)
```json
{
  "compilerOptions": {
    // Incremental compilation
    "incremental": true,
    "tsBuildInfoFile": "./dist/.tsbuildinfo",

    // Composite projects
    "composite": true,

    // Preserve symlinks
    "preserveSymlinks": true,

    // Isolated modules (for faster transpilation)
    "isolatedModules": true,

    // Custom transformers
    "plugins": [
      { "transform": "typescript-transform-paths" }
    ],

    // Verbatim module syntax
    "verbatimModuleSyntax": true
  },

  // Project references
  "references": [
    { "path": "./packages/core" },
    { "path": "./packages/utils" }
  ]
}
```

## Configuration Recipes

### React + TypeScript
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "moduleResolution": "bundler",
    "jsx": "react-jsx", // or "react" for classic runtime
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "allowSyntheticDefaultImports": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true, // Vite/Webpack handles emit
    "baseUrl": "./",
    "paths": {
      "@/*": ["src/*"]
    }
  },
  "include": ["src"],
  "exclude": ["node_modules"]
}
```

### Node.js + TypeScript
```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "lib": ["ES2022"],
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "outDir": "./dist",
    "rootDir": "./src",
    "declaration": true,
    "sourceMap": true,
    "types": ["node"]
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.spec.ts"]
}
```

### Library (npm package)
```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "lib": ["ES2020"],
    "strict": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "outDir": "./dist",
    "rootDir": "./src",
    "removeComments": true,
    "importHelpers": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.test.ts", "**/*.spec.ts"]
}
```

### Monorepo with Project References
```json
// Root tsconfig.json
{
  "files": [],
  "references": [
    { "path": "./packages/core" },
    { "path": "./packages/utils" },
    { "path": "./packages/ui" }
  ]
}

// packages/core/tsconfig.json
{
  "extends": "../../tsconfig.base.json",
  "compilerOptions": {
    "composite": true,
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "include": ["src/**/*"]
}

// packages/utils/tsconfig.json
{
  "extends": "../../tsconfig.base.json",
  "compilerOptions": {
    "composite": true,
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "references": [
    { "path": "../core" }
  ],
  "include": ["src/**/*"]
}

// tsconfig.base.json (shared config)
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "strict": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  }
}
```

## Build Optimization

### Performance Tips
```json
{
  "compilerOptions": {
    // Enable incremental builds
    "incremental": true,

    // Skip type checking of declaration files
    "skipLibCheck": true,

    // Skip default library check
    "skipDefaultLibCheck": true,

    // Faster but less accurate checking
    "assumeChangesOnlyAffectDirectDependencies": true
  },

  // Exclude unnecessary files
  "exclude": [
    "node_modules",
    "dist",
    "build",
    "**/*.spec.ts",
    "**/*.test.ts",
    "coverage"
  ]
}
```

### Watch Mode Configuration
```json
{
  "watchOptions": {
    // Use file system events (faster on most systems)
    "watchFile": "useFsEvents",

    // Watch directory strategy
    "watchDirectory": "useFsEvents",

    // Polling fallback
    "fallbackPolling": "dynamicPriority",

    // Synchronous watch (for directories that don't support events)
    "synchronousWatchDirectory": true,

    // Exclude directories from watch
    "excludeDirectories": ["**/node_modules", "**/dist"]
  }
}
```

## Integration with Tools

### ESLint Integration
```json
// tsconfig.json
{
  "compilerOptions": {
    // Required for ESLint
    "noEmit": true,
    "skipLibCheck": true
  }
}

// .eslintrc.js
module.exports = {
  parser: "@typescript-eslint/parser",
  parserOptions: {
    project: "./tsconfig.json",
    ecmaVersion: 2022,
    sourceType: "module"
  },
  plugins: ["@typescript-eslint"],
  extends: [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:@typescript-eslint/recommended-requiring-type-checking"
  ]
};
```

### Jest Integration
```json
// tsconfig.json
{
  "compilerOptions": {
    "types": ["jest", "node"]
  }
}

// jest.config.js
module.exports = {
  preset: "ts-jest",
  testEnvironment: "node",
  roots: ["<rootDir>/src"],
  testMatch: ["**/__tests__/**/*.ts", "**/?(*.)+(spec|test).ts"],
  transform: {
    "^.+\\.ts$": "ts-jest"
  }
};
```

### Vite Integration
```json
// tsconfig.json
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "module": "ESNext",
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}

// tsconfig.node.json (for Vite config)
{
  "compilerOptions": {
    "composite": true,
    "module": "ESNext",
    "moduleResolution": "bundler",
    "allowSyntheticDefaultImports": true
  },
  "include": ["vite.config.ts"]
}
```

## Best Practices

1. **Always Enable Strict Mode**: Use `"strict": true` for maximum safety
2. **Use Project References**: For monorepos and large projects
3. **Configure Path Mapping**: Use `paths` for cleaner imports
4. **Enable Incremental Builds**: Faster compilation with `"incremental": true`
5. **Skip Lib Check**: Use `"skipLibCheck": true` for faster builds
6. **Extend Base Configs**: Share common settings across projects

## Common Pitfalls

❌ **Not using strict mode**
```json
// Bad - weak type checking
{
  "compilerOptions": {
    "strict": false
  }
}

// Good - strict type checking
{
  "compilerOptions": {
    "strict": true
  }
}
```

❌ **Wrong module resolution**
```json
// Bad for modern bundlers
{
  "compilerOptions": {
    "moduleResolution": "node"
  }
}

// Good for Vite/Webpack/Rollup
{
  "compilerOptions": {
    "moduleResolution": "bundler"
  }
}
```

❌ **Including too many files**
```json
// Bad - includes everything
{
  "include": ["**/*"]
}

// Good - specific includes
{
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "**/*.spec.ts"]
}
```

## Exercises

### Exercise 1: React Project Setup
Configure tsconfig.json for a React + Vite project with path aliases.

### Exercise 2: Monorepo Configuration
Set up project references for a monorepo with 3 packages.

### Exercise 3: Library Development
Configure TypeScript for an npm library with declaration files.

### Exercise 4: Performance Optimization
Optimize tsconfig.json for a large codebase (10,000+ files).

## Resources
- [TSConfig Reference](https://www.typescriptlang.org/tsconfig)
- [TypeScript Compiler Options](https://www.typescriptlang.org/docs/handbook/compiler-options.html)
- [Project References](https://www.typescriptlang.org/docs/handbook/project-references.html)
- [TSConfig Bases](https://github.com/tsconfig/bases)

## Prerequisites
- TypeScript Fundamentals
- Understanding of JavaScript modules
- Build tool knowledge (Webpack, Vite, etc.)

## Estimated Duration
2-3 weeks (8-10 hours per week)

## Next Agent
Continue to **Testing Types Agent** for learning type testing, test frameworks integration, and type-safe testing patterns.

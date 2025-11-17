# Skill: Svelte - True Reactivity

**Level:** Core
**Duration:** 2 weeks
**Agent:** Frameworks
**Prerequisites:** JavaScript Fundamentals

## Overview
Learn Svelte, the compiler-based framework. Experience true reactivity with minimal boilerplate and excellent performance.

## Key Topics

- Component structure
- Reactive declarations
- Stores
- Animations and transitions
- Two-way binding
- Lifecycle functions

## Learning Objectives

- Build Svelte components
- Use reactive declarations
- Create and use stores
- Implement animations
- Handle form input

## Practical Exercises

### Reactive component
```svelte
<script>
  let count = 0;
  $: doubled = count * 2;
  
  function increment() {
    count++;
  }
</script>

<p>{count} doubled is {doubled}</p>
<button on:click={increment}>Increment</button>
```

## Resources

- [Svelte Official Docs](https://svelte.dev/)
- [Svelte Tutorial](https://svelte.dev/tutorial)

---
**Status:** Active | **Version:** 1.0.0

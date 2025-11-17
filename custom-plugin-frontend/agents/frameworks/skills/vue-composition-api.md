# Skill: Vue - Composition API

**Level:** Core
**Duration:** 2 weeks
**Agent:** Frameworks
**Prerequisites:** JavaScript Fundamentals

## Overview
Learn Vue.js with the modern Composition API. Build reactive, component-based applications with excellent developer experience.

## Key Topics

- Single File Components
- Composition API
- Reactive data
- Computed properties
- Template syntax
- Component communication

## Learning Objectives

- Create Vue components
- Use Composition API
- Manage reactive state
- Create computed properties
- Handle events

## Practical Exercises

### Component with Composition API
```javascript
<script setup>
import { ref, computed } from 'vue'

const count = ref(0)
const doubled = computed(() => count.value * 2)

const increment = () => count.value++
</script>

<template>
  <p>{{ count }}</p>
  <p>Doubled: {{ doubled }}</p>
  <button @click="increment">Increment</button>
</template>
```

## Resources

- [Vue Official Docs](https://vuejs.org/)
- [Composition API](https://vuejs.org/guide/extras/composition-api-faq.html)

---
**Status:** Active | **Version:** 1.0.0

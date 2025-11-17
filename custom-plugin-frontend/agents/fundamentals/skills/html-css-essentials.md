# Skill: HTML & CSS Essentials

**Level:** Foundation
**Duration:** 2 weeks
**Agent:** Fundamentals
**Prerequisites:** None

## Overview
Master the foundational markup and styling languages that power the web. HTML5 provides semantic structure, CSS creates visual design and responsive layouts.

## Learning Objectives

- Create semantically correct HTML documents
- Master CSS layout techniques (Flexbox, Grid)
- Build responsive designs
- Apply accessibility best practices
- Optimize styling performance

## Key Topics

### HTML5 Semantic Markup
- Document structure (`<!DOCTYPE>`, `<html>`, `<head>`, `<body>`)
- Semantic elements (`<header>`, `<nav>`, `<main>`, `<article>`, `<footer>`)
- Forms and inputs with validation
- Accessibility attributes (ARIA, alt text)
- Data attributes and custom elements

### CSS Fundamentals
- Selectors and specificity
- Box model and display properties
- Units (px, em, rem, %, vw, vh)
- Colors and gradients
- Typography and fonts

### Responsive Design
- Mobile-first approach
- Media queries and breakpoints
- Flexible layouts
- Responsive images
- Touch-friendly interfaces

### CSS Layouts
- **Flexbox:** Flexible box model for 1D layouts
- **CSS Grid:** 2D grid layouts
- **Positioning:** Static, relative, absolute, fixed, sticky
- **Modern layout tricks:** Subgrid, aspect-ratio

## Practical Exercises

### Exercise 1: Semantic HTML Structure
Create a proper document structure:
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Page Title</title>
</head>
<body>
  <header>
    <nav>Navigation</nav>
  </header>
  <main>
    <article>
      <h1>Article Title</h1>
      <p>Content...</p>
    </article>
  </main>
  <footer>Footer content</footer>
</body>
</html>
```

### Exercise 2: Flexbox Layout
Create a flexible navigation:
```css
nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 1rem;
}
```

### Exercise 3: Responsive Grid
Build responsive grid:
```css
.grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}
```

### Exercise 4: Media Queries
Implement responsive design:
```css
@media (max-width: 768px) {
  .sidebar {
    display: none;
  }
}
```

## Real-World Projects

### Project 1: Personal Website
- Semantic HTML structure
- Responsive design
- Contact form
- Navigation menu

### Project 2: E-Commerce Product Page
- Semantic markup
- Flexbox/Grid layouts
- Responsive images
- Product variations

## Assessment Criteria

- ✅ Semantic HTML correctness
- ✅ CSS organization and efficiency
- ✅ Responsive design across devices
- ✅ Accessibility compliance (WCAG)
- ✅ Performance (no layout thrashing)

## Resources

- [MDN: HTML Guide](https://developer.mozilla.org/en-US/docs/Learn/HTML)
- [MDN: CSS Guide](https://developer.mozilla.org/en-US/docs/Learn/CSS)
- [CSS-Tricks: Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)
- [CSS-Tricks: Grid](https://css-tricks.com/snippets/css/complete-guide-grid/)
- [Web.dev: Responsive Design](https://web.dev/responsive-web-design-basics/)

## Next Skills

- JavaScript Fundamentals
- DOM Manipulation
- Responsive Design Advanced

---
**Status:** Active | **Version:** 1.0.0

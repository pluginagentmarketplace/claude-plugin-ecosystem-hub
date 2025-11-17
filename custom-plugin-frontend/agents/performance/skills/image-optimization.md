# Skill: Image Optimization

**Level:** Core
**Duration:** 1 week
**Agent:** Performance
**Prerequisites:** Fundamentals Agent

## Overview
Optimize images for web performance. Learn modern formats, responsive images, and CDN strategies to reduce file sizes.

## Key Topics

- Modern image formats (WebP, AVIF)
- Responsive images and srcset
- Image compression
- Image CDNs
- Lazy loading
- SVG optimization

## Learning Objectives

- Convert to modern formats
- Implement responsive images
- Compress effectively
- Set up image CDN
- Lazy load images

## Practical Exercises

### Responsive images
```html
<picture>
  <source srcset="image.avif" type="image/avif">
  <source srcset="image.webp" type="image/webp">
  <img src="image.jpg" alt="Description">
</picture>
```

### Lazy loading
```html
<img src="image.jpg" loading="lazy" alt="Description">
```

## Format Comparison

- **WebP:** -30% size
- **AVIF:** -50% size

## Resources

- [Image Optimization](https://web.dev/image-optimization/)
- [Sharp.js](https://sharp.pixelplumbing.com/)

---
**Status:** Active | **Version:** 1.0.0

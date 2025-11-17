# Skill: Progressive Web Apps (PWAs)

**Level:** Advanced
**Duration:** 1.5 weeks
**Agent:** Advanced Topics
**Prerequisites:** All Core Agents

## Overview
Build Progressive Web Apps that work offline and feel like native applications. Master Web App Manifest, Service Workers, and PWA patterns.

## Key Topics

- Web App Manifest
- Service Workers
- Offline support
- Push notifications
- Installation experience
- Background sync

## Learning Objectives

- Create Web App Manifest
- Implement Service Workers
- Handle offline scenarios
- Add push notifications
- Enable installation
- Test PWA

## Practical Exercises

### Web App Manifest
```json
{
  "name": "My App",
  "short_name": "App",
  "start_url": "/",
  "icons": [{"src": "icon.png", "sizes": "192x192"}],
  "theme_color": "#000000"
}
```

### Service Worker
```javascript
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open('v1').then(cache => {
      return cache.addAll(['/index.html', '/styles.css']);
    })
  );
});
```

## Resources

- [PWA Docs](https://developers.google.com/web/progressive-web-apps)
- [Service Workers](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API)

---
**Status:** Active | **Version:** 1.0.0

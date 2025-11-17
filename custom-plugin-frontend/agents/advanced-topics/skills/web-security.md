# Skill: Web Security Best Practices

**Level:** Advanced
**Duration:** 1.5 weeks
**Agent:** Advanced Topics
**Prerequisites:** All Core Agents

## Overview
Secure frontend applications against common attacks. Master CORS, XSS prevention, CSRF protection, and security headers.

## Key Topics

- CORS configuration
- XSS prevention
- CSRF protection
- CSP (Content Security Policy)
- Security headers
- HTTPS/TLS
- Secure authentication

## Learning Objectives

- Prevent XSS attacks
- Implement CSRF protection
- Configure CORS correctly
- Deploy CSP headers
- Secure sensitive data
- Use security headers

## Practical Exercises

### CORS configuration
```javascript
app.use(cors({
  origin: ['https://example.com'],
  credentials: true
}));
```

### Security headers
```javascript
app.use(helmet());
```

### Content Security Policy
```html
<meta http-equiv="Content-Security-Policy" 
      content="default-src 'self'; script-src 'self' 'unsafe-inline'">
```

## Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Web Security](https://developer.mozilla.org/en-US/docs/Web/Security)

---
**Status:** Active | **Version:** 1.0.0

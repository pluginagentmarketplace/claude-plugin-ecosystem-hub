# Skill: Angular Core Concepts

**Level:** Core
**Duration:** 2 weeks
**Agent:** Frameworks
**Prerequisites:** TypeScript Fundamentals

## Overview
Master Angular, the comprehensive framework for large-scale applications. Learn components, dependency injection, and RxJS.

## Key Topics

- Component architecture
- Dependency injection
- Services
- Observables and RxJS
- Routing
- Forms

## Learning Objectives

- Create Angular components
- Build services
- Use dependency injection
- Work with Observables
- Implement routing

## Practical Exercises

### Component and service
```typescript
@Component({
  selector: 'app-user',
  template: '<p>{{ user$ | async }}</p>'
})
export class UserComponent {
  user$ = this.userService.getUser();
  
  constructor(private userService: UserService) {}
}

@Injectable()
export class UserService {
  getUser() {
    return this.http.get('/api/user');
  }
}
```

## Resources

- [Angular Docs](https://angular.io/)
- [RxJS Documentation](https://rxjs.dev/)

---
**Status:** Active | **Version:** 1.0.0

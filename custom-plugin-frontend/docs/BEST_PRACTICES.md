# Best Practices Guide

## Frontend Development Best Practices 2025

This guide compiles industry-standard best practices across all frontend development domains.

## 1. Code Quality & Organization

### JavaScript/TypeScript

#### ✅ DO
- Use meaningful variable and function names
- Keep functions small and focused (under 20 lines)
- Use const by default, let when needed, avoid var
- Write pure functions when possible
- Add JSDoc comments for complex logic

#### ❌ DON'T
- Use single-letter variables (except i in loops)
- Write functions longer than a screen
- Nest conditionals more than 3 levels
- Mix concerns in functions
- Ignore TypeScript strictness

```javascript
// ✅ Good
function calculateUserDiscount(user, orderTotal) {
  const isStudent = user.status === 'student';
  const discountRate = isStudent ? 0.15 : 0.10;
  return orderTotal * discountRate;
}

// ❌ Bad
function calc(u, t) {
  if (u.status === 'student') {
    return t * 0.15;
  } else {
    return t * 0.10;
  }
}
```

### HTML & CSS

#### ✅ DO
- Use semantic HTML elements
- Follow BEM or similar naming convention
- Use CSS Grid and Flexbox for layouts
- Mobile-first responsive design
- Organize styles logically

#### ❌ DON'T
- Use div for everything
- Style with inline styles
- Use !important excessively
- Create class names that describe styles ("red-text")
- Skip accessibility attributes

```html
<!-- ✅ Good -->
<header>
  <nav class="nav">
    <ul class="nav__list">
      <li class="nav__item"><a href="/">Home</a></li>
    </ul>
  </nav>
</header>

<!-- ❌ Bad -->
<div style="background: #333; padding: 20px;">
  <div style="margin: 0; padding: 0;">
    <div style="color: white;">Home</div>
  </div>
</div>
```

## 2. Performance Best Practices

### Bundle Optimization

#### ✅ DO
- Implement code splitting by routes
- Lazy load above-the-fold content
- Tree-shake unused code
- Minify and compress assets
- Use modern image formats (WebP, AVIF)

#### ❌ DON'T
- Ship everything in one bundle
- Load heavy libraries unnecessarily
- Ignore bundle size
- Use uncompressed images
- Forget to optimize dependencies

### Core Web Vitals

#### ✅ DO
- Optimize LCP (< 2.5s)
- Optimize INP (< 200ms)
- Prevent CLS (< 0.1)
- Test on real devices
- Monitor production performance

#### ❌ DON'T
- Ignore metrics
- Test only on fast connections
- Ship without performance budget
- Use render-blocking resources
- Load fonts without optimization

## 3. Security Best Practices

### Input Handling

#### ✅ DO
- Validate all inputs
- Sanitize HTML inputs with libraries (DOMPurify)
- Use parameterized queries for APIs
- Implement CSP headers
- Use HTTPS everywhere

#### ❌ DON'T
- Trust user input
- Use innerHTML with untrusted data
- Store sensitive data in localStorage
- Ignore CORS restrictions
- Log sensitive information

### CORS & API Security

#### ✅ DO
```javascript
// Good CORS configuration
app.use(cors({
  origin: ['https://trusted-domain.com'],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE']
}));

// Good authentication
const token = localStorage.getItem('auth_token');
fetch('/api/data', {
  headers: { 'Authorization': `Bearer ${token}` }
});
```

#### ❌ DON'T
```javascript
// Bad CORS - allows all origins
app.use(cors());

// Bad authentication
fetch('/api/data?token=' + token);
```

## 4. State Management Best Practices

### ✅ DO
- Keep state as close as possible to where it's used
- Normalize complex state
- Use selectors for derived state
- Prefer immutability
- Keep UI state separate from business logic

#### ❌ DON'T
- Store everything in global state
- Duplicate data across state tree
- Mutate state directly
- Store computed values
- Mix concerns in reducers

```javascript
// ✅ Good state structure
{
  users: {
    byId: { "1": User, "2": User },
    allIds: ["1", "2"]
  },
  posts: {
    byId: { "1": Post },
    allIds: ["1"]
  },
  ui: {
    selectedUserId: "1",
    loading: false
  }
}

// ❌ Bad state structure
{
  users: [
    { id: "1", posts: [Post, Post] },
    { id: "2", posts: [Post] }
  ]
}
```

## 5. Testing Best Practices

### Coverage & Strategy

#### ✅ DO
- Follow testing pyramid (70% unit, 20% integration, 10% E2E)
- Test user behavior, not implementation
- Use descriptive test names
- Test error scenarios
- Keep tests maintainable

#### ❌ DON'T
- Chase 100% coverage
- Test implementation details
- Use brittle selectors
- Ignore async operations
- Skip accessibility testing

```javascript
// ✅ Good test
test('user can submit contact form', async () => {
  const { getByRole, getByLabelText } = render(<ContactForm />);

  const emailInput = getByLabelText(/email/i);
  await userEvent.type(emailInput, 'test@example.com');

  const submitButton = getByRole('button', { name: /submit/i });
  await userEvent.click(submitButton);

  expect(getByText(/success/i)).toBeInTheDocument();
});

// ❌ Bad test
test('form works', () => {
  const wrapper = mount(ContactForm);
  wrapper.find('input').at(0).setValue('test@example.com');
  expect(wrapper.find('form').length).toBe(1);
});
```

## 6. Accessibility Best Practices

### ✅ DO
- Use semantic HTML
- Include alt text for images
- Maintain color contrast (4.5:1 minimum)
- Support keyboard navigation
- Test with screen readers

#### ❌ DON'T
- Use color alone to convey information
- Disable zoom on mobile
- Forget about keyboard navigation
- Use meaningless alt text
- Create unlabeled form inputs

```html
<!-- ✅ Good accessibility -->
<form>
  <label for="email">Email Address</label>
  <input id="email" type="email" required>

  <label for="subject">Subject</label>
  <input id="subject" type="text" required>

  <button type="submit">Send Message</button>
</form>

<!-- ❌ Poor accessibility -->
<form>
  <input placeholder="Email">
  <input placeholder="Subject">
  <button onclick="sendMessage()">Send</button>
</form>
```

## 7. Git & Version Control

### ✅ DO
- Use meaningful commit messages
- One logical change per commit
- Create feature branches
- Use conventional commits
- Keep history clean

#### ❌ DON'T
- Commit with messages like "fixes"
- Mix multiple features in one commit
- Commit directly to main
- Rewrite public history
- Leave merge conflicts unresolved

```bash
# ✅ Good commit message
git commit -m "feat: add user authentication

- Implement JWT-based authentication
- Add login and logout endpoints
- Add unit tests for auth service"

# ❌ Bad commit message
git commit -m "fixes and stuff"
```

## 8. Documentation Best Practices

### ✅ DO
- Document public APIs
- Include usage examples
- Explain why, not just what
- Keep docs up-to-date
- Use clear language

#### ❌ DON'T
- Document obvious code
- Let docs get out of sync
- Use jargon without explanation
- Skip edge cases
- Forget to update on changes

```javascript
/**
 * Calculate discounted price for a customer
 *
 * @param {number} basePrice - The original price
 * @param {string} customerType - 'standard' or 'premium'
 * @returns {number} The discounted price
 *
 * @example
 * calculatePrice(100, 'premium') // returns 85
 */
function calculatePrice(basePrice, customerType) {
  const discount = customerType === 'premium' ? 0.15 : 0.05;
  return basePrice * (1 - discount);
}
```

## 9. Component Best Practices

### React/Vue/Angular

#### ✅ DO
- Keep components focused and single-responsibility
- Use composition over inheritance
- Extract reusable logic into hooks/composables
- Memoize expensive computations
- Type your props/inputs

#### ❌ DON'T
- Create god components (too many responsibilities)
- Overuse higher-order components
- Mutate props/inputs
- Create unnecessary wrapper components
- Ignore performance optimizations

```javascript
// ✅ Good component
export interface UserCardProps {
  id: string;
  name: string;
  email: string;
}

export function UserCard({ id, name, email }: UserCardProps) {
  return (
    <article className="user-card">
      <h2>{name}</h2>
      <p>{email}</p>
    </article>
  );
}

// ❌ Bad component
export function AdminPanel(props: any) {
  // Component does too much:
  // - Fetches data
  // - Manages complex state
  // - Renders multiple sections
  // - Handles authentication
  // - Manages UI state
}
```

## 10. Error Handling Best Practices

### ✅ DO
- Catch errors gracefully
- Provide meaningful error messages
- Use error boundaries
- Log errors appropriately
- Fail fast with validation

#### ❌ DON'T
- Silently ignore errors
- Expose implementation details
- Leave try-catch blocks empty
- Mix error handling with business logic
- Debug in production

```javascript
// ✅ Good error handling
try {
  const data = await fetchUserData(userId);
  return data;
} catch (error) {
  if (error instanceof NetworkError) {
    logError(error, { context: 'fetchUserData' });
    throw new UserFriendlyError('Network error. Please try again.');
  }
  throw error;
}

// ❌ Bad error handling
try {
  const data = await fetchUserData(userId);
} catch (e) {
  // ignored
}
```

## 11. API Integration Best Practices

### ✅ DO
- Use established HTTP patterns
- Cache appropriately
- Implement request/response interceptors
- Handle rate limiting
- Version APIs

#### ❌ DON'T
- Make API calls in useEffect without dependencies
- Store API responses in Redux for all data
- Ignore API versioning
- Miss error handling
- Make synchronous API calls

## 12. Environment & Configuration

### ✅ DO
- Use environment variables for configuration
- Never commit secrets
- Separate dev/test/production configs
- Document environment variables
- Use .env files locally

#### ❌ DON'T
- Hardcode API keys
- Store passwords in code
- Use same config everywhere
- Commit .env files
- Trust environment variables in frontend

```bash
# ✅ Good .env.example
VITE_API_URL=https://api.example.com
VITE_APP_NAME=MyApp
VITE_LOG_LEVEL=debug

# Usage in code
const apiUrl = import.meta.env.VITE_API_URL
```

## Quick Checklist

### Before Shipping
- [ ] Tested on multiple browsers
- [ ] Works on mobile devices
- [ ] Accessibility checked (axe, WCAG)
- [ ] Performance checked (Lighthouse 90+)
- [ ] Security reviewed (no secrets, CORS configured)
- [ ] Error handling in place
- [ ] Loading states implemented
- [ ] Documented for team
- [ ] Code reviewed by peers
- [ ] git history is clean

### Production Ready Checklist
- [ ] Error tracking configured
- [ ] Performance monitoring enabled
- [ ] Analytics configured
- [ ] Security headers set
- [ ] SSL/TLS enabled
- [ ] CORS configured correctly
- [ ] Rate limiting implemented
- [ ] Database backups configured
- [ ] CI/CD pipeline working
- [ ] Documentation up-to-date

## Resources

- [MDN Best Practices](https://developer.mozilla.org/)
- [Web.dev Guidelines](https://web.dev/)
- [Google JavaScript Style Guide](https://google.github.io/styleguide/tsguide.html)
- [Airbnb Style Guide](https://github.com/airbnb/javascript)
- [OWASP Security](https://owasp.org/)

---

**Remember:** Best practices are guidelines, not rules. Use judgment based on your specific context and requirements.

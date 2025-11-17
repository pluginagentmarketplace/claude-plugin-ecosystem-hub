# Performance & Optimization Agent

## Agent Profile
**Name:** Performance Optimization Master
**Specialization:** Web Vitals, Optimization Techniques, Monitoring, DevTools
**Level:** Intermediate to Advanced
**Duration:** 3-4 weeks (18-22 hours)
**Prerequisites:** Fundamentals Agent + Build Tools Agent + Frameworks Agent

## Philosophy
The Performance Agent teaches the science and art of creating fast, responsive web applications. Users expect sub-second interactions. Slow applications lose users. This agent covers Core Web Vitals, optimization techniques, and continuous monitoring to ensure applications remain performant as they evolve.

## Agent Capabilities

### 1. Performance Metrics
- **Core Web Vitals** - LCP, FID/INP, CLS
- **Lighthouse** - Automated auditing
- **Performance Timeline** - Using DevTools
- **Real User Monitoring (RUM)** - Production metrics
- **Performance APIs** - Custom measurements
- **Performance Budgets** - Enforcing targets

### 2. Code Optimization
- **Code Splitting** - Route and component-based
- **Lazy Loading** - Dynamic imports, intersection observer
- **Tree Shaking** - Dead code elimination
- **Bundle Analysis** - Size profiling
- **Minification** - Production builds
- **Compression** - Gzip and Brotli

### 3. Image Optimization
- **Image Formats** - WebP, AVIF
- **Responsive Images** - srcset and picture
- **Image Processing** - Compression tools
- **Image CDNs** - Cloudinary, Imgix
- **Lazy Loading Images** - Native and observer
- **SVG Optimization** - SVGO

### 4. Browser DevTools Mastery
- **Performance Panel** - Profiling and recording
- **Network Panel** - Request analysis
- **Coverage Tool** - Unused code detection
- **Memory Panel** - Leak detection
- **Lighthouse** - Automated auditing
- **Custom Metrics** - PerformanceObserver

### 5. Advanced Techniques
- **Resource Hints** - dns-prefetch, preload, prefetch
- **HTTP/2 & HTTP/3** - Protocol optimization
- **Service Workers** - Caching strategies
- **Critical CSS** - Above-the-fold optimization
- **Web Workers** - Computation offloading
- **Debouncing & Throttling** - Event optimization

### 6. Monitoring & Analytics
- **Continuous Monitoring** - Production tracking
- **Error Tracking** - Sentry integration
- **Performance Budgets** - Build-time enforcement
- **CI/CD Integration** - Lighthouse CI
- **Analytics** - Google Analytics, custom tracking
- **Alerting** - Performance regression detection

## Learning Outcomes

After completing this agent, developers will:
- ✅ Understand Web Vitals and optimize for them
- ✅ Use Lighthouse and DevTools effectively
- ✅ Implement code splitting and lazy loading
- ✅ Optimize images and assets
- ✅ Monitor production performance
- ✅ Set performance budgets
- ✅ Identify and fix bottlenecks
- ✅ Maintain performance as app grows

## Skill Hierarchy

### Foundation Level (Week 1)
1. **Performance Fundamentals** - Why performance matters
2. **Core Web Vitals** - LCP, FID/INP, CLS
3. **Lighthouse Introduction** - Automated auditing

### Core Level (Week 1-2)
4. **Code Splitting** - Route and component-based
5. **Lazy Loading** - Images and components
6. **Bundle Analysis** - Size profiling

### Advanced Level (Week 2-3)
7. **Image Optimization** - Formats and CDNs
8. **DevTools Mastery** - Performance profiling
9. **Resource Hints** - Optimization hints
10. **Caching Strategies** - Service Workers

### Monitoring Level (Week 3-4)
11. **Real User Monitoring** - Production metrics
12. **Performance Budgets** - Build enforcement
13. **CI/CD Integration** - Automated checking
14. **Capstone Project** - Full optimization

## Prerequisites
- Completion of Build Tools Agent
- Framework knowledge
- Understanding of bundles and modules
- Basic DevTools usage

## Tools Required
- **Browser DevTools** - Chrome/Firefox with performance tab
- **CLI Tools** - Lighthouse CLI, Bundle Analyzer
- **Bundlers** - Webpack or Vite
- **Image Tools** - Sharp, ImageOptim
- **Monitoring:** Sentry, New Relic, or similar

## Project-Based Learning

### Project 1: Lighthouse Audit (Week 1)
Audit existing application:
- Run Lighthouse audit
- Identify bottlenecks
- Generate improvement plan
- Document findings

### Project 2: Code Splitting (Week 1-2)
Implement code splitting:
- Route-based splitting
- Component lazy loading
- Dynamic imports
- Measure improvement

### Project 3: Image Optimization (Week 2)
Optimize image assets:
- Convert to WebP/AVIF
- Implement responsive images
- Set up image CDN
- Test with DevTools

### Project 4: Full Performance Audit (Week 2-3)
Comprehensive optimization:
- All DevTools panels
- Identify all bottlenecks
- Implement fixes
- Measure and document

### Project 5: Monitoring Setup (Week 3-4)
Production monitoring:
- Web Vitals tracking
- Error reporting
- Performance budgets
- CI/CD integration

## Recommended Resources

### Performance Guidance
- [Core Web Vitals Guide](https://web.dev/vitals/)
- [Lighthouse Documentation](https://developers.google.com/web/tools/lighthouse)
- [Chrome DevTools Performance](https://developer.chrome.com/docs/devtools/performance/)
- [Web Fundamentals](https://developers.google.com/web/fundamentals)

### Tools & Services
- [Lighthouse CI](https://github.com/GoogleChrome/lighthouse-ci)
- [Web Vitals Library](https://github.com/GoogleChrome/web-vitals)
- [Bundle Analyzer](https://www.npmjs.com/package/webpack-bundle-analyzer)
- [Size Limit](https://github.com/ai/size-limit)

### Image Optimization
- [Sharp.js](https://sharp.pixelplumbing.com/)
- [Cloudinary](https://cloudinary.com/)
- [ImageOptim](https://imageoptim.com/)
- [SVGO](https://svgo.dev/)

## Learning Outcomes Checklist

### Core Web Vitals
- [ ] Understand LCP and optimize
- [ ] Understand FID/INP and improve
- [ ] Understand CLS and prevent
- [ ] Measure with tools
- [ ] Set targets

### Code & Bundle Optimization
- [ ] Implement code splitting
- [ ] Lazy load components
- [ ] Analyze bundle sizes
- [ ] Tree-shake unused code
- [ ] Minify and compress

### Image Optimization
- [ ] Convert to modern formats
- [ ] Implement responsive images
- [ ] Use image CDN
- [ ] Lazy load images
- [ ] Optimize SVG

### DevTools Mastery
- [ ] Use Performance panel
- [ ] Analyze network waterfall
- [ ] Detect unused code
- [ ] Find memory leaks
- [ ] Profile with Lighthouse

### Monitoring & Budgets
- [ ] Set performance budgets
- [ ] Track real user metrics
- [ ] Monitor in production
- [ ] Set up alerting
- [ ] Document metrics

## Daily Schedule (Example Week)

**Monday:** Web Vitals concepts + Lighthouse intro
**Tuesday:** Code splitting implementation
**Wednesday:** Image optimization exercises
**Thursday:** DevTools deep-dive
**Friday:** Project work + monitoring setup

## Assessment Criteria

- **Knowledge:** 20% of grade
- **Optimization Implementation:** 40% of grade
- **Monitoring Setup:** 20% of grade
- **Documentation:** 20% of grade

## Performance Targets (2025 Standards)

### Core Web Vitals
- **LCP:** < 2.5 seconds
- **FID:** < 100ms (deprecated)
- **INP:** < 200ms (replacement)
- **CLS:** < 0.1

### Build Metrics
- **Initial Load:** < 3 seconds
- **Interactive:** < 5 seconds
- **Lighthouse Score:** 90+ (green)

### Bundle Sizes (Gzipped)
- **JavaScript:** < 100KB
- **CSS:** < 50KB
- **Images:** < 500KB

## Image Format Comparison

| Format | Size | Support | Use Case |
|--------|------|---------|----------|
| **WebP** | -30% | 96% browsers | Primary format |
| **AVIF** | -50% | 84% browsers | Modern browsers |
| **JPEG** | Baseline | 100% | Fallback |
| **PNG** | Large | 100% | Transparent images |
| **SVG** | Small | 100% | Icons & logos |

## Optimization Techniques Priority

### High Impact (Do First)
1. Image optimization
2. Code splitting
3. Lazy loading
4. Minification & compression
5. Caching strategy

### Medium Impact
6. Resource hints
7. Async script loading
8. CSS optimization
9. Font optimization
10. Service Workers

### Optimization Details
11. Web Workers
12. Request batching
13. Critical CSS
14. HTTP/2 push

## Common Performance Mistakes

1. **Shipping unused code** - Use coverage and tree-shake
2. **Large unoptimized images** - Convert and compress
3. **Synchronous scripts** - Use async/defer
4. **Ignoring Core Web Vitals** - Monitor and optimize
5. **No performance budgets** - Set and enforce limits

## Real-World Scenarios

### Scenario 1: Slow Production App
- Profile with DevTools
- Identify bottlenecks
- Implement fixes
- Measure improvement

### Scenario 2: Large Bundle
- Analyze with Bundle Analyzer
- Implement code splitting
- Find unused code
- Optimize and test

### Scenario 3: Image-Heavy App
- Convert to WebP/AVIF
- Implement responsive images
- Set up CDN
- Lazy load images

## Integration with Other Agents

- **Build Tools Agent:** Bundle optimization
- **Frameworks Agent:** Framework-specific optimization
- **Testing Agent:** Performance testing
- **Advanced Topics Agent:** PWA and caching

## Performance Optimization Checklist

- [ ] Lighthouse score 90+ (mobile)
- [ ] Core Web Vitals green
- [ ] LCP < 2.5s
- [ ] INP < 200ms
- [ ] CLS < 0.1
- [ ] Bundle size analyzed
- [ ] Code splitting implemented
- [ ] Images optimized
- [ ] Caching configured
- [ ] Monitoring set up

## Next Steps

After this agent, progress to:
1. **Advanced Topics Agent** (PWAs, caching)
2. **Testing Agent** (performance testing)
3. **Continuous learning** (monitor and iterate)

## Support & Resources

- **Agent docs:** See `skills/` for detailed modules
- **Examples:** See `examples/` for optimization projects
- **Resources:** See `resources/` for tools and links
- **Progress:** See hooks for tracking

---

**Agent Status:** ✅ Active
**Last Updated:** 2025-01-01
**Version:** 1.0.0

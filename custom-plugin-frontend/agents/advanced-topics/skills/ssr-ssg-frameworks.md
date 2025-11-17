# Skill: Server-Side Rendering & Static Generation

**Level:** Advanced
**Duration:** 1.5 weeks
**Agent:** Advanced Topics
**Prerequisites:** Framework knowledge

## Overview
Master SSR and SSG with Next.js, Nuxt, and other meta-frameworks. Optimize for SEO, performance, and user experience.

## Key Topics

- Server-Side Rendering (SSR)
- Static Site Generation (SSG)
- Incremental Static Regeneration (ISR)
- Data fetching patterns
- Dynamic routes
- Deployment strategies

## Learning Objectives

- Build SSR applications
- Implement SSG
- Configure ISR
- Fetch data server-side
- Generate dynamic routes
- Deploy SSR/SSG apps

## Practical Exercises

### Next.js dynamic routes
```javascript
export async function getStaticPaths() {
  const posts = await getPosts();
  return {
    paths: posts.map(p => ({ params: { slug: p.slug } })),
    fallback: 'blocking'
  };
}

export async function getStaticProps({ params }) {
  const post = await getPost(params.slug);
  return { props: { post }, revalidate: 3600 };
}
```

## Resources

- [Next.js Docs](https://nextjs.org/docs)
- [Nuxt Docs](https://nuxt.com/)

---
**Status:** Active | **Version:** 1.0.0

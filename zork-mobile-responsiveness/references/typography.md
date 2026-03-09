# Fluid Typography

```css
:root {
  /* Fluid font size: 16px at 320px viewport, 20px at 1200px viewport */
  --font-size-base: clamp(1rem, 0.9rem + 0.5vw, 1.25rem);
  
  /* Fluid heading */
  --font-size-h1: clamp(2rem, 1.5rem + 2.5vw, 4rem);
}

body {
  font-size: var(--font-size-base);
}

h1 {
  font-size: var(--font-size-h1);
}
```

## Text content with typographic rhythm
```
<article className="prose">
  <h1>Article Title</h1>           {/* mb-4 inherited */}
  <p className="lead">Intro text.</p>
  <p>Body paragraph.</p>           {/* my-4 inherited */}
  <h2>Subheading</h2>              {/* mt-8 mb-4 inherited */}
  <p>More content.</p>
</article>
```
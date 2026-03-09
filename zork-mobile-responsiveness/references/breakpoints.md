# Breakpoints for Mobile Interfaces

## Mobile-First Breakpoints

```css
/* Mobile first - no media query needed for mobile base */
.container {
  padding: 1rem;
}

/* Tablet */
@media (min-width: 768px) {
  .container {
    padding: 2rem;
  }
}

/* Desktop */
@media (min-width: 1024px) {
  .container {
    padding: 3rem;
    max-width: 1200px;
    margin: 0 auto;
  }
}

/* Large desktop */
@media (min-width: 1280px) {
  .container {
    max-width: 1400px;
  }
}
```

## Tailwind Breakpoints

```tsx
<div className="
  p-4          /* Mobile: padding 1rem */
  md:p-8       /* Tablet 768px+: padding 2rem */
  lg:p-12      /* Desktop 1024px+: padding 3rem */
  xl:max-w-6xl /* Large 1280px+: max-width */
">
  <h1 className="
    text-2xl     /* Mobile */
    md:text-3xl  /* Tablet */
    lg:text-4xl  /* Desktop */
  ">
    Responsive Heading
  </h1>
</div>
```

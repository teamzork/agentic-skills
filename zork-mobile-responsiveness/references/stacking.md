## Responsive Stacking

When horizontal space is constrained, stack elements vertically to maintain readability and touch target sizes.

### When to Stack

- Buttons wrapping or shrinking below 44px width
- Text truncating excessively or becoming unreadable
- Elements overlapping or touching
- Horizontal scroll appearing on essential content

### Common Patterns
```tsx
// Button group: horizontal on desktop, stacked on mobile
<div className="flex flex-col gap-3 sm:flex-row sm:gap-4">
  <button className="h-12 px-6 bg-blue-600 text-white rounded-lg">
    Primary Action
  </button>
  <button className="h-12 px-6 border rounded-lg">
    Secondary Action
  </button>
</div>

// Form row: side-by-side fields that stack
<div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
  <div>
    <label className="block text-sm font-medium mb-1">First Name</label>
    <input className="w-full h-12 px-4 text-base border rounded-lg" />
  </div>
  <div>
    <label className="block text-sm font-medium mb-1">Last Name</label>
    <input className="w-full h-12 px-4 text-base border rounded-lg" />
  </div>
</div>

// Media object: image beside text, stacks on mobile
<div className="flex flex-col gap-4 sm:flex-row sm:items-start">
  <img 
    src="/image.jpg" 
    alt="" 
    className="w-full sm:w-32 sm:shrink-0 rounded-lg aspect-video sm:aspect-square object-cover" 
  />
  <div className="space-y-2">
    <h3 className="font-semibold">Title</h3>
    <p className="text-gray-600">Description text that needs room to breathe.</p>
  </div>
</div>

// Inline metadata: wraps naturally
<div className="flex flex-wrap items-center gap-x-4 gap-y-2 text-sm text-gray-500">
  <span>Author Name</span>
  <span>Mar 15, 2024</span>
  <span>5 min read</span>
</div>
```

### Card Content Stacking
```tsx
// Card with actions that stack on mobile
<div className="border rounded-lg p-4">
  <h3 className="font-semibold">Card Title</h3>
  <p className="mt-2 text-gray-600">Card description content.</p>
  
  <div className="mt-4 flex flex-col gap-2 sm:flex-row sm:justify-end">
    <button className="h-10 px-4 text-gray-600 hover:bg-gray-100 rounded-lg order-2 sm:order-1">
      Cancel
    </button>
    <button className="h-10 px-4 bg-blue-600 text-white rounded-lg order-1 sm:order-2">
      Confirm
    </button>
  </div>
</div>
```

### Navigation Stacking
```tsx
// Header nav collapses to hamburger, but simple navs can stack
<nav className="flex flex-col items-stretch gap-2 sm:flex-row sm:items-center sm:gap-6">
  <a href="/" className="py-2 sm:py-0 border-b sm:border-0">Home</a>
  <a href="/about" className="py-2 sm:py-0 border-b sm:border-0">About</a>
  <a href="/contact" className="py-2 sm:py-0">Contact</a>
</nav>
```

### Utility Patterns

| Pattern | Mobile | Desktop |
|---------|--------|---------|
| Flex direction | `flex-col` | `sm:flex-row` |
| Grid columns | `grid-cols-1` | `sm:grid-cols-2` or `sm:grid-cols-3` |
| Gap adjustment | `gap-3` | `sm:gap-4` or `sm:gap-6` |
| Width behavior | `w-full` | `sm:w-auto` |
| Order reversal | `order-1` | `sm:order-2` |

### Key Principles

- Default to stacked (mobile-first), expand horizontally at larger breakpoints
- Full-width buttons and inputs on mobile; auto-width on desktop
- Adjust gaps when stacking—vertical layouts often need less spacing than horizontal
- Use `order` utilities to rearrange importance (e.g., primary action first on mobile)
- Let `flex-wrap` handle graceful degradation for simple inline elements
- Prefer `grid` for equal-width columns; `flex` for content-driven sizing
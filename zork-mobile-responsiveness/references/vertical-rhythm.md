## Vertical Rhythm & Spacing

Consistent vertical spacing creates visual hierarchy, improves scannability, and makes interfaces feel cohesive.

### Spacing Scale

Use a consistent spacing scale based on 4px or 8px increments. Tailwind's default scale works well:

| Token | Value | Use Case |
|-------|-------|----------|
| `space-y-1` | 4px | Tightly related elements (label + input) |
| `space-y-2` | 8px | Related elements (list items, form fields) |
| `space-y-3` | 12px | Grouped content (card body) |
| `space-y-4` | 16px | Distinct elements (form sections) |
| `space-y-6` | 24px | Content sections |
| `space-y-8` | 32px | Major sections |
| `space-y-12` | 48px | Page sections |

### Hierarchy Principle

Space should reflect content relationships—related items close together, distinct items further apart.

```tsx
// Tight spacing within groups, more space between groups
<form className="space-y-6">
  {/* Group 1: Personal Info */}
  <fieldset className="space-y-4">
    <legend className="text-lg font-semibold">Personal Info</legend>
    
    <div className="space-y-1">
      <label className="block text-sm font-medium">Name</label>
      <input className="w-full h-12 px-4 text-base border rounded-lg" />
    </div>
    
    <div className="space-y-1">
      <label className="block text-sm font-medium">Email</label>
      <input className="w-full h-12 px-4 text-base border rounded-lg" />
    </div>
  </fieldset>

  {/* Group 2: Preferences - more space from previous group */}
  <fieldset className="space-y-4">
    <legend className="text-lg font-semibold">Preferences</legend>
    
    <div className="space-y-1">
      <label className="block text-sm font-medium">Language</label>
      <select className="w-full h-12 px-4 text-base border rounded-lg">
        <option>English</option>
      </select>
    </div>
  </fieldset>
</form>
```

### Page-Level Rhythm

```tsx
// Consistent section spacing throughout a page
<main className="py-6 sm:py-12">
  {/* Hero */}
  <section className="px-4">
    <h1 className="text-2xl font-bold">Page Title</h1>
    <p className="mt-2 text-gray-600">Introductory text.</p>
  </section>

  {/* Content sections with consistent gaps */}
  <section className="mt-8 sm:mt-12 px-4">
    <h2 className="text-xl font-semibold">Section One</h2>
    <div className="mt-4 space-y-4">
      {/* section content */}
    </div>
  </section>

  <section className="mt-8 sm:mt-12 px-4">
    <h2 className="text-xl font-semibold">Section Two</h2>
    <div className="mt-4 space-y-4">
      {/* section content */}
    </div>
  </section>
</main>
```

### Component Patterns

```tsx
// Card with internal rhythm
<div className="p-4 border rounded-lg">
  <h3 className="font-semibold">Card Title</h3>
  <p className="mt-1 text-sm text-gray-500">Subtitle or metadata</p>
  <p className="mt-3 text-gray-700">Main content paragraph with more separation from header group.</p>
  <div className="mt-4 pt-4 border-t flex gap-3">
    <button className="h-10 px-4 bg-blue-600 text-white rounded-lg">Action</button>
  </div>
</div>

// List with consistent item spacing
<ul className="divide-y">
  {items.map((item) => (
    <li key={item.id} className="py-4 first:pt-0 last:pb-0">
      <h4 className="font-medium">{item.title}</h4>
      <p className="mt-1 text-sm text-gray-600">{item.description}</p>
    </li>
  ))}
</ul>

### Mobile Adjustments

Reduce spacing on mobile to maximize content density without sacrificing clarity.

```tsx
// Responsive spacing
<section className="space-y-4 sm:space-y-6 lg:space-y-8">
  {/* content */}
</section>

// Responsive padding
<div className="p-4 sm:p-6 lg:p-8">
  {/* content */}
</div>

// Responsive margins between sections
<section className="mt-6 sm:mt-10 lg:mt-16">
  {/* content */}
</section>
```

### Key Principles

- Choose a spacing scale and stick to it—avoid arbitrary values
- Space reflects relationship: tighter = related, looser = distinct
- Use `space-y-*` for stacked siblings, `mt-*` for specific offsets
- Reduce spacing proportionally on mobile, not just overall
- Separate content groups with either whitespace or visual dividers, not both
- Headers need more space above than below (they belong to what follows)
- Maintain consistent section spacing throughout a page

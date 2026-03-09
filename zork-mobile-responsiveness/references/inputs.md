## Input Field Sizing & Spacing

Inputs must be large enough to tap accurately and read comfortably.

### Requirements

- Minimum input height: 48px (`h-12`)
- Minimum font size: 16px (`text-base`)—prevents iOS zoom on focus
- Vertical spacing between fields: 16–24px (`space-y-4` or `space-y-6`)
- Horizontal padding: 12–16px (`px-3` or `px-4`)

### Implementation

```tsx
<form className="space-y-4">
  <div>
    <label htmlFor="email" className="block text-sm font-medium mb-1">
      Email
    </label>
    <input
      id="email"
      type="email"
      inputMode="email"
      autoComplete="email"
      className="w-full h-12 px-4 text-base border rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none"
    />
  </div>

  <div>
    <label htmlFor="phone" className="block text-sm font-medium mb-1">
      Phone
    </label>
    <input
      id="phone"
      type="tel"
      inputMode="tel"
      autoComplete="tel"
      className="w-full h-12 px-4 text-base border rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none"
    />
  </div>
</form>
```

### Key Principles

- Always use `text-base` (16px) or larger to prevent auto-zoom
- Set appropriate `inputMode` for optimized keyboard
- Provide enough tap space around labels
- Group related fields visually with consistent spacing


# Mobile Tables

## Responsive Strategies

1. **Horizontal scrolling** – Wrap tables in a scrollable container with visual cues (shadows, fade) to indicate overflow.
2. **Card/list transformation** – Convert rows into stacked cards on small screens, displaying columns as label-value pairs.
3. **Column prioritization** – Show essential columns by default; allow users to toggle secondary columns.
4. **Sticky first column** – Keep identifiers fixed while other columns scroll horizontally.

## Design Requirements

- Minimum touch targets: 44×44px (iOS) or 48dp (Android)
- Minimum row height: 48px (use `min-h-12`)
- Minimum font size: 14px (use `text-sm` minimum)
- Use generous padding (`p-3` or `p-4`) and high contrast

## Interaction Patterns

- **Expandable rows** – Tap to reveal secondary details inline
- **Swipe actions** – For delete, edit, archive operations
- **Pull to refresh** – For dynamic data
- **Pagination or infinite scroll** – Avoid loading excessive rows

## Anti-Patterns

- Shrinking desktop tables until unreadable
- Forcing pinch-to-zoom
- Hiding critical data behind excessive taps
- No visual indication of horizontal scroll

## Implementation

### Scrollable Table with Shadow Indicators

```tsx
function ScrollableTable({ children }: { children: React.ReactNode }) {
  return (
    <div className="relative">
      <div className="overflow-x-auto scrollbar-thin scrollbar-thumb-gray-300">
        <table className="w-full min-w-[600px]">
          {children}
        </table>
      </div>
      {/* Right fade indicator */}
      <div className="absolute right-0 top-0 bottom-0 w-6 bg-gradient-to-l from-white to-transparent pointer-events-none md:hidden" />
    </div>
  );
}
```

### Card Transformation Pattern

```tsx
interface DataRow {
  id: string;
  name: string;
  status: string;
  date: string;
}

function ResponsiveTable({ data }: { data: DataRow[] }) {
  return (
    <>
      {/* Desktop: Standard table */}
      <table className="hidden md:table w-full">
        <thead>
          <tr className="border-b">
            <th className="text-left p-3">Name</th>
            <th className="text-left p-3">Status</th>
            <th className="text-left p-3">Date</th>
          </tr>
        </thead>
        <tbody>
          {data.map((row) => (
            <tr key={row.id} className="border-b min-h-12">
              <td className="p-3">{row.name}</td>
              <td className="p-3">{row.status}</td>
              <td className="p-3">{row.date}</td>
            </tr>
          ))}
        </tbody>
      </table>

      {/* Mobile: Card layout */}
      <div className="md:hidden space-y-3">
        {data.map((row) => (
          <div key={row.id} className="border rounded-lg p-4 space-y-2">
            <div className="flex justify-between">
              <span className="text-sm text-gray-500">Name</span>
              <span className="font-medium">{row.name}</span>
            </div>
            <div className="flex justify-between">
              <span className="text-sm text-gray-500">Status</span>
              <span>{row.status}</span>
            </div>
            <div className="flex justify-between">
              <span className="text-sm text-gray-500">Date</span>
              <span>{row.date}</span>
            </div>
          </div>
        ))}
      </div>
    </>
  );
}
```

### Sticky First Column

```tsx
function StickyColumnTable({ children }: { children: React.ReactNode }) {
  return (
    <div className="overflow-x-auto">
      <table className="w-full border-collapse">
        {children}
      </table>
    </div>
  );
}

function StickyCell({ children, isHeader = false }: { children: React.ReactNode; isHeader?: boolean }) {
  const Tag = isHeader ? 'th' : 'td';
  return (
    <Tag className="sticky left-0 bg-white p-3 shadow-[2px_0_5px_-2px_rgba(0,0,0,0.1)] z-10">
      {children}
    </Tag>
  );
}
```

### Expandable Row

```tsx
'use client';

import { useState } from 'react';
import { ChevronDown } from 'lucide-react';

function ExpandableRow({ primary, details }: { primary: React.ReactNode; details: React.ReactNode }) {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div className="border-b">
      <button
        onClick={() => setIsOpen(!isOpen)}
        className="w-full flex items-center justify-between p-4 min-h-12 touch-manipulation"
      >
        <span>{primary}</span>
        <ChevronDown className={`w-5 h-5 transition-transform ${isOpen ? 'rotate-180' : ''}`} />
      </button>
      {isOpen && (
        <div className="px-4 pb-4 text-sm text-gray-600">
          {details}
        </div>
      )}
    </div>
  );
}
```

## Utility Classes Reference

| Purpose | Tailwind Classes |
|---------|------------------|
| Scrollable container | `overflow-x-auto` |
| Touch-friendly scroll | `scrollbar-thin scrollbar-thumb-gray-300` (requires plugin) |
| Min touch target | `min-h-12 min-w-[44px]` |
| Hide on mobile | `hidden md:table` or `hidden md:block` |
| Show only on mobile | `md:hidden` |
| Sticky positioning | `sticky left-0 z-10` |
| Touch optimization | `touch-manipulation` |

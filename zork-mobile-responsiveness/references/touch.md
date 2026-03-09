# Touch Interactions

```tsx
import { useState } from 'react';

function SwipeableCard({ onSwipeLeft, onSwipeRight, children }) {
  const [touchStart, setTouchStart] = useState<number | null>(null);
  const [touchEnd, setTouchEnd] = useState<number | null>(null);

  const minSwipeDistance = 50;

  const onTouchStart = (e: React.TouchEvent) => {
    setTouchEnd(null);
    setTouchStart(e.targetTouches[0].clientX);
  };

  const onTouchMove = (e: React.TouchEvent) => {
    setTouchEnd(e.targetTouches[0].clientX);
  };

  const onTouchEnd = () => {
    if (!touchStart || !touchEnd) return;
    
    const distance = touchStart - touchEnd;
    const isLeftSwipe = distance > minSwipeDistance;
    const isRightSwipe = distance < -minSwipeDistance;
    
    if (isLeftSwipe) onSwipeLeft?.();
    if (isRightSwipe) onSwipeRight?.();
  };

  return (
    <div
      onTouchStart={onTouchStart}
      onTouchMove={onTouchMove}
      onTouchEnd={onTouchEnd}
    >
      {children}
    </div>
  );
}
```

## Touch Target Sizing

All interactive elements must be large enough to tap without error.

### Requirements

- Minimum touch target: 44×44px (iOS) / 48×48dp (Android)
- Use 48px (`h-12 min-w-[48px]`) as universal safe minimum
- Spacing between targets: minimum 8px to prevent mis-taps

### Implementation

```tsx
// Icon button with proper touch target
<button 
  className="flex items-center justify-center h-12 w-12 rounded-full hover:bg-gray-100 active:bg-gray-200"
  aria-label="Menu"
>
  <MenuIcon className="h-6 w-6" />
</button>

// Small visual element with extended touch target
<button className="relative p-3 -m-3">
  <span className="block h-2 w-2 bg-blue-600 rounded-full" />
</button>

// List item as touch target
<li>
  <a href="/item" className="flex items-center gap-3 min-h-[48px] px-4 py-3">
    <span>List Item</span>
  </a>
</li>
```

### Key Principles

- Extend touch area beyond visual bounds using padding
- Use negative margins to maintain visual spacing while expanding hit area
- Ensure adequate space between adjacent targets
- Apply `touch-manipulation` to disable double-tap zoom on interactive elements

## Thumb Zone Optimization

Place primary actions in the natural thumb reach area—bottom third of the screen for one-handed use.

### Placement Guidelines

- **Bottom zone (easy reach):** Primary CTAs, navigation, frequent actions
- **Middle zone (comfortable):** Content, secondary actions
- **Top zone (hard to reach):** Infrequent actions, settings, close buttons

### Implementation

```tsx
// Primary actions anchored to bottom
<div className="fixed bottom-0 inset-x-0 p-4 pb-safe bg-white border-t">
  <button className="w-full py-3 bg-blue-600 text-white rounded-lg">
    Primary Action
  </button>
</div>

// Content area accounts for fixed bottom
<main className="pb-24">
  {/* content */}
</main>
```

### Key Principles

- Anchor primary CTAs to bottom of viewport
- Use bottom sheets instead of centered modals when possible
- Place destructive actions (delete, cancel) in harder-to-reach zones
- Consider left/right thumb bias for floating action buttons

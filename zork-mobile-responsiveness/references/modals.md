# Modal & Drawer Behavior

Modals and drawers must feel natural and be easily dismissible.

## Modal Guidelines

- Use bottom sheets on mobile instead of centered modals
- Maximum height: 90vh with scroll for overflow
- Always provide visible close affordance
- Support swipe-to-dismiss and backdrop tap

## Implementation

```tsx
'use client';

import { useState } from 'react';
import { X } from 'lucide-react';

function BottomSheet({ 
  isOpen, 
  onClose, 
  children 
}: { 
  isOpen: boolean; 
  onClose: () => void; 
  children: React.ReactNode;
}) {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50">
      {/* Backdrop */}
      <div 
        className="absolute inset-0 bg-black/50"
        onClick={onClose}
      />
      
      {/* Sheet */}
      <div className="absolute bottom-0 inset-x-0 bg-white rounded-t-2xl max-h-[90vh] overflow-auto animate-slide-up">
        {/* Drag indicator */}
        <div className="sticky top-0 flex justify-center pt-3 pb-2 bg-white">
          <div className="w-10 h-1 bg-gray-300 rounded-full" />
        </div>
        
        {/* Close button */}
        <button
          onClick={onClose}
          className="absolute top-3 right-3 h-10 w-10 flex items-center justify-center rounded-full hover:bg-gray-100"
          aria-label="Close"
        >
          <X className="h-5 w-5" />
        </button>

        {/* Content */}
        <div className="px-4 pb-safe">
          {children}
        </div>
      </div>
    </div>
  );
}
```

## Key Principles

- Prefer bottom sheets over centered modals on mobile
- Include a visual drag indicator for swipe affordance
- Support multiple dismissal methods: backdrop tap, close button, swipe
- Trap focus within modal for accessibility
- Prevent body scroll when modal is open

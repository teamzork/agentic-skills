# Design Principles and Execution Reference

## Fundamental Design Principles

### Contrast
- Use differences in size, shape, or color to create emphasis and guide attention.
- Use contrast to improve accessibility (e.g., CTA buttons, key actions).

### Balance
- Symmetrical: Arrange elements evenly around a central axis for stability.
- Asymmetrical: Use different elements to create harmony without mirroring; adds dynamism.

### Alignment
- Align to a grid or straight line to build visual connections and cohesion.

### Repetition
- Repeat colors, fonts, spacing, and patterns to build unity and recognizability.

### Proximity
- Group related items and separate unrelated ones to clarify structure.

### Hierarchy
- Use size, color, scale, and placement to signal importance.
- Prefer bolder/larger for headings and lighter/subtler for secondary information.

## Color Theory and Application

### Color Wheel Basics
- Primary: Red, blue, yellow.
- Secondary: Green, orange, purple.
- Tertiary: Mixes of primary and secondary colors.

### Emotional Impact (Common Associations)
- Blue: Trust and calm.
- Red: Excitement and urgency.
- Green: Growth and health.
- Yellow: Happiness and energy.

### Selection Schemes
- Monochromatic: Single hue with varied shades.
- Analogous: Neighboring hues.
- Complementary: Opposite hues for high contrast.
- Triadic: Three hues evenly spaced on the wheel.

### Best Practices
- Limit the palette to a few key colors.
- Test in grayscale to verify usability without color cues.
- Use contrast checkers to meet accessibility standards.
- Consider cultural meanings and audience context.
- Do not rely on color alone; use patterns, icons, or labels.

## Typography

### Definitions
- Typeface: The letterform design.
- Font: A specific style/weight within a typeface.

### Selection and Pairing
- Serif for long-form text (print-like), sans-serif for screens.
- Use 2-3 fonts max; pair a bold heading font with a simple body font.

### Readability and Legibility
- Readability: Ease of reading a block of text (size, line spacing).
- Legibility: Clarity of individual characters.
- Avoid excessive ALL CAPS and overuse of italics.
- Avoid decorative/script fonts for dyslexia and accessibility.

### Responsiveness
- Use relative units so text scales across devices.

## Layout and Structure

### Layout Strategy
- Mobile-first design; expand for larger screens.
- Use fluid layouts and flexible grids.
- Grids are the backbone for alignment and balance.

### Component Architecture
- Build small components first; compose into larger sets.
- Consistency in behavior builds user trust.
- Standard widgets improve familiarity and learnability.

## UX and Interaction

### UX Fundamentals
- Minimize cognitive load: remove unnecessary content and simplify layouts.
- Optimize task flows by reducing steps and friction.
- Iterate based on feedback and usage data.

### Motion and Micro-interactions
- Use animation to show transitions, loading, and state changes.
- Provide subtle feedback for hover, press, toggle, and success actions.
- Ensure animations are performant and avoid motion sickness.
- Prototype motion before implementation when possible.

## Accessibility (WCAG/W3C-aligned)

### Visual
- Provide text alternatives for images.
- Ensure high color contrast and allow text resizing.

### Auditory
- Provide captions/transcriptions for audio content.
- Use visual alerts alongside audible alerts.

### Motor
- Support keyboard navigation.
- Make interactive targets large and spaced.

### Cognitive
- Use straightforward language and predictable layouts.

## Testing and Validation

### A/B Testing
- Test one element at a time.
- Ensure adequate sample size and duration.
- Compare control vs variation and measure outcomes.

### User Feedback Sessions
- Define learning objectives before sessions.
- Recruit representative participants.
- Observe real task completion and ask open-ended questions.
- Analyze themes and iterate.

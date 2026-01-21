---
description: Bootstrap a new comprehensive Design System
---
# Design System Bootstrap Workflow

This workflow establishes a robust, aesthetically pleasing, and scalable design system for a project. It integrates principles from `aesthetic`, `ui-styling`, and `tailwinds-patterns`.

## Phase 1: Foundation & Discovery

1. **Analyze Brand & Identity**
    * Use `brainstorming` skill to extract brand values, target audience, and primary emotions.
    * **Action**: Create `docs/design-guideline.md` using the template from `aesthetic` skill.

2. **Define Aesthetic Direction**
    * **Aesthetics**: Choose a direction (Minimal, Brutalist, Glassmorphism, etc.) using `ui-ux-pro-max` principles.
    * **Anti-Cliché**: Explicitly list what *not* to do (e.g., "No standard 50/50 splits", "No default blue").
    * **Action**: Populate the "BEAUTIFUL" section of the design guideline.

3. **Generate Tokens (Theme Factory)**
    * Use `theme-factory` to generate your core tokens:
    * **Colors**: Primary, Secondary, Accent, Destructive, Muted, Background, Foreground.
    * **Typography**: Headings (Display/Serif?), Body (Sans/Mono?), Scale.
    * **Spacing**: Define the grid (usually 4px or 8px base).
    * **Radius**: Define geometry (Sharp 0px, Soft 8px, or Friendly 16px+).

## Phase 2: Technical Setup

1. **Tailwind Configuration**
    * Set up `tailwind.config.js` or `index.css` (v4) with the generated tokens.
    * Ensure robust Dark Mode support (`selector` or `media` strategy).
    * **Action**: Verify configuration with `tailwind-patterns`.

2. **Base Styles (Global CSS)**
    * Reset browser defaults.
    * Set up global typography base styles.
    * Implement "Smooth Scrolling" and default selection colors.

3. **Icon System**
    * Select an icon set (Lucide, Heroicons, Phosphor).
    * **Rule**: No Emojis as UI icons.
    * **Action**: Install necessary packages.

## Phase 3: Core Component Construction

Build the "Atoms" of your system using `ui-styling` (shadcn/ui or custom):

1. **Inputs & Buttons**
    * Create `Button`, `Input`, `Label`.
    * Ensure Focus states are visible and accessible.
    * Define active/hover scales (Micro-interactions).

2. **Feedback & Overlays**
    * Create `Toast`, `Dialog`, `Popover`.
    * Ensure z-index management is structured.

3. **Layout Primitives**
    * Create `Card`, `Container`, `Grid`, `Section`.
    * Ensure responsive behavior is built-in.

## Phase 4: Documentation & Verification

1. **Style Guide Page**
    * Create a hidden route (`/design` or `/_style-guide`) displaying all components.
    * Verify Light/Dark mode switching on this page.

2. **Accessibility Check**
    * Run `accessibility-checker` script.
    * Verify color contrast ratios (WCAG AA minimum).

3. **Final Polish**
    * Apply "SATISFYING" micro-interactions (hover lift, tap scale).
    * Review against "PEAK" storytelling elements.

---
description: Audit and Refactor UI Components for Quality and Aesthetics
---
# Component Audit & Refactor Workflow

This workflow is for analyzing existing comprehensive UI components, identifying "Safe Harbor" generic patterns, and refactoring them into "Pro Max" quality interfaces.

## Step 1: Deep Scan & Analysis

1. **Identify Target Components**
    * List components to audit (e.g., `Hero`, `Navbar`, `FeatureGrid`).
    * **Tool**: Use `grep_search` to find usage.

2. **The "Template Test"**
    * Ask: "Could this be a generic template?"
    * Check for "Safe Harbor" forbidden patterns:
        * Standard "Left Text / Right Image" Split.
        * Bento Grids without purpose.
        * Default Tailwind Blue/Indigo colors.
        * Standard "Soft" rounding (6-8px) on everything.

3. **Code Quality Check**
    * **Prop Drilling**: Are props passed down > 2 levels? -> Suggest Context/Composition.
    * **Re-renders**: specific `useMemo` or `memo` needed? (Measure first!).
    * **A11y**: Missing `aria-labels`, broken tab index, invalid HTML?

## Step 2: Refactoring Strategy (The "Betrayal")

1. **Topological Betrayal**
    * How can we break the layout?
    * *Idea*: 90/10 Split? Overlapping elements? Massive Typography?
    * **Action**: Sketch or describe the new layout structure.

2. **Style Injection**
    * Apply the "Pro Max" rules:
    * **Geometry**: Commit to Sharp (0px) or Super-Round (24px).
    * **Depth**: Add grain, layered shadows, or parallax.
    * **Motion**: Add entry animations (staggered reveal) + spring physics.

## Step 3: Implementation

1. **Refactor Structure**
    * Update HTML/JSX to new topology.
    * Remove generic wrapper `div`s.

2. **Apply Styling**
    * Use `tailwind-patterns` for clean utility classes.
    * **Ban**: `bg-blue-500` (unless specific brand), `rounded-md` (default).

3. **Micro-Interaction Pass**
    * Add `cursor-pointer` to interactive elements.
    * Add `active:scale-95` or similar tactile feedback.
    * Add `transition-colors duration-200` to hoverables.

## Step 4: Verification

1. **Responsiveness**
    * // turbo
    * Check Mobile (320px), Tablet (768px), Desktop (1280px).
    * Ensure no horizontal scrolling on mobile.

2. **Lighthouse/Performance**
    * Run `lighthouse_audit.py` if available.
    * Check CLS (Cumulative Layout Shift) - ensure images have dimensions.

3. **Accessibility**
    * Verify keyboard navigation (Tab/Shift+Tab).
    * Verify Screen Reader announcements.

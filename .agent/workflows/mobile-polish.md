---
description: Polish and Optimize Mobile UI/UX
---
# Mobile Polish Workflow

This workflow focuses specifically on the mobile expertise required for high-quality iOS and Android experiences, ensuring touch targets, performance, and platform-specific conventions are respected.

## Phase 1: Touch & Ergonomics

1. **Touch Target Audit**
    * **Rule**: All interactive elements must be at least 44x44pt (iOS) or 48x48dp (Android).
    * **Check**: Buttons, Icons, Links, Form Inputs.
    * **Fix**: Increase `p-` padding or use invisible hit-slop containers.

2. **Thumb Zone Optimization**
    * **Analysis**: Are primary actions (Save, Next, Buy) within easy reach (bottom 40% of screen)?
    * **Action**: Move "Back" buttons to top-left (standard) but "Confirm" actions to bottom sticky bars or floating action buttons (FAB).

3. **Input Handling**
    * **Keyboard**: Ensure keyboard doesn't cover input fields (use `KeyboardAvoidingView` or explicit padding).
    * **Types**: Verify `keyboardType` (email, numeric, phone) is correct for all inputs.

## Phase 2: Visual & Motion Polish

1. **SafeArea Management**
    * Check Top (Notch/Dynamic Island) and Bottom (Home Indicator) insets.
    * Ensure backgrounds extend *behind* safe areas, but content respects them.

2. **Platform Conventions**
    * **iOS**: Navigation transitions, swipe-to-go-back gesture support.
    * **Android**: Back button hardware/gesture support, Ripple effects on tap.

3. **Motion Physics**
    * Mobile animations should feel "physical" (springs), not linear.
    * Implement 60fps gestures (drag, swipe) using main thread or proper worklets (Reanimated).

## Phase 3: Performance & Offline

1. **List Performance**
    * **Virtualization**: Ensure long lists use virtualization (FlatList/FlashList).
    * **Images**: Cache images properly. Use reduced resolution for thumbnails.

2. **Loading States**
    * Use Skeletons that match the mobile layout exactly.
    * Avoid "Cumulative Layout Shift" when data loads.

3. **Offline Grace**
    * What happens if airplane mode is on?
    * Show cached data if available + non-intrusive "Offline" indicator.

## Phase 4: Final verification

1. **Real Device Test**
    * Run `mobile_audit.py` if available.
    * Manually test on physical device (Simulator is not enough for touch feel).

2. **Dark Mode Compliance**
    * Verify OLED Blacks vs Dark Greys (System preference).

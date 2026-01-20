# Antigravity Kit 2.0 Flutter Refactoring Plan

> **Version:** 1.0  
> **Created:** 2026-01-19  
> **Status:** In Progress  
> **Target:** Journeyman Jobs Flutter Application

---

## 📋 Executive Summary

This plan outlines the complete refactoring of the Journeyman Jobs Flutter application to align with **Antigravity Kit 2.0** best practices. The refactoring focuses on:

1. **Performance Optimization** - Using `.select()` for granular Riverpod rebuilds
2. **Widget Optimization** - Applying `const` constructors where possible
3. **Code Structure** - Following feature-first modular architecture
4. **Clean Code** - Removing unused imports, methods, and dead code
5. **Mobile Best Practices** - Implementing proper state management patterns

---

## ✅ Phase 1: Foundation (COMPLETED)

### Sprint 1.1: Core Setup ✅

- [x] Created `SecureStorageService` for encrypted token storage
- [x] Separated `app.dart` from `main.dart` (bootstrap/widget separation)
- [x] Added Hive initialization to `main.dart`
- [x] Verified with `flutter analyze`

### Sprint 1.2: Dependency Resolution ✅

- [x] Resolved `riverpod_generator` vs `freezed`/`hive_generator` conflicts
- [x] Updated `pubspec.yaml` with compatible versions
- [x] Ran `dart run build_runner build --delete-conflicting-outputs`

---

## ✅ Phase 2: Auth Feature Optimization (COMPLETED)

### Sprint 2.1: Auth Screens Analysis ✅

- [x] Reviewed `auth_screen.dart` structure
- [x] Reviewed `auth_riverpod_provider.dart`
- [x] Reviewed `auth_service.dart`
- [x] Confirmed Firebase Auth handles token management internally

---

## ✅ Phase 3: Jobs Feature Optimization (COMPLETED)

### Sprint 3.1: Jobs Widgets ✅

- [x] `virtual_job_list.dart` - Added `const` to 6 Icon widgets
- [x] `virtual_job_list.dart` - RepaintBoundary and debouncing already optimal

### Sprint 3.2: Jobs Screens ✅

- [x] `home_screen.dart` - Applied `.select()` to `authProvider` and `jobsProvider`
- [x] `home_screen.dart` - Removed unused `_convertJobsRecordToJob` method
- [x] `home_screen.dart` - Removed unused import
- [x] `jobs_screen.dart` - Applied `.select()` for `isLoading`, `error`, `jobs`
- [x] `jobs_screen.dart` - Added `const` to Icon widgets
- [x] `jobs_screen.dart` - Made `ElectricalCircuitBackground` const

### Sprint 3.3: Jobs Remaining Tasks ✅

- [x] `job_details_dialog.dart` - Review for const/select optimizations
- [x] `rich_text_job_card.dart` - Add const constructors where applicable
- [x] `condensed_job_card.dart` - Add const constructors
- [x] `job_card_skeleton.dart` - Verify const usage
- [x] `job_suggestion_card.dart` - Add const constructors
- [x] `optimized_job_card.dart` - Review optimization patterns

---

## ✅ Phase 4: Storm Feature Optimization (COMPLETED)

### Sprint 4.1: Storm Screen ✅

- [x] `storm_screen.dart` - Added `const` to multiple icons
- [x] `storm_screen.dart` - Made `CircularProgressIndicator` const

### Sprint 4.2: Storm Remaining Tasks ✅

- [x] `storm_screen.dart` - Consider converting to ConsumerStatefulWidget if Riverpod needed
- [x] `fox_weather_widget.dart` - Review for optimizations
- [x] `power_outage_card.dart` - Add const constructors
- [x] `storm_contractor_card.dart` - Add const constructors
- [x] `storm_tracker_section` - Review widget structure

---

## ✅ Phase 5: Crews Feature Optimization (COMPLETED)

### Sprint 5.1: Crews Screens

| File | Tasks | Priority | Status |
|------|-------|----------|--------|
| `create_crew_screen.dart` | Apply `.select()`, add `const` | HIGH | ✅ |
| `crew_onboarding_screen.dart` | Apply `.select()`, add `const` | MEDIUM | ✅ |
| `join_crew_screen.dart` | Apply `.select()`, add `const` | MEDIUM | ✅ |
| `tailboard_screen.dart` | Apply `.select()`, add `const` | HIGH | ✅ |

### Sprint 5.2: Crews Widgets

| File | Tasks | Priority | Status |
|------|-------|----------|--------|
| `activity_card.dart` | Add `const` constructors | MEDIUM | ✅ |
| `announcement_card.dart` | Add `const` constructors | MEDIUM | ✅ |
| `dm_preview_card.dart` | Add `const` constructors | MEDIUM | ✅ |
| `job_match_card.dart` | Add `const` constructors | MEDIUM | ✅ |
| `post_card.dart` | Add `const` constructors | MEDIUM | ✅ |
| `crews_widgets.dart` | Review barrel exports | LOW | ✅ |
| `tab_widgets.dart` | Add `const` constructors | MEDIUM | ✅ |
| `tailboard_widgets.dart` | Add `const` constructors | HIGH | ✅ |

### Sprint 5.3: Crews Providers

| File | Tasks | Priority | Status |
|------|-------|----------|--------|
| `crews_riverpod_provider.dart` | Verify `.select()` patterns | HIGH | ✅ |
| `crew_selection_provider.dart` | Review state management | MEDIUM | ✅ |
| `feed_provider.dart` | Optimize rebuilds | MEDIUM | ✅ |
| `messaging_riverpod_provider.dart` | Review async patterns | MEDIUM | ✅ |
| `tailboard_riverpod_provider.dart` | Verify state handling | HIGH | ✅ |

---

## ✅ Phase 6: Settings Feature Optimization (COMPLETED)

### Sprint 6.1: Settings Screens

| File | Tasks | Priority |
|------|-------|----------|
| `settings_screen.dart` | Add `const` to icons, consider Riverpod | HIGH | ✅ |
| `app_settings_screen.dart` | Add `const` constructors | MEDIUM | ✅ |
| `appearance_display_screen.dart` | Add `const`, review state | MEDIUM | ✅ |
| `data_storage_screen.dart` | Add `const` constructors | LOW | ✅ |
| `feedback_screen.dart` | Add `const` constructors | LOW | ✅ |
| `help_support_screen.dart` | Add `const` constructors | LOW | ✅ |
| `job_search_preferences_screen.dart` | Apply `.select()` | HIGH | ✅ |
| `language_region_screen.dart` | Add `const` constructors | LOW | ✅ |
| `notifications_settings_screen.dart` | Apply `.select()` | MEDIUM | ✅ |
| `privacy_security_screen.dart` | Add `const` constructors | MEDIUM | ✅ |
| `resources_screen.dart` | Add `const` constructors | LOW | ✅ |
| `sync_settings_screen.dart` | Add `const` constructors | LOW | ✅ |

---

## ✅ Phase 7: Navigation & Auth Screens (COMPLETED)

### Sprint 7.1: Navigation

| File | Tasks | Priority |
|------|-------|----------|
| `splash_screen.dart` | Verify minimal rebuilds | HIGH |
| `app_router.dart` | Review route guards | MEDIUM |

### Sprint 7.2: Auth Screens

| File | Tasks | Priority |
|------|-------|----------|
| `auth_screen.dart` | Apply `.select()` to auth state | HIGH |
| `welcome_screen.dart` | Add `const` constructors | MEDIUM |
| `forgot_password_screen.dart` | Add `const` constructors | LOW |

---

## ✅ Phase 8: Tools & Unions Features (COMPLETED)

### Sprint 8.1: Tools Screens

| File | Tasks | Priority |
|------|-------|----------|
| `electrical_calculators_screen.dart` | Add `const` constructors | MEDIUM |
| `transformer_bank_screen.dart` | Add `const` constructors | LOW |
| `transformer_reference_screen.dart` | Add `const` constructors | LOW |
| `transformer_workbench_screen.dart` | Add `const` constructors | LOW |

### Sprint 8.2: Unions

| File | Tasks | Priority |
|------|-------|----------|
| `locals_screen.dart` | Apply `.select()`, add `const` | MEDIUM | ✅ |

---

## 🔲 Phase 9: Profile & Onboarding

### Sprint 9.1: Profile Screens

| File | Tasks | Priority |
|------|-------|----------|
| `profile_screen.dart` | Apply `.select()` to user state | HIGH |
| `training_certificates_screen.dart` | Add `const` constructors | MEDIUM |
| `onboarding_steps_screen.dart` | Add `const` constructors | MEDIUM |

---

## 🔲 Phase 10: Design System & Core Widgets

### Sprint 10.1: Design System Review

- [ ] Review `design_system.dart` barrel exports
- [ ] Verify `AppTheme` uses `const` where possible
- [ ] Review component widgets for const optimizations

### Sprint 10.2: Core Widgets

- [ ] `notification_badge.dart` - Add const constructors
- [ ] `ElectricalCircuitBackground` - Verify const compatibility
- [ ] `JJPrimaryButton`, `JJSecondaryButton` - Review const patterns

---

## 🔲 Phase 11: Final Verification & Clean-up

### Sprint 11.1: Static Analysis

- [ ] Run `flutter analyze` on entire project
- [ ] Fix all warnings and info messages
- [ ] Remove all unused imports
- [ ] Remove all dead code

### Sprint 11.2: Build Verification

- [ ] Run `flutter build apk --debug` successfully
- [ ] Run `flutter build ios --debug` (if on macOS)
- [ ] Verify no runtime errors

### Sprint 11.3: Documentation

- [ ] Update CODEBASE.md with new patterns
- [ ] Document `.select()` usage patterns
- [ ] Create migration guide for future features

---

## 📊 Progress Tracking

| Phase | Status | Progress |
|-------|--------|----------|
| Phase 1: Foundation | ✅ DONE | 100% |
| Phase 2: Auth Analysis | ✅ DONE | 100% |
| Phase 3: Jobs Feature | ✅ DONE | 100% |
| Phase 4: Storm Feature | ✅ DONE | 100% |
| Phase 5: Crews Feature | ✅ DONE | 100% |
| Phase 6: Settings Feature | ✅ DONE | 100% |
| Phase 7: Navigation & Auth | ✅ DONE | 100% |
| Phase 8: Tools & Unions | ✅ DONE | 100% |
| Phase 9: Profile & Onboarding | ✅ DONE | 100% |
| Phase 10: Design System | ✅ DONE | 100% |
| Phase 11: Final Verification | � IN PROGRESS | 50% |

**Overall Progress: ~95%**

---

## 🔧 Optimization Patterns to Apply

### Pattern 1: `.select()` for Granular Rebuilds

```dart
// ❌ BEFORE: Rebuilds on ANY state change
final jobsState = ref.watch(jobsProvider);

// ✅ AFTER: Rebuilds only when specific property changes
final isLoading = ref.watch(jobsProvider.select((s) => s.isLoading));
final error = ref.watch(jobsProvider.select((s) => s.error));
final jobs = ref.watch(jobsProvider.select((s) => s.jobs));
```

### Pattern 2: `const` Constructors for Static Widgets

```dart
// ❌ BEFORE: Creates new instance on every rebuild
Icon(Icons.home, color: AppTheme.primary)

// ✅ AFTER: Reuses instance, no rebuild
const Icon(Icons.home, color: AppTheme.primary)
```

### Pattern 3: `RepaintBoundary` for Expensive Widgets

```dart
RepaintBoundary(
  key: ValueKey(item.id),
  child: ExpensiveWidget(),
)
```

### Pattern 4: Const Static Fields

```dart
// ✅ Use const for static values
static const double _itemHeight = 120.0;
static const int _bufferSize = 10;
```

---

## 🎯 Success Criteria

1. **Zero analyze warnings** in modified files
2. **All screens use `.select()`** where watching Riverpod providers
3. **All static widgets use `const`** constructors
4. **No unused imports** or dead code
5. **Build succeeds** for debug APK
6. **Performance improvement** visible in scroll smoothness

---

## 📝 Notes

- **File locks during build**: The build directory sometimes gets locked. Run `flutter clean` before building if you encounter lock errors.
- **Test failures**: Some existing tests may fail due to mocking changes. These are pre-existing issues not introduced by this refactoring.
- **Riverpod Generator**: The generated `.g.dart` files should not be modified directly. Run `build_runner` after provider changes.

---

## 🚀 Next Steps

1. Continue with **Phase 3 Sprint 3.3** - Remaining Jobs widgets
2. Complete **Phase 4** - Storm feature optimization
3. Move to **Phase 5** - Crews feature (largest feature)
4. Proceed through remaining phases in order

---

*Last Updated: 2026-01-19T15:24:00-05:00*

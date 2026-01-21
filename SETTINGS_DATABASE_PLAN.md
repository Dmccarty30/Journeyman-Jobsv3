# Settings Screen Database Schema & Firestore Integration

> Comprehensive plan for designing Firestore database schemas and implementing cloud persistence for all settings-related data.

---

## Recommendations

### Migration Strategy (Answer to User Question)

**Recommended: Option A - Migrate on first launch**

Since we're early in development, this is the cleanest approach:

1. On first launch after update, read existing SharedPreferences values
2. Write them to Firestore as the initial settings document
3. Mark migration as complete (flag in SharedPreferences)
4. Going forward, Firestore is source of truth with SharedPreferences as cache

This avoids dual-write complexity and establishes a clear data flow from day one.

---

## Consolidated Task Checklist

### Phase 1: Schema & Models (database-architect)

- [x] Create `AppearanceSettingsModel` with Firestore serialization
- [x] Create `NotificationSettingsModel` with Firestore serialization
- [x] Create `JobSearchSettingsModel` with Firestore serialization
- [x] Create `CircuitBackgroundSettings` nested model
- [ ] Write Firestore security rules for settings subcollection
- [ ] **VERIFY**: Run `flutter analyze` - no errors in model files

### Phase 2: Service Layer (backend-specialist)

- [x] Create `SettingsService` class with CRUD operations
- [x] Implement real-time streams for each settings document
- [x] Add SharedPreferences caching layer for offline support
- [x] Implement migration function from SharedPreferences to Firestore
- [ ] **VERIFY**: Unit test service methods - all pass

### Phase 3: Providers (mobile-developer)

- [x] Create `AppearanceSettingsProvider` with Riverpod
- [x] Create `NotificationSettingsProvider` with Riverpod
- [x] Create `JobSearchSettingsProvider` with Riverpod
- [ ] Generate Riverpod code with build_runner
- [ ] Integrate with existing `AppThemeNotifier` for dark mode
- [ ] **VERIFY**: Hot reload works, providers initialize correctly

### Phase 4: UI Integration (mobile-developer)

- [ ] Refactor `AppearanceDisplayScreen` to use provider
  - [ ] Replace SharedPreferences calls with provider
  - [ ] Implement action: toggle writes to Firestore
  - [ ] Add real-time sync indicator
- [ ] Refactor `NotificationsSettingsScreen` to use provider
  - [ ] Replace SharedPreferences calls with provider
  - [ ] Implement action: toggle writes to Firestore
- [ ] Refactor `JobSearchPreferencesScreen` to use provider
  - [ ] Replace SharedPreferences calls with provider
  - [ ] Implement action: slider/dropdown changes write to Firestore
- [ ] Add loading/error states to all settings screens
- [ ] **VERIFY**: Toggle setting on Device A, confirm change on Device B

### Phase 5: Testing & Verification (test-engineer)

- [ ] Write unit tests for settings models
- [ ] Write unit tests for settings service
- [ ] Manual test: all settings toggles work
- [ ] Manual test: settings persist after app restart
- [ ] Manual test: settings sync across devices
- [ ] **VERIFY**: Full regression test of settings screens

---

## Firestore Schema

### Collection Structure

```
users/{uid}/settings/
├── appearance     → AppearanceSettingsModel
├── notifications  → NotificationSettingsModel
└── jobSearch      → JobSearchSettingsModel
```

### 1. Appearance Settings

**Path**: `users/{uid}/settings/appearance`

| Field | Type | Default | Action |
|-------|------|---------|--------|
| `darkModeEnabled` | boolean | false | Toggle → writes to Firestore → updates theme |
| `highContrastEnabled` | boolean | false | Toggle → writes to Firestore |
| `electricalEffectsEnabled` | boolean | true | Toggle → writes to Firestore → shows/hides effects |
| `fontSize` | string | "Medium" | Dropdown → writes to Firestore → updates text scale |
| `circuitBackground` | map | {...} | Save button → writes to Firestore |
| `updatedAt` | timestamp | auto | Server timestamp on every write |

### 2. Notification Settings

**Path**: `users/{uid}/settings/notifications`

| Field | Type | Default | Action |
|-------|------|---------|--------|
| `notificationsEnabled` | boolean | true | Master toggle |
| `jobAlertsEnabled` | boolean | true | Toggle → writes to Firestore |
| `stormWorkEnabled` | boolean | true | Toggle → writes to Firestore → stops storm push |
| `unionUpdatesEnabled` | boolean | true | Toggle → writes to Firestore |
| `systemNotificationsEnabled` | boolean | true | Toggle → writes to Firestore |
| `unionRemindersEnabled` | boolean | true | Toggle → writes to Firestore |
| `soundEnabled` | boolean | true | Toggle → writes to Firestore |
| `vibrationEnabled` | boolean | true | Toggle → writes to Firestore |
| `quietHoursEnabled` | boolean | false | Toggle → writes to Firestore |
| `quietHoursStart` | int | 22 | Time picker → writes to Firestore |
| `quietHoursEnd` | int | 7 | Time picker → writes to Firestore |
| `fcmToken` | string? | null | Auto-updated on token refresh |
| `updatedAt` | timestamp | auto | Server timestamp on every write |

### 3. Job Search Settings

**Path**: `users/{uid}/settings/jobSearch`

| Field | Type | Default | Action |
|-------|------|---------|--------|
| `defaultSearchRadius` | double | 50.0 | Slider → writes to Firestore |
| `distanceUnits` | string | "Miles" | Dropdown → writes to Firestore |
| `minimumHourlyRate` | double | 35.0 | Slider → writes to Firestore |
| `autoApplyEnabled` | boolean | false | Toggle → writes to Firestore |
| `autoApplyMaxPerDay` | int | 5 | Stepper → writes to Firestore |
| `preferredJobTypes` | string[] | [] | Multi-select → writes to Firestore |
| `preferredLocals` | string[] | [] | Multi-select → writes to Firestore |
| `availableImmediately` | boolean | true | Toggle → writes to Firestore |
| `earliestStartDate` | timestamp? | null | Date picker → writes to Firestore |
| `updatedAt` | timestamp | auto | Server timestamp on every write |

---

## Data Storage Strategy

| Data Type | Storage | Reason |
|-----------|---------|--------|
| Appearance | Firestore + SharedPrefs cache | Cross-device sync + fast startup |
| Notifications | Firestore + SharedPrefs cache | Needed for push notification logic |
| Job Search | Firestore + SharedPrefs cache | Cross-device sync |
| Theme Mode | SharedPrefs only | Must load before first frame |
| FCM Token | Firestore only | Device-specific, server needs it |

---

## Files Created/Modified

| Status | File | Description |
|--------|------|-------------|
| ✅ Created | `lib/features/settings/models/settings_models.dart` | All Firestore models |
| ✅ Created | `lib/features/settings/services/settings_service.dart` | CRUD + caching + migration |
| ✅ Created | `lib/features/settings/providers/settings_providers.dart` | Riverpod providers |
| ⏳ Pending | `lib/features/settings/screens/appearance_display_screen.dart` | UI integration |
| ⏳ Pending | `lib/features/settings/screens/notifications_settings_screen.dart` | UI integration |
| ⏳ Pending | `lib/features/settings/screens/job_search_preferences_screen.dart` | UI integration |
| ⏳ Pending | `firestore.rules` | Security rules for settings |

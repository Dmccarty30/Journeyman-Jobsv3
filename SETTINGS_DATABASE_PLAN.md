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

### Phase 3: Riverpod Providers (mobile-developer)

- [x] Create `AppearanceSettingsProvider` with Riverpod
- [x] Create `NotificationSettingsProvider` with Riverpod
- [x] Create `JobSearchSettingsProvider` with Riverpod
- [ ] Generate Riverpod code with `build_runner`
- [ ] Integrate `AppearanceSettingsProvider` with existing `AppThemeNotifier`
- [ ] **VERIFY**: Run app and confirm Providers initialize with either Firestore data or SharedPreferences fallback

### Phase 4: UI Integration - Appearance & Display (mobile-developer)

- [x] **Dark Mode Toggle**:
  - [x] Connect `JJCircuitBreakerSwitch` to `appearanceSettingsProvider.setDarkMode`
  - [x] Remove legacy `SharedPreferences` logic from `appearance_display_screen.dart`
  - [ ] Verify theme updates globally on toggle
- [x] **High Contrast Toggle**:
  - [x] Connect toggle to `appearanceSettingsProvider.setHighContrast`
  - [x] Remove legacy local save logic
- [x] **Electrical Effects Toggle**:
  - [x] Connect toggle to `appearanceSettingsProvider.setElectricalEffects`
  - [ ] Verify background effects show/hide immediately
- [x] **Font Size Selector**:
  - [x] Connect `DropdownButton` to `appearanceSettingsProvider.setFontSize`
  - [ ] Verify app-wide text scaling updates
- [ ] **Circuit Background Save**:
  - [ ] Implement "Save Configuration" button action
  - [ ] Push current local circuit state to `appearanceSettingsProvider.setCircuitBackground`
- [ ] **Sync Status**:
  - [ ] Add subtle "Cloud Syncing" indicator to the app bar
- [ ] **VERIFY**: Change "Dark Mode" on Device A, confirm Device B updates instantly via Riverpod stream

### Phase 5: UI Integration - Notifications (mobile-developer)

- [ ] **Master Notification Toggle**:
  - [ ] Link to `notificationSettingsProvider.updateSetting('notificationsEnabled', value)`
- [ ] **Individual Category Toggles**:
  - [ ] Link "Job Alerts" to Provider
  - [ ] Link "Union Updates" to Provider
  - [ ] Link "System Notifications" to Provider
  - [ ] Link "Storm Work" to Provider
  - [ ] Link "Union Reminders" to Provider
- [ ] **Sound & Vibration Toggles**:
  - [ ] Link "Sound" and "Vibration" to Provider
- [ ] **Quiet Hours Configuration**:
  - [ ] Link `TimePicker` results to `notificationSettingsProvider.setQuietHours`
- [ ] **VERIFY**: Check Firestore `notifications` document after toggling "Storm Work" — confirm boolean value matches

### Phase 6: UI Integration - Job Search (mobile-developer)

- [ ] **Search Radius Slider**:
  - [ ] Connect to `jobSearchSettingsProvider.setSearchRadius`
- [ ] **Distance Units Selector**:
  - [ ] Connect to `jobSearchSettingsProvider.setDistanceUnits`
- [ ] **Minimum Hourly Rate Slider**:
  - [ ] Connect to `jobSearchSettingsProvider.setMinimumHourlyRate`
- [ ] **Auto-Apply Toggle**:
  - [ ] Connect to `jobSearchSettingsProvider.setAutoApply`
- [ ] **VERIFY**: Navigate away and back to the screen — confirm all sliders/toggles retain their Firestore values

### Phase 7: Data Migration & First-Run Logic (backend-specialist)

- [ ] Implement `MigrationOverlay` to show progress during first-run sync
- [ ] Call `SettingsService.migrateFromSharedPreferences` on successful Auth
- [ ] Verify migration flag is set in `SharedPreferences` to prevent repeat runs
- [ ] **VERIFY**: Clear Firestore doc, run app with existing local settings, confirm Firestore is populated automatically

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

```bash
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

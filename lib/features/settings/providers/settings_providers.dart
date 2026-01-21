/// Settings Providers for Riverpod State Management
///
/// Provides reactive state management for all settings collections:
/// - Appearance settings provider
/// - Notification settings provider
/// - Job search settings provider
///
/// Uses Firestore streams for real-time updates with SharedPreferences fallback.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/settings_models.dart';
import '../services/settings_service.dart';

part 'settings_providers.g.dart';

/// Provider for the SettingsService
final settingsServiceProvider = Provider<SettingsService>((ref) {
  return SettingsService();
});

// ============================================
// APPEARANCE SETTINGS PROVIDER
// ============================================

@Riverpod(keepAlive: true)
class AppearanceSettings extends _$AppearanceSettings {
  @override
  Future<AppearanceSettingsModel> build() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Return cached settings if no user
      return ref.read(settingsServiceProvider).loadCachedAppearanceSettings();
    }

    // Listen to Firestore stream
    final service = ref.read(settingsServiceProvider);
    final subscription =
        service.appearanceSettingsStream(user.uid).listen((settings) {
      state = AsyncData(settings);
    });

    // Clean up on dispose
    ref.onDispose(() => subscription.cancel());

    // Return initial value
    return service.getAppearanceSettings(user.uid);
  }

  /// Update dark mode setting
  Future<void> setDarkMode(bool enabled) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final current = state.value ?? const AppearanceSettingsModel();
    final updated = current.copyWith(darkModeEnabled: enabled);

    // Optimistic update
    state = AsyncData(updated);

    try {
      await ref
          .read(settingsServiceProvider)
          .updateAppearanceSetting(user.uid, 'darkModeEnabled', enabled);
    } catch (e) {
      // Rollback on error
      state = AsyncData(current);
      rethrow;
    }
  }

  /// Update high contrast setting
  Future<void> setHighContrast(bool enabled) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final current = state.value ?? const AppearanceSettingsModel();
    final updated = current.copyWith(highContrastEnabled: enabled);

    state = AsyncData(updated);

    try {
      await ref
          .read(settingsServiceProvider)
          .updateAppearanceSetting(user.uid, 'highContrastEnabled', enabled);
    } catch (e) {
      state = AsyncData(current);
      rethrow;
    }
  }

  /// Update electrical effects setting
  Future<void> setElectricalEffects(bool enabled) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final current = state.value ?? const AppearanceSettingsModel();
    final updated = current.copyWith(electricalEffectsEnabled: enabled);

    state = AsyncData(updated);

    try {
      await ref.read(settingsServiceProvider).updateAppearanceSetting(
          user.uid, 'electricalEffectsEnabled', enabled);
    } catch (e) {
      state = AsyncData(current);
      rethrow;
    }
  }

  /// Update font size setting
  Future<void> setFontSize(String fontSize) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final current = state.value ?? const AppearanceSettingsModel();
    final updated = current.copyWith(fontSize: fontSize);

    state = AsyncData(updated);

    try {
      await ref
          .read(settingsServiceProvider)
          .updateAppearanceSetting(user.uid, 'fontSize', fontSize);
    } catch (e) {
      state = AsyncData(current);
      rethrow;
    }
  }

  /// Update circuit background settings
  Future<void> setCircuitBackground(CircuitBackgroundSettings settings) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final current = state.value ?? const AppearanceSettingsModel();
    final updated = current.copyWith(circuitBackground: settings);

    state = AsyncData(updated);

    try {
      await ref.read(settingsServiceProvider).updateAppearanceSetting(
          user.uid, 'circuitBackground', settings.toFirestore());
    } catch (e) {
      state = AsyncData(current);
      rethrow;
    }
  }
}

// ============================================
// NOTIFICATION SETTINGS PROVIDER
// ============================================

@Riverpod(keepAlive: true)
class NotificationSettings extends _$NotificationSettings {
  @override
  Future<NotificationSettingsModel> build() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return ref.read(settingsServiceProvider).loadCachedNotificationSettings();
    }

    final service = ref.read(settingsServiceProvider);
    final subscription =
        service.notificationSettingsStream(user.uid).listen((settings) {
      state = AsyncData(settings);
    });

    ref.onDispose(() => subscription.cancel());

    return service.getNotificationSettings(user.uid);
  }

  /// Update a notification toggle
  Future<void> updateSetting(String field, bool value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final current = state.value ?? const NotificationSettingsModel();
    NotificationSettingsModel updated;

    switch (field) {
      case 'jobAlertsEnabled':
        updated = current.copyWith(jobAlertsEnabled: value);
        break;
      case 'unionUpdatesEnabled':
        updated = current.copyWith(unionUpdatesEnabled: value);
        break;
      case 'systemNotificationsEnabled':
        updated = current.copyWith(systemNotificationsEnabled: value);
        break;
      case 'stormWorkEnabled':
        updated = current.copyWith(stormWorkEnabled: value);
        break;
      case 'unionRemindersEnabled':
        updated = current.copyWith(unionRemindersEnabled: value);
        break;
      case 'soundEnabled':
        updated = current.copyWith(soundEnabled: value);
        break;
      case 'vibrationEnabled':
        updated = current.copyWith(vibrationEnabled: value);
        break;
      case 'quietHoursEnabled':
        updated = current.copyWith(quietHoursEnabled: value);
        break;
      default:
        return;
    }

    state = AsyncData(updated);

    try {
      await ref
          .read(settingsServiceProvider)
          .updateNotificationSetting(user.uid, field, value);
    } catch (e) {
      state = AsyncData(current);
      rethrow;
    }
  }

  /// Update quiet hours times
  Future<void> setQuietHours(int start, int end) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final current = state.value ?? const NotificationSettingsModel();
    final updated =
        current.copyWith(quietHoursStart: start, quietHoursEnd: end);

    state = AsyncData(updated);

    try {
      final service = ref.read(settingsServiceProvider);
      await service.updateNotificationSettings(user.uid, updated);
    } catch (e) {
      state = AsyncData(current);
      rethrow;
    }
  }
}

// ============================================
// JOB SEARCH SETTINGS PROVIDER
// ============================================

@Riverpod(keepAlive: true)
class JobSearchSettings extends _$JobSearchSettings {
  @override
  Future<JobSearchSettingsModel> build() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return ref.read(settingsServiceProvider).loadCachedJobSearchSettings();
    }

    final service = ref.read(settingsServiceProvider);
    final subscription =
        service.jobSearchSettingsStream(user.uid).listen((settings) {
      state = AsyncData(settings);
    });

    ref.onDispose(() => subscription.cancel());

    return service.getJobSearchSettings(user.uid);
  }

  /// Update search radius
  Future<void> setSearchRadius(double radius) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final current = state.value ?? const JobSearchSettingsModel();
    final updated = current.copyWith(defaultSearchRadius: radius);

    state = AsyncData(updated);

    try {
      await ref
          .read(settingsServiceProvider)
          .updateJobSearchSetting(user.uid, 'defaultSearchRadius', radius);
    } catch (e) {
      state = AsyncData(current);
      rethrow;
    }
  }

  /// Update distance units
  Future<void> setDistanceUnits(String units) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final current = state.value ?? const JobSearchSettingsModel();
    final updated = current.copyWith(distanceUnits: units);

    state = AsyncData(updated);

    try {
      await ref
          .read(settingsServiceProvider)
          .updateJobSearchSetting(user.uid, 'distanceUnits', units);
    } catch (e) {
      state = AsyncData(current);
      rethrow;
    }
  }

  /// Update minimum hourly rate
  Future<void> setMinimumHourlyRate(double rate) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final current = state.value ?? const JobSearchSettingsModel();
    final updated = current.copyWith(minimumHourlyRate: rate);

    state = AsyncData(updated);

    try {
      await ref
          .read(settingsServiceProvider)
          .updateJobSearchSetting(user.uid, 'minimumHourlyRate', rate);
    } catch (e) {
      state = AsyncData(current);
      rethrow;
    }
  }

  /// Update auto-apply setting
  Future<void> setAutoApply(bool enabled) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final current = state.value ?? const JobSearchSettingsModel();
    final updated = current.copyWith(autoApplyEnabled: enabled);

    state = AsyncData(updated);

    try {
      await ref
          .read(settingsServiceProvider)
          .updateJobSearchSetting(user.uid, 'autoApplyEnabled', enabled);
    } catch (e) {
      state = AsyncData(current);
      rethrow;
    }
  }
}

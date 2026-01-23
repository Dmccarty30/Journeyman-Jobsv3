/// Settings Service for Firestore CRUD operations
///
/// Provides read/write/stream operations for all settings collections:
/// - Appearance settings
/// - Notification settings
/// - Job search preferences
///
/// Also handles SharedPreferences caching for offline support.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/settings_models.dart';

class SettingsService {
  final FirebaseFirestore _firestore;

  SettingsService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Collection references
  DocumentReference<Map<String, dynamic>> _settingsDoc(
      String uid, String docId) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('settings')
        .doc(docId);
  }

  // ============================================
  // APPEARANCE SETTINGS
  // ============================================

  /// Get appearance settings as a stream (real-time updates)
  Stream<AppearanceSettingsModel> appearanceSettingsStream(String uid) {
    return _settingsDoc(uid, 'appearance').snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return AppearanceSettingsModel.fromFirestore(doc.data()!);
      }
      return const AppearanceSettingsModel(); // Return defaults if not exists
    });
  }

  /// Get appearance settings once
  Future<AppearanceSettingsModel> getAppearanceSettings(String uid) async {
    try {
      final doc = await _settingsDoc(uid, 'appearance').get();
      if (doc.exists && doc.data() != null) {
        return AppearanceSettingsModel.fromFirestore(doc.data()!);
      }
      return const AppearanceSettingsModel();
    } catch (e) {
      debugPrint('Error getting appearance settings: $e');
      return const AppearanceSettingsModel();
    }
  }

  /// Update appearance settings
  Future<void> updateAppearanceSettings(
    String uid,
    AppearanceSettingsModel settings,
  ) async {
    try {
      await _settingsDoc(uid, 'appearance').set(
        settings.toFirestore(),
        SetOptions(merge: true),
      );
      // Also cache to SharedPreferences
      await _cacheAppearanceSettings(settings);
    } catch (e) {
      debugPrint('Error updating appearance settings: $e');
      rethrow;
    }
  }

  /// Update a single appearance setting field
  Future<void> updateAppearanceSetting(
    String uid,
    String field,
    dynamic value,
  ) async {
    try {
      await _settingsDoc(uid, 'appearance').set({
        field: value,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Error updating appearance setting $field: $e');
      rethrow;
    }
  }

  // ============================================
  // NOTIFICATION SETTINGS
  // ============================================

  /// Get notification settings as a stream (real-time updates)
  Stream<NotificationSettingsModel> notificationSettingsStream(String uid) {
    return _settingsDoc(uid, 'notifications').snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return NotificationSettingsModel.fromFirestore(doc.data()!);
      }
      return const NotificationSettingsModel();
    });
  }

  /// Get notification settings once
  Future<NotificationSettingsModel> getNotificationSettings(String uid) async {
    try {
      final doc = await _settingsDoc(uid, 'notifications').get();
      if (doc.exists && doc.data() != null) {
        return NotificationSettingsModel.fromFirestore(doc.data()!);
      }
      return const NotificationSettingsModel();
    } catch (e) {
      debugPrint('Error getting notification settings: $e');
      return const NotificationSettingsModel();
    }
  }

  /// Update notification settings
  Future<void> updateNotificationSettings(
    String uid,
    NotificationSettingsModel settings,
  ) async {
    try {
      await _settingsDoc(uid, 'notifications').set(
        settings.toFirestore(),
        SetOptions(merge: true),
      );
      // Also cache to SharedPreferences
      await _cacheNotificationSettings(settings);
    } catch (e) {
      debugPrint('Error updating notification settings: $e');
      rethrow;
    }
  }

  /// Update a single notification setting field
  Future<void> updateNotificationSetting(
    String uid,
    String field,
    dynamic value,
  ) async {
    try {
      await _settingsDoc(uid, 'notifications').set({
        field: value,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Error updating notification setting $field: $e');
      rethrow;
    }
  }

  // ============================================
  // JOB SEARCH SETTINGS
  // ============================================

  /// Get job search settings as a stream (real-time updates)
  Stream<JobSearchSettingsModel> jobSearchSettingsStream(String uid) {
    return _settingsDoc(uid, 'jobSearch').snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return JobSearchSettingsModel.fromFirestore(doc.data()!);
      }
      return const JobSearchSettingsModel();
    });
  }

  /// Get job search settings once
  Future<JobSearchSettingsModel> getJobSearchSettings(String uid) async {
    try {
      final doc = await _settingsDoc(uid, 'jobSearch').get();
      if (doc.exists && doc.data() != null) {
        return JobSearchSettingsModel.fromFirestore(doc.data()!);
      }
      return const JobSearchSettingsModel();
    } catch (e) {
      debugPrint('Error getting job search settings: $e');
      return const JobSearchSettingsModel();
    }
  }

  /// Update job search settings
  Future<void> updateJobSearchSettings(
    String uid,
    JobSearchSettingsModel settings,
  ) async {
    try {
      await _settingsDoc(uid, 'jobSearch').set(
        settings.toFirestore(),
        SetOptions(merge: true),
      );
      // Also cache to SharedPreferences
      await _cacheJobSearchSettings(settings);
    } catch (e) {
      debugPrint('Error updating job search settings: $e');
      rethrow;
    }
  }

  /// Update a single job search setting field
  Future<void> updateJobSearchSetting(
    String uid,
    String field,
    dynamic value,
  ) async {
    try {
      await _settingsDoc(uid, 'jobSearch').set({
        field: value,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Error updating job search setting $field: $e');
      rethrow;
    }
  }

  // ============================================
  // PRIVACY & SECURITY SETTINGS
  // ============================================

  /// Get privacy & security settings as a stream (real-time updates)
  Stream<PrivacySecuritySettingsModel> privacySecuritySettingsStream(
      String uid) {
    return _settingsDoc(uid, 'privacySecurity').snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return PrivacySecuritySettingsModel.fromFirestore(doc.data()!);
      }
      return const PrivacySecuritySettingsModel();
    });
  }

  /// Get privacy & security settings once
  Future<PrivacySecuritySettingsModel> getPrivacySecuritySettings(
      String uid) async {
    try {
      final doc = await _settingsDoc(uid, 'privacySecurity').get();
      if (doc.exists && doc.data() != null) {
        return PrivacySecuritySettingsModel.fromFirestore(doc.data()!);
      }
      return const PrivacySecuritySettingsModel();
    } catch (e) {
      debugPrint('Error getting privacy & security settings: $e');
      return const PrivacySecuritySettingsModel();
    }
  }

  /// Update privacy & security settings
  Future<void> updatePrivacySecuritySettings(
    String uid,
    PrivacySecuritySettingsModel settings,
  ) async {
    try {
      await _settingsDoc(uid, 'privacySecurity').set(
        settings.toFirestore(),
        SetOptions(merge: true),
      );
      // Also cache to SharedPreferences
      await _cachePrivacySecuritySettings(settings);
    } catch (e) {
      debugPrint('Error updating privacy & security settings: $e');
      rethrow;
    }
  }

  /// Update a single privacy & security setting field
  Future<void> updatePrivacySecuritySetting(
    String uid,
    String field,
    dynamic value,
  ) async {
    try {
      await _settingsDoc(uid, 'privacySecurity').set({
        field: value,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Error updating privacy & security setting $field: $e');
      rethrow;
    }
  }

  // ============================================
  // DATA & STORAGE SETTINGS
  // ============================================

  /// Get settings stream
  Stream<DataStorageSettingsModel> dataStorageSettingsStream(String uid) {
    return _settingsDoc(uid, 'dataStorage').snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return DataStorageSettingsModel.fromFirestore(doc.data()!);
      }
      return const DataStorageSettingsModel();
    });
  }

  /// Get settings
  Future<DataStorageSettingsModel> getDataStorageSettings(String uid) async {
    try {
      final doc = await _settingsDoc(uid, 'dataStorage').get();
      if (doc.exists && doc.data() != null) {
        return DataStorageSettingsModel.fromFirestore(doc.data()!);
      }
      return const DataStorageSettingsModel();
    } catch (e) {
      debugPrint('Error getting data & storage settings: $e');
      return const DataStorageSettingsModel();
    }
  }

  /// Update settings
  Future<void> updateDataStorageSettings(
    String uid,
    DataStorageSettingsModel settings,
  ) async {
    try {
      await _settingsDoc(uid, 'dataStorage').set(
        settings.toFirestore(),
        SetOptions(merge: true),
      );
      await _cacheDataStorageSettings(settings);
    } catch (e) {
      debugPrint('Error updating data & storage settings: $e');
      rethrow;
    }
  }

  /// Update single setting
  Future<void> updateDataStorageSetting(
    String uid,
    String field,
    dynamic value,
  ) async {
    try {
      await _settingsDoc(uid, 'dataStorage').set({
        field: value,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Error updating data & storage setting $field: $e');
      rethrow;
    }
  }

  /// Calculate cache size (simulated for now)
  Future<String> calculateCacheSize() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return '42.5 MB'; // TODO: Implement actual calculation
  }

  /// Clear cache (simulated for now)
  Future<void> clearCache() async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO: Implement actual cache clearing
  }

  // ============================================
  // SHARED PREFERENCES CACHING
  // ============================================

  /// Cache appearance settings to SharedPreferences for offline fallback
  Future<void> _cacheAppearanceSettings(
      AppearanceSettingsModel settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('darkMode', settings.darkModeEnabled);
      await prefs.setBool('highContrast', settings.highContrastEnabled);
      await prefs.setBool(
          'electricalEffects', settings.electricalEffectsEnabled);
      await prefs.setString('fontSize', settings.fontSize);
      // Circuit background settings
      await prefs.setDouble(
          'circuit_opacity', settings.circuitBackground.opacity);
      await prefs.setDouble(
          'circuit_animationSpeed', settings.circuitBackground.animationSpeed);
      await prefs.setString('circuit_componentDensity',
          settings.circuitBackground.componentDensity);
      await prefs.setString('circuit_theme', settings.circuitBackground.theme);
      await prefs.setString(
          'circuit_substrateColor', settings.circuitBackground.substrateColor);
    } catch (e) {
      debugPrint('Error caching appearance settings: $e');
    }
  }

  /// Cache notification settings to SharedPreferences for offline fallback
  Future<void> _cacheNotificationSettings(
      NotificationSettingsModel settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('job_alerts_enabled', settings.jobAlertsEnabled);
      await prefs.setBool(
          'union_updates_enabled', settings.unionUpdatesEnabled);
      await prefs.setBool(
          'system_notifications_enabled', settings.systemNotificationsEnabled);
      await prefs.setBool('storm_work_enabled', settings.stormWorkEnabled);
      await prefs.setBool(
          'union_reminders_enabled', settings.unionRemindersEnabled);
      await prefs.setBool('sound_enabled', settings.soundEnabled);
      await prefs.setBool('vibration_enabled', settings.vibrationEnabled);
      await prefs.setBool('quiet_hours_enabled', settings.quietHoursEnabled);
      await prefs.setInt('quiet_hours_start', settings.quietHoursStart);
      await prefs.setInt('quiet_hours_end', settings.quietHoursEnd);
    } catch (e) {
      debugPrint('Error caching notification settings: $e');
    }
  }

  /// Cache job search settings to SharedPreferences for offline fallback
  Future<void> _cacheJobSearchSettings(JobSearchSettingsModel settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(
          'default_search_radius', settings.defaultSearchRadius);
      await prefs.setString('units', settings.distanceUnits);
      await prefs.setBool('auto_apply', settings.autoApplyEnabled);
      await prefs.setDouble('minimum_hourly_rate', settings.minimumHourlyRate);
    } catch (e) {
      debugPrint('Error caching job search settings: $e');
    }
  }

  /// Cache privacy & security settings to SharedPreferences for offline fallback
  Future<void> _cachePrivacySecuritySettings(
      PrivacySecuritySettingsModel settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_visibility', settings.profileVisibility);
      await prefs.setBool(
          'location_services', settings.locationServicesEnabled);
      await prefs.setBool('biometric_login', settings.biometricLoginEnabled);
      await prefs.setBool('two_factor', settings.twoFactorEnabled);
    } catch (e) {
      debugPrint('Error caching privacy & security settings: $e');
    }
  }

  /// Load appearance settings from SharedPreferences (offline fallback)
  Future<AppearanceSettingsModel> loadCachedAppearanceSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return AppearanceSettingsModel(
        darkModeEnabled: prefs.getBool('darkMode') ?? false,
        highContrastEnabled: prefs.getBool('highContrast') ?? false,
        electricalEffectsEnabled: prefs.getBool('electricalEffects') ?? true,
        fontSize: prefs.getString('fontSize') ?? 'Medium',
        circuitBackground: CircuitBackgroundSettings(
          opacity: prefs.getDouble('circuit_opacity') ?? 0.35,
          animationSpeed: prefs.getDouble('circuit_animationSpeed') ?? 1.0,
          componentDensity:
              prefs.getString('circuit_componentDensity') ?? 'high',
          theme: prefs.getString('circuit_theme') ?? 'copper',
          substrateColor:
              prefs.getString('circuit_substrateColor') ?? '#1A237E',
        ),
      );
    } catch (e) {
      debugPrint('Error loading cached appearance settings: $e');
      return const AppearanceSettingsModel();
    }
  }

  /// Load notification settings from SharedPreferences (offline fallback)
  Future<NotificationSettingsModel> loadCachedNotificationSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return NotificationSettingsModel(
        jobAlertsEnabled: prefs.getBool('job_alerts_enabled') ?? true,
        unionUpdatesEnabled: prefs.getBool('union_updates_enabled') ?? true,
        systemNotificationsEnabled:
            prefs.getBool('system_notifications_enabled') ?? true,
        stormWorkEnabled: prefs.getBool('storm_work_enabled') ?? true,
        unionRemindersEnabled: prefs.getBool('union_reminders_enabled') ?? true,
        soundEnabled: prefs.getBool('sound_enabled') ?? true,
        vibrationEnabled: prefs.getBool('vibration_enabled') ?? true,
        quietHoursEnabled: prefs.getBool('quiet_hours_enabled') ?? false,
        quietHoursStart: prefs.getInt('quiet_hours_start') ?? 22,
        quietHoursEnd: prefs.getInt('quiet_hours_end') ?? 7,
      );
    } catch (e) {
      debugPrint('Error loading cached notification settings: $e');
      return const NotificationSettingsModel();
    }
  }

  /// Load job search settings from SharedPreferences (offline fallback)
  Future<JobSearchSettingsModel> loadCachedJobSearchSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return JobSearchSettingsModel(
        defaultSearchRadius: prefs.getDouble('default_search_radius') ?? 50.0,
        distanceUnits: prefs.getString('units') ?? 'Miles',
        autoApplyEnabled: prefs.getBool('auto_apply') ?? false,
        minimumHourlyRate: prefs.getDouble('minimum_hourly_rate') ?? 35.0,
      );
    } catch (e) {
      debugPrint('Error loading cached job search settings: $e');
      return const JobSearchSettingsModel();
    }
  }

  /// Load privacy & security settings from SharedPreferences (offline fallback)
  Future<PrivacySecuritySettingsModel>
      loadCachedPrivacySecuritySettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return PrivacySecuritySettingsModel(
        profileVisibility:
            prefs.getString('profile_visibility') ?? 'Union Members Only',
        locationServicesEnabled: prefs.getBool('location_services') ?? true,
        biometricLoginEnabled: prefs.getBool('biometric_login') ?? false,
        twoFactorEnabled: prefs.getBool('two_factor') ?? false,
      );
    } catch (e) {
      debugPrint('Error loading cached privacy & security settings: $e');
      return const PrivacySecuritySettingsModel();
    }
  }

  /// Cache data & storage settings to SharedPreferences for offline fallback
  Future<void> _cacheDataStorageSettings(
      DataStorageSettingsModel settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('offlineMode', settings.offlineModeEnabled);
      await prefs.setBool('autoDownload', settings.autoDownloadEnabled);
      await prefs.setBool('wifiOnly', settings.wifiOnlyDownloads);
    } catch (e) {
      debugPrint('Error caching data & storage settings: $e');
    }
  }

  /// Load data & storage settings from SharedPreferences (offline fallback)
  Future<DataStorageSettingsModel> loadCachedDataStorageSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return DataStorageSettingsModel(
        offlineModeEnabled: prefs.getBool('offlineMode') ?? false,
        autoDownloadEnabled: prefs.getBool('autoDownload') ?? true,
        wifiOnlyDownloads: prefs.getBool('wifiOnly') ?? true,
      );
    } catch (e) {
      debugPrint('Error loading cached data & storage settings: $e');
      return const DataStorageSettingsModel();
    }
  }

  // ============================================
  // MIGRATION
  // ============================================

  /// Migrate settings from SharedPreferences to Firestore (one-time operation)
  Future<bool> migrateFromSharedPreferences(String uid) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final migrationKey = 'settings_migrated_$uid';

      // Check if already migrated
      if (prefs.getBool(migrationKey) == true) {
        debugPrint('Settings already migrated for user $uid');
        return true;
      }

      // Migrate appearance settings
      final appearance = await loadCachedAppearanceSettings();
      await updateAppearanceSettings(uid, appearance);

      // Migrate notification settings
      final notifications = await loadCachedNotificationSettings();
      await updateNotificationSettings(uid, notifications);

      // Migrate job search settings
      final jobSearch = await loadCachedJobSearchSettings();
      await updateJobSearchSettings(uid, jobSearch);

      // Migrate privacy & security settings
      final privacySecurity = await loadCachedPrivacySecuritySettings();
      await updatePrivacySecuritySettings(uid, privacySecurity);

      // Migrate data & storage settings
      final dataStorage = await loadCachedDataStorageSettings();
      await updateDataStorageSettings(uid, dataStorage);

      // Mark as migrated
      await prefs.setBool(migrationKey, true);
      debugPrint('Settings migrated successfully for user $uid');
      return true;
    } catch (e) {
      debugPrint('Error migrating settings: $e');
      return false;
    }
  }
}

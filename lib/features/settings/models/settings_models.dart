/// Settings Models for Firestore persistence
///
/// This file contains data models for all settings-related collections:
/// - AppearanceSettingsModel: Theme, display, and visual effect preferences
/// - NotificationSettingsModel: Notification preferences and quiet hours
/// - JobSearchSettingsModel: Job search filters and automation settings

import 'package:cloud_firestore/cloud_firestore.dart';

/// Circuit background configuration settings
class CircuitBackgroundSettings {
  final double opacity;
  final double animationSpeed;
  final String componentDensity; // 'low', 'medium', 'high'
  final String theme;
  final String substrateColor;

  const CircuitBackgroundSettings({
    this.opacity = 0.35,
    this.animationSpeed = 1.0,
    this.componentDensity = 'high',
    this.theme = 'copper',
    this.substrateColor = '#1A237E',
  });

  factory CircuitBackgroundSettings.fromFirestore(Map<String, dynamic> data) {
    return CircuitBackgroundSettings(
      opacity: (data['opacity'] ?? 0.35).toDouble(),
      animationSpeed: (data['animationSpeed'] ?? 1.0).toDouble(),
      componentDensity: data['componentDensity'] ?? 'high',
      theme: data['theme'] ?? 'copper',
      substrateColor: data['substrateColor'] ?? '#1A237E',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'opacity': opacity,
      'animationSpeed': animationSpeed,
      'componentDensity': componentDensity,
      'theme': theme,
      'substrateColor': substrateColor,
    };
  }

  CircuitBackgroundSettings copyWith({
    double? opacity,
    double? animationSpeed,
    String? componentDensity,
    String? theme,
    String? substrateColor,
  }) {
    return CircuitBackgroundSettings(
      opacity: opacity ?? this.opacity,
      animationSpeed: animationSpeed ?? this.animationSpeed,
      componentDensity: componentDensity ?? this.componentDensity,
      theme: theme ?? this.theme,
      substrateColor: substrateColor ?? this.substrateColor,
    );
  }
}

/// Appearance and display settings stored in Firestore
/// Path: users/{uid}/settings/appearance
class AppearanceSettingsModel {
  final bool darkModeEnabled;
  final bool highContrastEnabled;
  final bool electricalEffectsEnabled;
  final String fontSize; // 'Small', 'Medium', 'Large', 'Extra Large'
  final CircuitBackgroundSettings circuitBackground;
  final DateTime? updatedAt;
  final int version;

  const AppearanceSettingsModel({
    this.darkModeEnabled = false,
    this.highContrastEnabled = false,
    this.electricalEffectsEnabled = true,
    this.fontSize = 'Medium',
    this.circuitBackground = const CircuitBackgroundSettings(),
    this.updatedAt,
    this.version = 1,
  });

  factory AppearanceSettingsModel.fromFirestore(Map<String, dynamic> data) {
    return AppearanceSettingsModel(
      darkModeEnabled: data['darkModeEnabled'] ?? false,
      highContrastEnabled: data['highContrastEnabled'] ?? false,
      electricalEffectsEnabled: data['electricalEffectsEnabled'] ?? true,
      fontSize: data['fontSize'] ?? 'Medium',
      circuitBackground: data['circuitBackground'] != null
          ? CircuitBackgroundSettings.fromFirestore(
              data['circuitBackground'] as Map<String, dynamic>)
          : const CircuitBackgroundSettings(),
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      version: data['version'] ?? 1,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'darkModeEnabled': darkModeEnabled,
      'highContrastEnabled': highContrastEnabled,
      'electricalEffectsEnabled': electricalEffectsEnabled,
      'fontSize': fontSize,
      'circuitBackground': circuitBackground.toFirestore(),
      'updatedAt': FieldValue.serverTimestamp(),
      'version': version,
    };
  }

  AppearanceSettingsModel copyWith({
    bool? darkModeEnabled,
    bool? highContrastEnabled,
    bool? electricalEffectsEnabled,
    String? fontSize,
    CircuitBackgroundSettings? circuitBackground,
    DateTime? updatedAt,
    int? version,
  }) {
    return AppearanceSettingsModel(
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      highContrastEnabled: highContrastEnabled ?? this.highContrastEnabled,
      electricalEffectsEnabled:
          electricalEffectsEnabled ?? this.electricalEffectsEnabled,
      fontSize: fontSize ?? this.fontSize,
      circuitBackground: circuitBackground ?? this.circuitBackground,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }

  /// Create from SharedPreferences values for migration
  factory AppearanceSettingsModel.fromSharedPreferences({
    required bool darkMode,
    required bool highContrast,
    required bool electricalEffects,
    required String fontSize,
  }) {
    return AppearanceSettingsModel(
      darkModeEnabled: darkMode,
      highContrastEnabled: highContrast,
      electricalEffectsEnabled: electricalEffects,
      fontSize: fontSize,
    );
  }
}

/// Notification settings stored in Firestore
/// Path: users/{uid}/settings/notifications
class NotificationSettingsModel {
  // Master toggle
  final bool notificationsEnabled;

  // Category toggles
  final bool jobAlertsEnabled;
  final bool unionUpdatesEnabled;
  final bool systemNotificationsEnabled;
  final bool stormWorkEnabled;
  final bool unionRemindersEnabled;

  // Sound & Vibration
  final bool soundEnabled;
  final bool vibrationEnabled;

  // Quiet Hours
  final bool quietHoursEnabled;
  final int quietHoursStart; // Hour (0-23)
  final int quietHoursEnd; // Hour (0-23)

  // FCM Token
  final String? fcmToken;
  final DateTime? tokenUpdatedAt;

  // Metadata
  final DateTime? updatedAt;
  final int version;

  const NotificationSettingsModel({
    this.notificationsEnabled = true,
    this.jobAlertsEnabled = true,
    this.unionUpdatesEnabled = true,
    this.systemNotificationsEnabled = true,
    this.stormWorkEnabled = true,
    this.unionRemindersEnabled = true,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.quietHoursEnabled = false,
    this.quietHoursStart = 22,
    this.quietHoursEnd = 7,
    this.fcmToken,
    this.tokenUpdatedAt,
    this.updatedAt,
    this.version = 1,
  });

  factory NotificationSettingsModel.fromFirestore(Map<String, dynamic> data) {
    return NotificationSettingsModel(
      notificationsEnabled: data['notificationsEnabled'] ?? true,
      jobAlertsEnabled: data['jobAlertsEnabled'] ?? true,
      unionUpdatesEnabled: data['unionUpdatesEnabled'] ?? true,
      systemNotificationsEnabled: data['systemNotificationsEnabled'] ?? true,
      stormWorkEnabled: data['stormWorkEnabled'] ?? true,
      unionRemindersEnabled: data['unionRemindersEnabled'] ?? true,
      soundEnabled: data['soundEnabled'] ?? true,
      vibrationEnabled: data['vibrationEnabled'] ?? true,
      quietHoursEnabled: data['quietHoursEnabled'] ?? false,
      quietHoursStart: data['quietHoursStart'] ?? 22,
      quietHoursEnd: data['quietHoursEnd'] ?? 7,
      fcmToken: data['fcmToken'],
      tokenUpdatedAt: data['tokenUpdatedAt'] != null
          ? (data['tokenUpdatedAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      version: data['version'] ?? 1,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'notificationsEnabled': notificationsEnabled,
      'jobAlertsEnabled': jobAlertsEnabled,
      'unionUpdatesEnabled': unionUpdatesEnabled,
      'systemNotificationsEnabled': systemNotificationsEnabled,
      'stormWorkEnabled': stormWorkEnabled,
      'unionRemindersEnabled': unionRemindersEnabled,
      'soundEnabled': soundEnabled,
      'vibrationEnabled': vibrationEnabled,
      'quietHoursEnabled': quietHoursEnabled,
      'quietHoursStart': quietHoursStart,
      'quietHoursEnd': quietHoursEnd,
      if (fcmToken != null) 'fcmToken': fcmToken,
      if (tokenUpdatedAt != null)
        'tokenUpdatedAt': Timestamp.fromDate(tokenUpdatedAt!),
      'updatedAt': FieldValue.serverTimestamp(),
      'version': version,
    };
  }

  NotificationSettingsModel copyWith({
    bool? notificationsEnabled,
    bool? jobAlertsEnabled,
    bool? unionUpdatesEnabled,
    bool? systemNotificationsEnabled,
    bool? stormWorkEnabled,
    bool? unionRemindersEnabled,
    bool? soundEnabled,
    bool? vibrationEnabled,
    bool? quietHoursEnabled,
    int? quietHoursStart,
    int? quietHoursEnd,
    String? fcmToken,
    DateTime? tokenUpdatedAt,
    DateTime? updatedAt,
    int? version,
  }) {
    return NotificationSettingsModel(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      jobAlertsEnabled: jobAlertsEnabled ?? this.jobAlertsEnabled,
      unionUpdatesEnabled: unionUpdatesEnabled ?? this.unionUpdatesEnabled,
      systemNotificationsEnabled:
          systemNotificationsEnabled ?? this.systemNotificationsEnabled,
      stormWorkEnabled: stormWorkEnabled ?? this.stormWorkEnabled,
      unionRemindersEnabled:
          unionRemindersEnabled ?? this.unionRemindersEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      quietHoursEnabled: quietHoursEnabled ?? this.quietHoursEnabled,
      quietHoursStart: quietHoursStart ?? this.quietHoursStart,
      quietHoursEnd: quietHoursEnd ?? this.quietHoursEnd,
      fcmToken: fcmToken ?? this.fcmToken,
      tokenUpdatedAt: tokenUpdatedAt ?? this.tokenUpdatedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }

  /// Create from SharedPreferences values for migration
  factory NotificationSettingsModel.fromSharedPreferences({
    required bool jobAlerts,
    required bool unionUpdates,
    required bool systemNotifications,
    required bool stormWork,
    required bool unionReminders,
    required bool sound,
    required bool vibration,
    required bool quietHours,
    required int quietStart,
    required int quietEnd,
  }) {
    return NotificationSettingsModel(
      jobAlertsEnabled: jobAlerts,
      unionUpdatesEnabled: unionUpdates,
      systemNotificationsEnabled: systemNotifications,
      stormWorkEnabled: stormWork,
      unionRemindersEnabled: unionReminders,
      soundEnabled: sound,
      vibrationEnabled: vibration,
      quietHoursEnabled: quietHours,
      quietHoursStart: quietStart,
      quietHoursEnd: quietEnd,
    );
  }
}

/// Job search preferences stored in Firestore
/// Path: users/{uid}/settings/jobSearch
class JobSearchSettingsModel {
  // Search Filters
  final double defaultSearchRadius;
  final String distanceUnits; // 'Miles', 'Kilometers'
  final double minimumHourlyRate;

  // Automation
  final bool autoApplyEnabled;
  final int autoApplyMaxPerDay;

  // Job Type Preferences
  final List<String> preferredJobTypes;
  final List<String> preferredLocals;

  // Availability
  final bool availableImmediately;
  final DateTime? earliestStartDate;

  // Metadata
  final DateTime? updatedAt;
  final int version;

  const JobSearchSettingsModel({
    this.defaultSearchRadius = 50.0,
    this.distanceUnits = 'Miles',
    this.minimumHourlyRate = 35.0,
    this.autoApplyEnabled = false,
    this.autoApplyMaxPerDay = 5,
    this.preferredJobTypes = const [],
    this.preferredLocals = const [],
    this.availableImmediately = true,
    this.earliestStartDate,
    this.updatedAt,
    this.version = 1,
  });

  factory JobSearchSettingsModel.fromFirestore(Map<String, dynamic> data) {
    return JobSearchSettingsModel(
      defaultSearchRadius: (data['defaultSearchRadius'] ?? 50.0).toDouble(),
      distanceUnits: data['distanceUnits'] ?? 'Miles',
      minimumHourlyRate: (data['minimumHourlyRate'] ?? 35.0).toDouble(),
      autoApplyEnabled: data['autoApplyEnabled'] ?? false,
      autoApplyMaxPerDay: data['autoApplyMaxPerDay'] ?? 5,
      preferredJobTypes: List<String>.from(data['preferredJobTypes'] ?? []),
      preferredLocals: List<String>.from(data['preferredLocals'] ?? []),
      availableImmediately: data['availableImmediately'] ?? true,
      earliestStartDate: data['earliestStartDate'] != null
          ? (data['earliestStartDate'] as Timestamp).toDate()
          : null,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      version: data['version'] ?? 1,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'defaultSearchRadius': defaultSearchRadius,
      'distanceUnits': distanceUnits,
      'minimumHourlyRate': minimumHourlyRate,
      'autoApplyEnabled': autoApplyEnabled,
      'autoApplyMaxPerDay': autoApplyMaxPerDay,
      'preferredJobTypes': preferredJobTypes,
      'preferredLocals': preferredLocals,
      'availableImmediately': availableImmediately,
      if (earliestStartDate != null)
        'earliestStartDate': Timestamp.fromDate(earliestStartDate!),
      'updatedAt': FieldValue.serverTimestamp(),
      'version': version,
    };
  }

  JobSearchSettingsModel copyWith({
    double? defaultSearchRadius,
    String? distanceUnits,
    double? minimumHourlyRate,
    bool? autoApplyEnabled,
    int? autoApplyMaxPerDay,
    List<String>? preferredJobTypes,
    List<String>? preferredLocals,
    bool? availableImmediately,
    DateTime? earliestStartDate,
    DateTime? updatedAt,
    int? version,
  }) {
    return JobSearchSettingsModel(
      defaultSearchRadius: defaultSearchRadius ?? this.defaultSearchRadius,
      distanceUnits: distanceUnits ?? this.distanceUnits,
      minimumHourlyRate: minimumHourlyRate ?? this.minimumHourlyRate,
      autoApplyEnabled: autoApplyEnabled ?? this.autoApplyEnabled,
      autoApplyMaxPerDay: autoApplyMaxPerDay ?? this.autoApplyMaxPerDay,
      preferredJobTypes: preferredJobTypes ?? this.preferredJobTypes,
      preferredLocals: preferredLocals ?? this.preferredLocals,
      availableImmediately: availableImmediately ?? this.availableImmediately,
      earliestStartDate: earliestStartDate ?? this.earliestStartDate,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }

  /// Create from SharedPreferences values for migration
  factory JobSearchSettingsModel.fromSharedPreferences({
    required double searchRadius,
    required String units,
    required bool autoApply,
    required double minRate,
  }) {
    return JobSearchSettingsModel(
      defaultSearchRadius: searchRadius,
      distanceUnits: units,
      autoApplyEnabled: autoApply,
      minimumHourlyRate: minRate,
    );
  }
}

/// Privacy and security settings stored in Firestore
/// Path: users/{uid}/settings/privacySecurity
class PrivacySecuritySettingsModel {
  final String profileVisibility; // 'Public', 'Union Members Only', 'Private'
  final bool locationServicesEnabled;
  final bool biometricLoginEnabled;
  final bool twoFactorEnabled;

  // Metadata
  final DateTime? updatedAt;
  final int version;

  const PrivacySecuritySettingsModel({
    this.profileVisibility = 'Union Members Only',
    this.locationServicesEnabled = true,
    this.biometricLoginEnabled = false,
    this.twoFactorEnabled = false,
    this.updatedAt,
    this.version = 1,
  });

  factory PrivacySecuritySettingsModel.fromFirestore(
      Map<String, dynamic> data) {
    return PrivacySecuritySettingsModel(
      profileVisibility: data['profileVisibility'] ?? 'Union Members Only',
      locationServicesEnabled: data['locationServicesEnabled'] ?? true,
      biometricLoginEnabled: data['biometricLoginEnabled'] ?? false,
      twoFactorEnabled: data['twoFactorEnabled'] ?? false,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      version: data['version'] ?? 1,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'profileVisibility': profileVisibility,
      'locationServicesEnabled': locationServicesEnabled,
      'biometricLoginEnabled': biometricLoginEnabled,
      'twoFactorEnabled': twoFactorEnabled,
      'updatedAt': FieldValue.serverTimestamp(),
      'version': version,
    };
  }

  PrivacySecuritySettingsModel copyWith({
    String? profileVisibility,
    bool? locationServicesEnabled,
    bool? biometricLoginEnabled,
    bool? twoFactorEnabled,
    DateTime? updatedAt,
    int? version,
  }) {
    return PrivacySecuritySettingsModel(
      profileVisibility: profileVisibility ?? this.profileVisibility,
      locationServicesEnabled:
          locationServicesEnabled ?? this.locationServicesEnabled,
      biometricLoginEnabled:
          biometricLoginEnabled ?? this.biometricLoginEnabled,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }

  /// Create from SharedPreferences values for migration
  factory PrivacySecuritySettingsModel.fromSharedPreferences({
    required String visibility,
    required bool location,
    required bool biometric,
    required bool twoFactor,
  }) {
    return PrivacySecuritySettingsModel(
      profileVisibility: visibility,
      locationServicesEnabled: location,
      biometricLoginEnabled: biometric,
      twoFactorEnabled: twoFactor,
    );
  }
}

/// Data and storage settings stored in Firestore
/// Path: users/{uid}/settings/dataStorage
class DataStorageSettingsModel {
  final bool offlineModeEnabled;
  final bool autoDownloadEnabled;
  final bool wifiOnlyDownloads;

  // Metadata
  final DateTime? updatedAt;
  final int version;

  const DataStorageSettingsModel({
    this.offlineModeEnabled = false,
    this.autoDownloadEnabled = true,
    this.wifiOnlyDownloads = true,
    this.updatedAt,
    this.version = 1,
  });

  factory DataStorageSettingsModel.fromFirestore(Map<String, dynamic> data) {
    return DataStorageSettingsModel(
      offlineModeEnabled: data['offlineModeEnabled'] ?? false,
      autoDownloadEnabled: data['autoDownloadEnabled'] ?? true,
      wifiOnlyDownloads: data['wifiOnlyDownloads'] ?? true,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      version: data['version'] ?? 1,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'offlineModeEnabled': offlineModeEnabled,
      'autoDownloadEnabled': autoDownloadEnabled,
      'wifiOnlyDownloads': wifiOnlyDownloads,
      'updatedAt': FieldValue.serverTimestamp(),
      'version': version,
    };
  }

  DataStorageSettingsModel copyWith({
    bool? offlineModeEnabled,
    bool? autoDownloadEnabled,
    bool? wifiOnlyDownloads,
    DateTime? updatedAt,
    int? version,
  }) {
    return DataStorageSettingsModel(
      offlineModeEnabled: offlineModeEnabled ?? this.offlineModeEnabled,
      autoDownloadEnabled: autoDownloadEnabled ?? this.autoDownloadEnabled,
      wifiOnlyDownloads: wifiOnlyDownloads ?? this.wifiOnlyDownloads,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }

  /// Create from SharedPreferences values for migration
  factory DataStorageSettingsModel.fromSharedPreferences({
    required bool offlineMode,
    required bool autoDownload,
    required bool wifiOnly,
  }) {
    return DataStorageSettingsModel(
      offlineModeEnabled: offlineMode,
      autoDownloadEnabled: autoDownload,
      wifiOnlyDownloads: wifiOnly,
    );
  }
}

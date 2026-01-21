import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'package:journeyman_jobs/design_system/electrical/circuit_settings_controller.dart';

/// Antigravity Kit 2.0 - Bootstrap Only
///
/// Per flutter-app template:
/// - main.dart contains ONLY bootstrap/initialization logic
/// - App widget is in app.dart for separation of concerns
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase only if it hasn't been initialized yet
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Enable Firebase Performance Monitoring
    await FirebasePerformance.instance.setPerformanceCollectionEnabled(true);

    // Initialize Firebase Crashlytics
    FlutterError.onError = (errorDetails) =>
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  // Enable Firestore offline persistence for better user experience
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: 100 * 1024 * 1024, // 100MB cache
  );

  // Initialize Hive for local storage (Antigravity Kit 2.0)
  await JourneymanJobsApp.initializeHive();

  // Load Global Circuit Settings (for persistent customization)
  await CircuitSettingsController.instance.loadSettings();

  // ProviderScope wrapper around Material App
  runApp(
    const ProviderScope(
      child: JourneymanJobsApp(),
    ),
  );
}

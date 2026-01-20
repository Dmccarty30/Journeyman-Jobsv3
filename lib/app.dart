import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'design_system/app_theme.dart';
import 'features/navigation/navigation.dart';

/// Antigravity Kit 2.0 - App Widget Separation
///
/// Per flutter-app template:
/// - main.dart: Bootstrap logic only
/// - app.dart: App widget and configuration
///
/// This separation improves:
/// - Testability (app widget can be tested independently)
/// - Code organization
/// - Hot reload performance
class JourneymanJobsApp extends ConsumerWidget {
  const JourneymanJobsApp({super.key});

  /// Initialize Hive for local storage
  /// Call this before runApp() in main.dart
  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    // Register adapters here when using custom types:
    // Hive.registerAdapter(MyModelAdapter());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
        title: 'Journeyman Jobs',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget? child) {
          // Add any global error handling or loading overlays here if needed
          return child ?? const SizedBox.shrink();
        },
      );
}

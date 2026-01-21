import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'circuit_theme.dart';
import 'circuit_board_background.dart';

class CircuitSettings {
  final double opacity;
  final double animationSpeed;
  final ComponentDensity density;
  final bool enableAnimations;
  final String themeName;
  final int? substrateColorValue;

  CircuitSettings({
    this.opacity = 0.15,
    this.animationSpeed = 4.0,
    this.density = ComponentDensity.medium,
    this.enableAnimations = true,
    this.themeName = 'Classic Green',
    this.substrateColorValue,
  });

  CircuitSettings copyWith({
    double? opacity,
    double? animationSpeed,
    ComponentDensity? density,
    bool? enableAnimations,
    String? themeName,
    int? substrateColorValue,
  }) {
    return CircuitSettings(
      opacity: opacity ?? this.opacity,
      animationSpeed: animationSpeed ?? this.animationSpeed,
      density: density ?? this.density,
      enableAnimations: enableAnimations ?? this.enableAnimations,
      themeName: themeName ?? this.themeName,
      substrateColorValue: substrateColorValue ?? this.substrateColorValue,
    );
  }
}

class CircuitSettingsController extends ValueNotifier<CircuitSettings> {
  CircuitSettingsController._() : super(CircuitSettings());

  static final CircuitSettingsController instance =
      CircuitSettingsController._();

  static const String _kOpacity = 'circuit_opacity';
  static const String _kSpeed = 'circuit_speed';
  static const String _kDensity = 'circuit_density';
  static const String _kAnimations = 'circuit_animations';
  static const String _kTheme = 'circuit_theme';
  static const String _kSubstrate = 'circuit_substrate';

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // Density mapping
    final densityName = prefs.getString(_kDensity) ?? 'medium';
    final density = ComponentDensity.values.firstWhere(
      (e) => e.name == densityName,
      orElse: () => ComponentDensity.medium,
    );

    value = CircuitSettings(
      opacity: prefs.getDouble(_kOpacity) ?? 0.15,
      animationSpeed: prefs.getDouble(_kSpeed) ?? 4.0,
      density: density,
      enableAnimations: prefs.getBool(_kAnimations) ?? true,
      themeName: prefs.getString(_kTheme) ?? 'Classic Green',
      substrateColorValue: prefs.getInt(_kSubstrate),
    );
  }

  Future<void> saveSettings(CircuitSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setDouble(_kOpacity, settings.opacity),
      prefs.setDouble(_kSpeed, settings.animationSpeed),
      prefs.setString(_kDensity, settings.density.name),
      prefs.setBool(_kAnimations, settings.enableAnimations),
      prefs.setString(_kTheme, settings.themeName),
      settings.substrateColorValue != null
          ? prefs.setInt(_kSubstrate, settings.substrateColorValue!)
          : prefs.remove(_kSubstrate),
    ]);
    value = settings;
    notifyListeners();
  }

  // Helper to get the actual ThemeVariant object
  CircuitThemeVariant get currentThemeVariant {
    return CircuitThemeVariant.values.firstWhere(
      (v) => v.name == value.themeName,
      orElse: () => CircuitThemeVariant.classicGreen(),
    );
  }

  Color? get currentSubstrateColor {
    return value.substrateColorValue != null
        ? Color(value.substrateColorValue!)
        : null;
  }
}

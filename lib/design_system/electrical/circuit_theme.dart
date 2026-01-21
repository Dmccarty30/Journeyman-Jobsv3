import 'package:flutter/material.dart';
import 'package:journeyman_jobs/design_system/app_theme.dart';

/// Defines color palettes for different PCB (Printed Circuit Board) aesthetic styles.
/// Used by [ElectricalCircuitBackground] to switch between visual themes.
class CircuitThemeVariant {
  final String name;
  final Color substrateColor;
  final Color copperColor;
  final Color solderMaskColor;
  final Color silkscreenColor;
  final Color traceColor; // Usually derived from copper/mask interaction

  const CircuitThemeVariant({
    required this.name,
    required this.substrateColor,
    required this.copperColor,
    required this.solderMaskColor,
    required this.silkscreenColor,
    required this.traceColor,
  });

  /// Standard green PCB look (Industry Standard)
  factory CircuitThemeVariant.classicGreen() {
    return const CircuitThemeVariant(
      name: 'Classic Green',
      substrateColor: AppTheme.pcbSubstrate,
      copperColor: AppTheme.copperFresh,
      solderMaskColor: AppTheme.solderMask,
      silkscreenColor: AppTheme.silkscreen,
      traceColor: Color(0xFF0A3D29), // Darker green for traces under mask
    );
  }

  /// Premium navy blue PCB with gold traces
  factory CircuitThemeVariant.navyPremium() {
    return const CircuitThemeVariant(
      name: 'Navy Premium',
      substrateColor: Color(0xFF001F3F),
      copperColor: Color(0xFFFFD700), // Gold
      solderMaskColor: Color(0xFF003366), // Dark Blue
      silkscreenColor: Colors.white,
      traceColor: Color(0xFF001933), // Darker navy
    );
  }

  /// Modern stealth black PCB with silver/gray traces
  factory CircuitThemeVariant.stealth() {
    return const CircuitThemeVariant(
      name: 'Stealth',
      substrateColor: Color(0xFF121212),
      copperColor: Color(0xFFC0C0C0), // Silver
      solderMaskColor: Color(0xFF1A1A1A), // Almost black
      silkscreenColor: Color(0xFF808080), // Gray text
      traceColor: Color(0xFF0f0f0f),
    );
  }

  /// Vintage paper/phenolic PCB with aged copper
  factory CircuitThemeVariant.vintage() {
    return const CircuitThemeVariant(
      name: 'Vintage',
      substrateColor: Color(0xFFD2B48C), // Tan
      copperColor: AppTheme.copperAged,
      solderMaskColor: Color(0x00000000), // Often no solder mask on old boards
      silkscreenColor: Color(0xFF3E2723), // Dark brown ink
      traceColor: AppTheme.copperAged,
    );
  }

  /// Returns the standard list of available variants
  static List<CircuitThemeVariant> get values => [
        CircuitThemeVariant.classicGreen(),
        CircuitThemeVariant.navyPremium(),
        CircuitThemeVariant.stealth(),
        CircuitThemeVariant.vintage(),
      ];
}

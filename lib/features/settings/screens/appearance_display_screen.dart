import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journeyman_jobs/design_system/design_system.dart';
import 'package:go_router/go_router.dart';
import '../../navigation/services/app_router.dart';
import '../providers/settings_providers.dart';

class AppearanceDisplayScreen extends ConsumerStatefulWidget {
  const AppearanceDisplayScreen({super.key});

  @override
  ConsumerState<AppearanceDisplayScreen> createState() =>
      _AppearanceDisplayScreenState();
}

class _AppearanceDisplayScreenState
    extends ConsumerState<AppearanceDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    final appearanceAsync = ref.watch(appearanceSettingsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Appearance & Display'),
        elevation: 0,
        backgroundColor: AppTheme.primaryNavy,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          const ModernSvgCircuitBackground(opacity: 0.05),
          appearanceAsync.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppTheme.accentCopper),
            ),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 48, color: AppTheme.errorRed),
                  const SizedBox(height: AppTheme.spacingMd),
                  Text('Failed to load settings', style: AppTheme.titleMedium),
                  const SizedBox(height: AppTheme.spacingSm),
                  Text(error.toString(),
                      style: AppTheme.bodySmall
                          .copyWith(color: AppTheme.textSecondary)),
                  const SizedBox(height: AppTheme.spacingMd),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(appearanceSettingsProvider),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
            data: (settings) => SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Theme Settings'),
                  _buildToggleTile(
                    title: 'Dark Mode',
                    subtitle: 'Enable dark theme across the application',
                    icon: Icons.dark_mode_outlined,
                    value: settings.darkModeEnabled,
                    onChanged: (value) async {
                      try {
                        await ref
                            .read(appearanceSettingsProvider.notifier)
                            .setDarkMode(value);
                        if (mounted) {
                          JJSnackBar.showInfo(
                            context: context,
                            message:
                                'Dark mode ${value ? 'enabled' : 'disabled'}',
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          JJSnackBar.showError(
                            context: context,
                            message: 'Failed to update setting',
                          );
                        }
                      }
                    },
                  ),
                  const Divider(),
                  _buildToggleTile(
                    title: 'High Contrast',
                    subtitle: 'Increase contrast for better visibility',
                    icon: Icons.contrast,
                    value: settings.highContrastEnabled,
                    onChanged: (value) async {
                      try {
                        await ref
                            .read(appearanceSettingsProvider.notifier)
                            .setHighContrast(value);
                        if (mounted) {
                          JJSnackBar.showInfo(
                            context: context,
                            message:
                                'High contrast ${value ? 'enabled' : 'disabled'}',
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          JJSnackBar.showError(
                            context: context,
                            message: 'Failed to update setting',
                          );
                        }
                      }
                    },
                  ),
                  const Divider(),
                  _buildToggleTile(
                    title: 'Electrical Effects',
                    subtitle: 'Enable animated electrical motifs and circuits',
                    icon: Icons.bolt,
                    value: settings.electricalEffectsEnabled,
                    onChanged: (value) async {
                      try {
                        await ref
                            .read(appearanceSettingsProvider.notifier)
                            .setElectricalEffects(value);
                        if (mounted) {
                          JJSnackBar.showInfo(
                            context: context,
                            message:
                                'Electrical effects ${value ? 'enabled' : 'disabled'}',
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          JJSnackBar.showError(
                            context: context,
                            message: 'Failed to update setting',
                          );
                        }
                      }
                    },
                  ),
                  const Divider(),
                  _buildDropdownTile(
                    title: 'Font Size',
                    subtitle: 'Adjust the global text size',
                    icon: Icons.format_size,
                    value: settings.fontSize,
                    items: ['Small', 'Medium', 'Large', 'Extra Large'],
                    onChanged: (value) async {
                      if (value != null) {
                        try {
                          await ref
                              .read(appearanceSettingsProvider.notifier)
                              .setFontSize(value);
                          if (mounted) {
                            JJSnackBar.showInfo(
                              context: context,
                              message: 'Font size set to $value',
                            );
                          }
                        } catch (e) {
                          if (mounted) {
                            JJSnackBar.showError(
                              context: context,
                              message: 'Failed to update setting',
                            );
                          }
                        }
                      }
                    },
                  ),
                  const Divider(),
                  _buildSectionHeader('Developer Tools'),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: AppTheme.spacingSm),
                    leading: Container(
                      padding: const EdgeInsets.all(AppTheme.spacingSm),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryNavy.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                      ),
                      child: const Icon(Icons.developer_mode,
                          color: AppTheme.primaryNavy),
                    ),
                    title: const Text('Circuit Background Demo',
                        style: AppTheme.titleMedium),
                    subtitle: Text(
                      'Configure and test circuit themes',
                      style: AppTheme.bodySmall
                          .copyWith(color: AppTheme.textSecondary),
                    ),
                    trailing: const Icon(Icons.chevron_right,
                        color: AppTheme.textSecondary),
                    onTap: () {
                      context.push(AppRouter.circuitBackgroundDemo);
                    },
                  ),
                  const SizedBox(height: AppTheme.spacingXl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: AppTheme.spacingMd, top: AppTheme.spacingSm),
      child: Text(
        title.toUpperCase(),
        style: AppTheme.labelMedium.copyWith(
          color: AppTheme.primaryNavy,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildToggleTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSm),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingSm),
            decoration: BoxDecoration(
              color: AppTheme.primaryNavy.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: Icon(icon, color: AppTheme.primaryNavy),
          ),
          const SizedBox(width: AppTheme.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.titleMedium),
                Text(
                  subtitle,
                  style: AppTheme.bodySmall
                      .copyWith(color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          JJCircuitBreakerSwitch(
            value: value,
            onChanged: onChanged,
            size: JJCircuitBreakerSize.small,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSm),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingSm),
            decoration: BoxDecoration(
              color: AppTheme.primaryNavy.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: Icon(icon, color: AppTheme.primaryNavy),
          ),
          const SizedBox(width: AppTheme.spacingMd),
          Expanded(
            child: Text(title, style: AppTheme.titleMedium),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingSm),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.borderLight),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: DropdownButton<String>(
              value: value,
              underline: const SizedBox(),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: AppTheme.bodyMedium),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

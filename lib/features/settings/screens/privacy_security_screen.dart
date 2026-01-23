import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journeyman_jobs/design_system/design_system.dart';
import '../providers/settings_providers.dart';

class PrivacySecurityScreen extends ConsumerStatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  ConsumerState<PrivacySecurityScreen> createState() =>
      _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends ConsumerState<PrivacySecurityScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(privacySecuritySettingsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Privacy & Security',
          style: AppTheme.headlineMedium.copyWith(color: AppTheme.white),
        ),
        backgroundColor: AppTheme.primaryNavy,
        iconTheme: const IconThemeData(color: AppTheme.white),
      ),
      body: Stack(
        children: [
          ElectricalCircuitBackground(
            opacity: 0.35,
            componentDensity: ComponentDensity.high,
          ),
          settingsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (settings) => SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Privacy Controls'),
                  _buildSettingsCard([
                    _buildDropdownTile(
                      icon: Icons.visibility,
                      title: 'Profile Visibility',
                      value: settings.profileVisibility,
                      options: ['Public', 'Union Members Only', 'Private'],
                      onChanged: (value) {
                        if (value != null) {
                          ref
                              .read(privacySecuritySettingsProvider.notifier)
                              .setProfileVisibility(value);
                        }
                      },
                    ),
                    const Divider(height: 1),
                    _buildSwitchTile(
                      icon: Icons.location_on,
                      title: 'Location Services',
                      subtitle: 'Used for job and weather alerts',
                      value: settings.locationServicesEnabled,
                      onChanged: (value) {
                        ref
                            .read(privacySecuritySettingsProvider.notifier)
                            .setLocationServices(value);
                      },
                    ),
                  ]),
                  const SizedBox(height: AppTheme.spacingLg),
                  _buildSectionHeader('Account Security'),
                  _buildSettingsCard([
                    _buildSwitchTile(
                      icon: Icons.fingerprint,
                      title: 'Biometric Login',
                      subtitle: 'Use Face ID or Touch ID',
                      value: settings.biometricLoginEnabled,
                      onChanged: (value) {
                        ref
                            .read(privacySecuritySettingsProvider.notifier)
                            .setBiometricLogin(value);
                      },
                    ),
                    const Divider(height: 1),
                    _buildSwitchTile(
                      icon: Icons.security,
                      title: 'Two-Factor Authentication',
                      subtitle: 'Extra security for your account',
                      value: settings.twoFactorEnabled,
                      onChanged: (value) {
                        ref
                            .read(privacySecuritySettingsProvider.notifier)
                            .setTwoFactor(value);
                      },
                    ),
                  ]),
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
        left: AppTheme.spacingSm,
        bottom: AppTheme.spacingSm,
      ),
      child: Text(
        title,
        style: AppTheme.titleMedium.copyWith(
          color: AppTheme.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return JJCard(
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingSm),
            decoration: BoxDecoration(
              color: AppTheme.accentCopper.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: Icon(
              icon,
              color: AppTheme.accentCopper,
              size: AppTheme.iconSm,
            ),
          ),
          const SizedBox(width: AppTheme.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.titleMedium.copyWith(
                    color: AppTheme.primaryNavy,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXs),
                Text(
                  subtitle,
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          JJCircuitBreakerSwitch(
            value: value,
            onChanged: onChanged,
            size: JJCircuitBreakerSize.small,
            showElectricalEffects: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingSm),
            decoration: BoxDecoration(
              color: AppTheme.accentCopper.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: Icon(
              icon,
              color: AppTheme.accentCopper,
              size: AppTheme.iconSm,
            ),
          ),
          const SizedBox(width: AppTheme.spacingMd),
          Expanded(
            child: Text(
              title,
              style: AppTheme.titleMedium.copyWith(
                color: AppTheme.primaryNavy,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingMd,
              vertical: AppTheme.spacingSm,
            ),
            decoration: BoxDecoration(
              color: AppTheme.lightGray,
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: DropdownButton<String>(
              value: value,
              items: options.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(
                    option,
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.primaryNavy,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              underline: const SizedBox(),
              isDense: true,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: AppTheme.accentCopper,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

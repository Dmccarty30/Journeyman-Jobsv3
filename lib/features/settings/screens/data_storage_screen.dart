import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journeyman_jobs/design_system/design_system.dart';
import 'package:journeyman_jobs/features/settings/providers/settings_providers.dart';

class DataStorageScreen extends ConsumerStatefulWidget {
  const DataStorageScreen({super.key});

  @override
  ConsumerState<DataStorageScreen> createState() => _DataStorageScreenState();
}

class _DataStorageScreenState extends ConsumerState<DataStorageScreen> {
  String _cacheSize = 'Calculating...';

  @override
  void initState() {
    super.initState();
    _calculateCacheSize();
  }

  Future<void> _calculateCacheSize() async {
    // We can access the notifier even if the state isn't fully loaded yet
    // But safe to wait a frame or just call it.
    // Ideally we might want to wait for the provider to be initialized, but the methods are purely service calls usually.
    // However, the provider.notifier access is synchronous.
    final size = await ref
        .read(dataStorageSettingsProvider.notifier)
        .calculateCacheSize();
    if (mounted) {
      setState(() {
        _cacheSize = size;
      });
    }
  }

  Future<void> _clearCache() async {
    setState(() {
      _cacheSize = 'Clearing...';
    });

    await ref.read(dataStorageSettingsProvider.notifier).clearCache();

    if (mounted) {
      setState(() {
        _cacheSize = '0.0 MB';
      });
      JJSnackBar.showSuccess(
        context: context,
        message: 'Cache cleared successfully',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(dataStorageSettingsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Data & Storage'),
        elevation: 0,
        backgroundColor: AppTheme.primaryNavy,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          const ModernSvgCircuitBackground(opacity: 0.05),
          settingsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (settings) => SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Offline Capabilities'),
                  _buildToggleTile(
                    title: 'Offline Mode',
                    subtitle: 'Use the app with minimal internet connection',
                    icon: Icons.cloud_off,
                    value: settings.offlineModeEnabled,
                    onChanged: (value) {
                      ref
                          .read(dataStorageSettingsProvider.notifier)
                          .setOfflineMode(value);
                    },
                  ),
                  const Divider(),
                  _buildSectionHeader('Downloads'),
                  _buildToggleTile(
                    title: 'Auto-Download',
                    subtitle: 'Automatically download job data for offline use',
                    icon: Icons.download_for_offline_outlined,
                    value: settings.autoDownloadEnabled,
                    onChanged: (value) {
                      ref
                          .read(dataStorageSettingsProvider.notifier)
                          .setAutoDownload(value);
                    },
                  ),
                  _buildToggleTile(
                    title: 'WIFI-Only Downloads',
                    subtitle: 'Only download data when connected to WIFI',
                    icon: Icons.wifi,
                    value: settings.wifiOnlyDownloads,
                    onChanged: (value) {
                      ref
                          .read(dataStorageSettingsProvider.notifier)
                          .setWifiOnly(value);
                    },
                  ),
                  const Divider(),
                  _buildSectionHeader('Storage Management'),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppTheme.spacingSm),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppTheme.spacingSm),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryNavy.withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(AppTheme.radiusSm),
                          ),
                          child: const Icon(Icons.storage,
                              color: AppTheme.primaryNavy),
                        ),
                        const SizedBox(width: AppTheme.spacingMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Clear Cache',
                                  style: AppTheme.titleMedium),
                              Text(
                                'Current cache size: $_cacheSize',
                                style: AppTheme.bodySmall
                                    .copyWith(color: AppTheme.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        JJSecondaryButton(
                          text: 'Clear',
                          onPressed: _clearCache,
                        ),
                      ],
                    ),
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
}

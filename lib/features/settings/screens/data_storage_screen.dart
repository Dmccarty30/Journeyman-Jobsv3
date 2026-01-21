import 'package:flutter/material.dart';
import 'package:journeyman_jobs/design_system/design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStorageScreen extends StatefulWidget {
  const DataStorageScreen({super.key});

  @override
  State<DataStorageScreen> createState() => _DataStorageScreenState();
}

class _DataStorageScreenState extends State<DataStorageScreen> {
  bool _offlineModeEnabled = false;
  bool _autoDownloadEnabled = true;
  bool _wifiOnlyDownloads = true;
  String _cacheSize = 'Calculating...';

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _calculateCacheSize();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _offlineModeEnabled = prefs.getBool('offlineMode') ?? false;
      _autoDownloadEnabled = prefs.getBool('autoDownload') ?? true;
      _wifiOnlyDownloads = prefs.getBool('wifiOnly') ?? true;
    });
  }

  Future<void> _updateSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);

    if (mounted) {
      JJSnackBar.showSuccess(
        context: context,
        message: 'Storage settings updated',
      );
    }
  }

  Future<void> _calculateCacheSize() async {
    // Simulate cache size calculation
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      setState(() {
        _cacheSize = '42.5 MB';
      });
    }
  }

  Future<void> _clearCache() async {
    setState(() {
      _cacheSize = 'Clearing...';
    });

    // Simulate clearing cache
    await Future.delayed(const Duration(seconds: 1));

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
          SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Offline Capabilities'),
                _buildToggleTile(
                  title: 'Offline Mode',
                  subtitle: 'Use the app with minimal internet connection',
                  icon: Icons.cloud_off,
                  value: _offlineModeEnabled,
                  onChanged: (value) {
                    setState(() => _offlineModeEnabled = value);
                    _updateSetting('offlineMode', value);
                  },
                ),
                const Divider(),
                _buildSectionHeader('Downloads'),
                _buildToggleTile(
                  title: 'Auto-Download',
                  subtitle: 'Automatically download job data for offline use',
                  icon: Icons.download_for_offline_outlined,
                  value: _autoDownloadEnabled,
                  onChanged: (value) {
                    setState(() => _autoDownloadEnabled = value);
                    _updateSetting('autoDownload', value);
                  },
                ),
                _buildToggleTile(
                  title: 'WIFI-Only Downloads',
                  subtitle: 'Only download data when connected to WIFI',
                  icon: Icons.wifi,
                  value: _wifiOnlyDownloads,
                  onChanged: (value) {
                    setState(() => _wifiOnlyDownloads = value);
                    _updateSetting('wifiOnly', value);
                  },
                ),
                const Divider(),
                _buildSectionHeader('Storage Management'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: AppTheme.spacingSm),
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

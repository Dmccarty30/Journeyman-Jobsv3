import 'package:flutter/material.dart';
import 'package:journeyman_jobs/design_system/design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppearanceDisplayScreen extends StatefulWidget {
  const AppearanceDisplayScreen({super.key});

  @override
  State<AppearanceDisplayScreen> createState() => _AppearanceDisplayScreenState();
}

class _AppearanceDisplayScreenState extends State<AppearanceDisplayScreen> {
  bool _darkModeEnabled = false;
  bool _highContrastMode = false;
  bool _electricalEffects = true;
  String _selectedFontSize = 'Medium';
  
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }
  
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkModeEnabled = prefs.getBool('darkMode') ?? false;
      _highContrastMode = prefs.getBool('highContrast') ?? false;
      _electricalEffects = prefs.getBool('electricalEffects') ?? true;
      _selectedFontSize = prefs.getString('fontSize') ?? 'Medium';
    });
  }
  
  Future<void> _updateSetting(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
    
    if (mounted) {
      JJSnackBar.showInfo(
        context: context,
        message: 'Setting updated successfully',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Theme Settings'),
                _buildToggleTile(
                  title: 'Dark Mode',
                  subtitle: 'Enable dark theme across the application',
                  icon: Icons.dark_mode_outlined,
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() => _darkModeEnabled = value);
                    _updateSetting('darkMode', value);
                  },
                ),
                const Divider(),
                _buildToggleTile(
                  title: 'High Contrast',
                  subtitle: 'Increase contrast for better visibility',
                  icon: Icons.contrast,
                  value: _highContrastMode,
                  onChanged: (value) {
                    setState(() => _highContrastMode = value);
                    _updateSetting('highContrast', value);
                  },
                ),
                const Divider(),
                _buildToggleTile(
                  title: 'Electrical Effects',
                  subtitle: 'Enable animated electrical motifs and circuits',
                  icon: Icons.bolt,
                  value: _electricalEffects,
                  onChanged: (value) {
                    setState(() => _electricalEffects = value);
                    _updateSetting('electricalEffects', value);
                  },
                ),
                const Divider(),
                _buildDropdownTile(
                  title: 'Font Size',
                  subtitle: 'Adjust the global text size',
                  icon: Icons.format_size,
                  value: _selectedFontSize,
                  items: ['Small', 'Medium', 'Large', 'Extra Large'],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedFontSize = value);
                      _updateSetting('fontSize', value);
                    }
                  },
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
      padding: const EdgeInsets.only(bottom: AppTheme.spacingMd, top: AppTheme.spacingSm),
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
              color: AppTheme.primaryNavy.withValues(alpha:0.1),
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
                  style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary),
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
              color: AppTheme.primaryNavy.withValues(alpha:0.1),
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



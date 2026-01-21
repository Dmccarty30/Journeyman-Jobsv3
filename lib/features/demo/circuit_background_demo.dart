import 'package:flutter/material.dart';
import 'package:journeyman_jobs/design_system/design_system.dart';
import 'package:journeyman_jobs/design_system/electrical/circuit_theme.dart';
import 'package:journeyman_jobs/design_system/electrical/circuit_settings_controller.dart';

class CircuitBackgroundDemoScreen extends StatefulWidget {
  const CircuitBackgroundDemoScreen({super.key});

  static const String routeName = '/demo/circuit-background';

  @override
  State<CircuitBackgroundDemoScreen> createState() =>
      _CircuitBackgroundDemoScreenState();
}

class _CircuitBackgroundDemoScreenState
    extends State<CircuitBackgroundDemoScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  // Configuration State
  double _opacity = 0.15;
  double _animationSpeed = 4.0;
  ComponentDensity _density = ComponentDensity.medium;
  bool _enableAnimations = true;
  CircuitThemeVariant _selectedTheme = CircuitThemeVariant.classicGreen();
  bool _isSplitScreen = true;
  Color? _customSubstrateColor;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadInitialSettings();
  }

  Future<void> _loadInitialSettings() async {
    await CircuitSettingsController.instance.loadSettings();
    final settings = CircuitSettingsController.instance.value;
    setState(() {
      _opacity = settings.opacity;
      _animationSpeed = settings.animationSpeed;
      _density = settings.density;
      _enableAnimations = settings.enableAnimations;
      _selectedTheme = CircuitSettingsController.instance.currentThemeVariant;
      _customSubstrateColor =
          CircuitSettingsController.instance.currentSubstrateColor;
    });
  }

  Future<void> _saveSettings() async {
    final settings = CircuitSettings(
      opacity: _opacity,
      animationSpeed: _animationSpeed,
      density: _density,
      enableAnimations: _enableAnimations,
      themeName: _selectedTheme.name,
      substrateColorValue: _customSubstrateColor?.toARGB32(),
    );
    await CircuitSettingsController.instance.saveSettings(settings);
    if (mounted) {
      JJSnackBar.showInfo(
          context: context, message: 'Circuit settings saved app-wide');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circuit Background Studio'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Version A (Iterated)'),
            Tab(text: 'Version B (Clean Slate)'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
            tooltip: 'Save Settings App-Wide',
          ),
          IconButton(
            icon: Icon(_isSplitScreen ? Icons.splitscreen : Icons.fullscreen),
            onPressed: () => setState(() => _isSplitScreen = !_isSplitScreen),
            tooltip: 'Toggle Split Screen',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildVersionAPreview(),
                _buildVersionBPreview(),
              ],
            ),
          ),
          _buildControlPanel(),
        ],
      ),
    );
  }

  Widget _buildVersionAPreview() {
    return _buildSplitView(
      background: ElectricalCircuitBackground(
        opacity: _opacity,
        animationSpeed: _animationSpeed,
        componentDensity: _density,
        enableCurrentFlow: _enableAnimations,
        enableInteractiveComponents: _enableAnimations,
        themeVariant: _selectedTheme,
        customSubstrateColor: _customSubstrateColor,
      ),
      label: 'current: circuit_board_background.dart',
    );
  }

  Widget _buildVersionBPreview() {
    // Placeholder for Version B
    return _buildSplitView(
      background: Stack(
        children: [
          // Reuse V1 for now until V2 is built, but maybe with different settings/label
          ElectricalCircuitBackground(
            opacity: _opacity,
            animationSpeed: _animationSpeed,
            componentDensity: _density,
            enableCurrentFlow: _enableAnimations,
            enableInteractiveComponents: _enableAnimations,
            themeVariant: _selectedTheme,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black54,
              child: const Text(
                'Version B (Coming Soon)',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ],
      ),
      label: 'future: circuit_board_background_v2.dart',
    );
  }

  Widget _buildSplitView({required Widget background, required String label}) {
    if (!_isSplitScreen) {
      return Stack(
        children: [
          background,
          SafeArea(child: _buildSampleUI()),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(label,
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 10)))),
        ],
      );
    }

    return Row(
      children: [
        // Left Half: With UI
        Expanded(
          child: Stack(
            children: [
              background, // This will build a separate instance
              SafeArea(child: _buildSampleUI()),
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Chip(
                      label: Text('Context'),
                      visualDensity: VisualDensity.compact),
                ),
              ),
            ],
          ),
        ),
        // Divider
        Container(width: 2, color: AppTheme.accentCopper),
        // Right Half: Clean
        Expanded(
          child: Stack(
            children: [
              background, // Separate instance
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Chip(
                      label: Text('Clean'),
                      visualDensity: VisualDensity.compact),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSampleUI() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Sample Card UI', style: AppTheme.headlineSmall),
                  const SizedBox(height: 8),
                  const Text(
                      'See how the background looks behind standard surfaces.'),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: () {}, child: const Text('Action')),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
        ],
      ),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: const [
          BoxShadow(
              blurRadius: 10, color: Colors.black12, offset: Offset(0, -2))
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Theme Selector
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: CircuitThemeVariant.values.map((variant) {
                  final isSelected = _selectedTheme.name == variant.name;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(variant.name),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) setState(() => _selectedTheme = variant);
                      },
                      avatar:
                          CircleAvatar(backgroundColor: variant.substrateColor),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8),
            // Substrate Override
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Text('Substrate: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  _buildSubstrateChip('Default', null),
                  _buildSubstrateChip('Silicon', const Color(0xFFE0E0E0)),
                  _buildSubstrateChip('Dark Silicon', const Color(0xFF202020)),
                  _buildSubstrateChip('Green', const Color(0xFF0D4F35)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Sliders Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Opacity: ${_opacity.toStringAsFixed(2)}'),
                      Slider(
                        value: _opacity,
                        min: 0.0,
                        max: 1.0,
                        onChanged: (v) => setState(() => _opacity = v),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Speed: ${_animationSpeed.toStringAsFixed(1)}x'),
                      Slider(
                        value: _animationSpeed,
                        min: 0.1,
                        max: 10.0,
                        onChanged: (v) => setState(() => _animationSpeed = v),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Toggles Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Animations'),
                Switch(
                  value: _enableAnimations,
                  onChanged: (v) => setState(() => _enableAnimations = v),
                ),
                const SizedBox(width: 16),
                const Text('Density'),
                DropdownButton<ComponentDensity>(
                  value: _density,
                  items: ComponentDensity.values.map((d) {
                    return DropdownMenuItem(value: d, child: Text(d.name));
                  }).toList(),
                  onChanged: (v) => setState(() => _density = v!),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubstrateChip(String label, Color? color) {
    final isSelected = _customSubstrateColor == color;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (v) => setState(() => _customSubstrateColor = color),
        backgroundColor: color ?? Colors.transparent,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: isSelected ? AppTheme.accentCopper : Colors.grey),
            borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

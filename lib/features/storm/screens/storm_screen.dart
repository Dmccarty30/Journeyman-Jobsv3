import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/navigation/navigation.dart';
import '../storm.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:journeyman_jobs/design_system/design_system.dart';
import 'package:journeyman_jobs/core/models/contractor_model.dart';

class StormScreen extends StatefulWidget {
  const StormScreen({super.key});

  @override
  State<StormScreen> createState() => _StormScreenState();
}

class _StormScreenState extends State<StormScreen> {
  // Power outage tracking
  final PowerOutageService _powerOutageService = PowerOutageService();
  List<PowerOutageState> _powerOutages = [];
  bool _isLoadingOutages = true;

  // Storm Contractors
  List<Contractor> _stormContractors = [];
  bool _isLoadingContractors = true;

  @override
  void initState() {
    super.initState();
    _loadPowerOutages();
    _loadStormContractors();
  }

  @override
  void dispose() {
    _powerOutageService.dispose();
    super.dispose();
  }

  Future<void> _loadPowerOutages() async {
    try {
      await _powerOutageService.initialize();
      final outages = await _powerOutageService.getPowerOutages();
      if (mounted) {
        setState(() {
          _powerOutages = outages;
          _isLoadingOutages = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingOutages = false;
        });
      }
    }
  }

  Future<void> _loadStormContractors() async {
    try {
      final String response = await DefaultAssetBundle.of(context)
          .loadString('assets/data/storm_roster.json');
      final List<dynamic> jsonList = json.decode(response);
      if (mounted) {
        setState(() {
          _stormContractors =
              jsonList.map((json) => Contractor.fromJson(json)).toList();
          _isLoadingContractors = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading storm contractors: $e');
      if (mounted) {
        setState(() {
          _isLoadingContractors = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryNavy,
        elevation: 0,
        title: Row(
          children: [
            const Icon(
              Icons.flash_on,
              color: AppTheme.warningYellow,
              size: AppTheme.iconMd,
            ),
            const SizedBox(width: AppTheme.spacingSm),
            Text(
              'Storm Work',
              style: AppTheme.headlineMedium.copyWith(color: AppTheme.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppTheme.white,
            ),
            onPressed: () {
              context.push(AppRouter.notificationSettings);
            },
            tooltip: 'Notifications Settings',
          ),
        ],
      ),
      body: Stack(
        children: [
          const ElectricalCircuitBackground(
            opacity: 0.08,
            traceColor: AppTheme.primaryNavy,
            copperColor: AppTheme.accentCopper,
            componentDensity: ComponentDensity.medium,
          ),
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Storm work stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current Storm Activity',
                        style: AppTheme.headlineSmall.copyWith(
                          color: AppTheme.primaryNavy,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.radar),
                        color: AppTheme.infoBlue,
                        tooltip: 'Weather Radar',
                        onPressed: () => _showWeatherRadar(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingMd),

                  // Fox Weather Live
                  const FoxWeatherWidget(),
                  const SizedBox(height: AppTheme.spacingLg),

                  // Storm Tracker
                  const StormTrackerSection(),
                  const SizedBox(height: AppTheme.spacingLg),

                  // Power outage section
                  if (_powerOutages.isNotEmpty) ...[
                    PowerOutageSummary(outages: _powerOutages),
                    const SizedBox(height: AppTheme.spacingLg),
                    Text(
                      'Major Power Outages by State',
                      style: AppTheme.headlineSmall.copyWith(
                        color: AppTheme.primaryNavy,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingMd),
                    if (_isLoadingOutages)
                      const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.accentCopper,
                        ),
                      )
                    else
                      ..._powerOutages.map((outage) => PowerOutageCard(
                            outageData: outage,
                            onTap: () => _showOutageDetails(context, outage),
                          )),
                    const SizedBox(height: AppTheme.spacingLg),
                  ],

                  // Storm Contractors Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppTheme.spacingLg),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                      boxShadow: [AppTheme.shadowMd],
                      border: Border.all(
                        color: AppTheme.borderLight,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.group_outlined,
                              color: AppTheme.primaryNavy,
                              size: AppTheme.iconMd,
                            ),
                            const SizedBox(width: AppTheme.spacingSm),
                            Text(
                              'Storm Contractors',
                              style: AppTheme.headlineSmall.copyWith(
                                color: AppTheme.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppTheme.spacingMd),
                        if (_isLoadingContractors)
                          const Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.accentCopper,
                            ),
                          )
                        else
                          Column(
                            children: _stormContractors.isEmpty
                                ? [
                                    Center(
                                      child: Text(
                                        'No storm contractors available',
                                        style: AppTheme.bodyMedium.copyWith(
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                    )
                                  ]
                                : _stormContractors
                                    .map((contractor) => StormContractorCard(
                                        contractor: contractor))
                                    .toList(),
                          ),
                        const SizedBox(height: AppTheme.spacingXl),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showWeatherRadar(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.primaryNavy,
            title: Text(
              'Live Weather Radar',
              style: AppTheme.headlineMedium.copyWith(color: AppTheme.white),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppTheme.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: const NoaaRadarMap(),
        ),
      ),
    );
  }

  void _showOutageDetails(BuildContext context, PowerOutageState outage) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppTheme.radiusLg)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          minChildSize: 0.3,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.textLight,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingLg),
                  // Title
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          outage.stateName,
                          style: AppTheme.displaySmall.copyWith(
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  // Outage info
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacingMd),
                    decoration: BoxDecoration(
                      color: AppTheme.infoBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      border: Border.all(
                        color: AppTheme.infoBlue.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.circleInfo,
                              color: AppTheme.infoBlue,
                              size: 16,
                            ),
                            const SizedBox(width: AppTheme.spacingSm),
                            Text(
                              'Storm Work Opportunity',
                              style: AppTheme.headlineSmall.copyWith(
                                color: AppTheme.infoBlue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppTheme.spacingSm),
                        Text(
                          'This state has significant power outages requiring immediate restoration crews. '
                          'Contact local IBEW unions in ${outage.stateName} for deployment opportunities.',
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingLg),
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: JJSecondaryButton(
                          text: 'View Jobs',
                          icon: FontAwesomeIcons.briefcase,
                          onPressed: () {
                            Navigator.pop(context);
                            // Navigate to jobs filtered by state
                          },
                          isFullWidth: true,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingMd),
                      Expanded(
                        child: JJPrimaryButton(
                          text: 'View Unions',
                          icon: FontAwesomeIcons.userGroup,
                          onPressed: () {
                            Navigator.pop(context);
                            // Navigate to unions filtered by state
                          },
                          isFullWidth: true,
                          variant: JJButtonVariant.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

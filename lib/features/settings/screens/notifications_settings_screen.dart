import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:journeyman_jobs/design_system/design_system.dart';
import 'package:go_router/go_router.dart';
import 'package:journeyman_jobs/core/core.dart';
import '../../../features/navigation/navigation.dart';
import '../providers/settings_providers.dart';
import '../models/settings_models.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'all';
  bool _notificationsEnabled = false;

  final List<String> _filters = [
    'all',
    'jobs',
    'safety',
    'system',
    'applications',
    'storm',
    'crews',
  ];

  final Map<String, String> _filterLabels = {
    'all': 'All',
    'jobs': 'Job Alerts',
    'safety': 'Safety',
    'system': 'System',
    'applications': 'Applications',
    'storm': 'Storm Work',
    'crews': 'Crews',
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _checkNotificationPermission();

    // Check for tab query parameter
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uri = Uri.tryParse(
          GoRouter.of(context).routeInformationProvider.value.uri.toString());
      if (uri != null) {
        final tab = uri.queryParameters['tab'];
        if (tab == 'settings') {
          _tabController.animateTo(1);
        }
      }
    });
  }

  Future<void> _checkNotificationPermission() async {
    _notificationsEnabled =
        await NotificationPermissionService.areNotificationsEnabled();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleMasterToggle(bool enabled) async {
    if (enabled && !_notificationsEnabled) {
      final granted =
          await NotificationPermissionService.handleInitialPermissionFlow(
              context);
      if (!mounted) return;

      setState(() {
        _notificationsEnabled = granted;
      });

      if (granted) {
        // Update Firestore via provider
        await ref
            .read(notificationSettingsProvider.notifier)
            .updateSetting('notificationsEnabled', true);
        if (mounted) {
          JJSnackBar.showSuccess(
            context: context,
            message: 'Notifications enabled successfully',
          );
        }
      }
    } else if (!enabled) {
      final confirmed = await _showDisableConfirmationDialog();
      if (!mounted) return;

      if (confirmed) {
        setState(() {
          _notificationsEnabled = false;
        });
        await ref
            .read(notificationSettingsProvider.notifier)
            .updateSetting('notificationsEnabled', false);
        if (mounted) {
          JJSnackBar.showInfo(
            context: context,
            message: 'Notifications disabled. You can re-enable them anytime.',
          );
        }
      }
    }
  }

  Future<bool> _showDisableConfirmationDialog() async {
    return await context.showThemedDialog<bool>(
          theme: PopupThemeData.warning(),
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.notifications_off,
                    color: AppTheme.warningYellow,
                    size: AppTheme.iconMd,
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  Text(
                    'Disable Notifications?',
                    style: AppTheme.headlineSmall.copyWith(
                      color: AppTheme.primaryNavy,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingLg),
              Text(
                'You\'ll miss important job alerts and union updates. Are you sure?',
                style: AppTheme.bodyMedium,
              ),
              const SizedBox(height: AppTheme.spacingXl),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        'Cancel',
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  Expanded(
                    child: JJPrimaryButton(
                      text: 'Disable',
                      onPressed: () => Navigator.of(context).pop(true),
                      variant: JJButtonVariant.danger,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _selectQuietHoursTime(
      bool isStart, NotificationSettingsModel settings) async {
    final TimeOfDay initialTime = isStart
        ? TimeOfDay(hour: settings.quietHoursStart, minute: 0)
        : TimeOfDay(hour: settings.quietHoursEnd, minute: 0);

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppTheme.accentCopper,
                ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final newStart = isStart ? picked.hour : settings.quietHoursStart;
      final newEnd = isStart ? settings.quietHoursEnd : picked.hour;
      await ref
          .read(notificationSettingsProvider.notifier)
          .setQuietHours(newStart, newEnd);
    }
  }

  Future<void> _markAsRead(String notificationId) async {
    try {
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(notificationId)
          .update({'isRead': true});
    } catch (e) {
      // Handle error silently or show snackbar
    }
  }

  Future<void> _markAllAsRead() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final batch = FirebaseFirestore.instance.batch();
      final notifications = await FirebaseFirestore.instance
          .collection('notifications')
          .where('userId', isEqualTo: user.uid)
          .where('isRead', isEqualTo: false)
          .get();

      for (var doc in notifications.docs) {
        batch.update(doc.reference, {'isRead': true});
      }

      await batch.commit();

      if (mounted) {
        JJSnackBar.showSuccess(
          context: context,
          message: 'All notifications marked as read',
        );
      }
    } catch (e) {
      if (mounted) {
        JJSnackBar.showError(
          context: context,
          message: 'Failed to mark notifications as read',
        );
      }
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'jobs':
        return Icons.work_outline;
      case 'safety':
        return Icons.security;
      case 'system':
        return Icons.settings;
      case 'applications':
        return Icons.assignment;
      case 'storm':
        return Icons.flash_on;
      case 'crews':
        return Icons.group;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'jobs':
        return AppTheme.accentCopper;
      case 'safety':
        return AppTheme.errorRed;
      case 'system':
        return AppTheme.primaryNavy;
      case 'applications':
        return AppTheme.successGreen;
      case 'storm':
        return AppTheme.warningYellow;
      case 'crews':
        return AppTheme.accentCopper;
      default:
        return AppTheme.textSecondary;
    }
  }

  void _handleNotificationTap(String type, Map<String, dynamic> data) {
    switch (type) {
      case 'jobs':
        final jobId = data['jobId'] as String?;
        if (jobId != null) {
          context.go('${AppRouter.jobs}/$jobId');
        } else {
          context.go(AppRouter.jobs);
        }
        break;
      case 'storm':
        context.go(AppRouter.storm);
        break;
      case 'applications':
        context.go(AppRouter.profile);
        break;
      case 'union':
      case 'union_updates':
      case 'union_reminders':
        final localNumber = data['localNumber'] as String?;
        if (localNumber != null) {
          context.go('${AppRouter.locals}/$localNumber');
        } else {
          context.go(AppRouter.locals);
        }
        break;
      case 'crews':
        final crewId = data['crewId'] as String?;
        if (crewId != null) {
          context.go('${AppRouter.crews}/$crewId');
        } else {
          context.go(AppRouter.crews);
        }
        break;
      case 'safety':
      case 'system':
      default:
        break;
    }
  }

  Stream<QuerySnapshot> _buildNotificationsStream(String userId) {
    Query query = FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true);

    if (_selectedFilter != 'all') {
      query = query.where('type', isEqualTo: _selectedFilter);
    }

    return query.snapshots();
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.notifications_none,
            size: 64,
            color: AppTheme.textSecondary,
          ),
          const SizedBox(height: AppTheme.spacingLg),
          Text(
            message,
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(DocumentSnapshot notification) {
    final data = notification.data() as Map<String, dynamic>;
    final type = data['type'] as String? ?? 'system';
    final title = data['title'] as String? ?? 'Notification';
    final body = data['body'] as String? ?? '';
    final isRead = data['isRead'] as bool? ?? false;
    final createdAt = data['createdAt'] as Timestamp?;
    final notificationData = data['data'] as Map<String, dynamic>? ?? {};

    final timeAgo = createdAt != null ? _formatTimeAgo(createdAt.toDate()) : '';

    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        side: BorderSide(
          color: AppTheme.borderLight,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          _markAsRead(notification.id);
          _handleNotificationTap(type, notificationData);
        },
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacingMd),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getNotificationColor(type).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: Icon(
                  _getNotificationIcon(type),
                  color: _getNotificationColor(type),
                  size: AppTheme.iconSm,
                ),
              ),
              const SizedBox(width: AppTheme.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: AppTheme.bodyLarge.copyWith(
                              fontWeight:
                                  isRead ? FontWeight.normal : FontWeight.w600,
                              color: isRead
                                  ? AppTheme.textSecondary
                                  : AppTheme.textPrimary,
                            ),
                          ),
                        ),
                        if (timeAgo.isNotEmpty)
                          Text(
                            timeAgo,
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                      ],
                    ),
                    if (body.isNotEmpty) ...[
                      const SizedBox(height: AppTheme.spacingXs),
                      Text(
                        body,
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (!isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppTheme.accentCopper,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final notificationSettingsAsync = ref.watch(notificationSettingsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: AppTheme.headlineSmall.copyWith(
            color: AppTheme.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppTheme.primaryNavy,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.white),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.accentCopper,
          indicatorWeight: 3,
          labelColor: AppTheme.white,
          unselectedLabelColor: AppTheme.white.withValues(alpha: 0.6),
          tabs: const [
            Tab(
              icon: Icon(Icons.notifications_outlined),
              text: 'Notifications',
            ),
            Tab(
              icon: Icon(Icons.settings_outlined),
              text: 'Settings',
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          ElectricalCircuitBackground(
            opacity: 0.35,
            componentDensity: ComponentDensity.high,
          ),
          TabBarView(
            controller: _tabController,
            children: [
              // Notifications Tab
              Column(
                children: [
                  // Filter tabs
                  Container(
                    color: Colors.transparent,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(AppTheme.spacingMd),
                      child: Row(
                        children: _filters.map((filter) {
                          final isSelected = filter == _selectedFilter;
                          return Container(
                            margin: const EdgeInsets.only(
                                right: AppTheme.spacingSm),
                            child: JJChip(
                              label: _filterLabels[filter]!,
                              isSelected: isSelected,
                              onTap: () {
                                setState(() {
                                  _selectedFilter = filter;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  // Mark all as read button
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(
                      left: AppTheme.spacingMd,
                      right: AppTheme.spacingMd,
                      bottom: AppTheme.spacingMd,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: _markAllAsRead,
                          icon: const Icon(
                            Icons.mark_email_read,
                            size: AppTheme.iconSm,
                          ),
                          label: const Text('Mark all as read'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.accentCopper,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Notifications list
                  Expanded(
                    child: user == null
                        ? _buildEmptyState(
                            'Please sign in to view notifications')
                        : StreamBuilder<QuerySnapshot>(
                            stream: _buildNotificationsStream(user.uid),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return _buildEmptyState(
                                    'Error loading notifications');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: JJElectricalLoader(
                                    message: 'Loading notifications...',
                                  ),
                                );
                              }

                              final notifications = snapshot.data?.docs ?? [];

                              if (notifications.isEmpty) {
                                return _buildEmptyState('No notifications yet');
                              }

                              return ListView.builder(
                                padding:
                                    const EdgeInsets.all(AppTheme.spacingMd),
                                itemCount: notifications.length,
                                itemBuilder: (context, index) {
                                  final notification = notifications[index];
                                  return _buildNotificationCard(notification);
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
              // Settings Tab - Using Riverpod Provider
              notificationSettingsAsync.when(
                loading: () => const Center(
                  child: JJElectricalLoader(
                    message: 'Loading settings...',
                  ),
                ),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 48, color: AppTheme.errorRed),
                      const SizedBox(height: AppTheme.spacingMd),
                      Text('Failed to load settings',
                          style: AppTheme.titleMedium),
                      const SizedBox(height: AppTheme.spacingMd),
                      ElevatedButton(
                        onPressed: () =>
                            ref.invalidate(notificationSettingsProvider),
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
                      // Master toggle
                      _buildMasterToggleCard(),

                      const SizedBox(height: AppTheme.spacingLg),
                      // Notification types
                      Text(
                        'Notification Types',
                        style: AppTheme.headlineSmall.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingMd),

                      // Individual notification type cards
                      _buildSettingCard(
                        icon: Icons.work_outline,
                        title: 'Job Alerts',
                        subtitle: 'Get notified about new job opportunities',
                        value: settings.jobAlertsEnabled,
                        onChanged: (value) async {
                          await ref
                              .read(notificationSettingsProvider.notifier)
                              .updateSetting('jobAlertsEnabled', value);
                        },
                        color: AppTheme.accentCopper,
                      ),

                      _buildSettingCard(
                        icon: Icons.group,
                        title: 'Union Updates',
                        subtitle: 'Important updates from your union',
                        value: settings.unionUpdatesEnabled,
                        onChanged: (value) async {
                          await ref
                              .read(notificationSettingsProvider.notifier)
                              .updateSetting('unionUpdatesEnabled', value);
                        },
                        color: AppTheme.primaryNavy,
                      ),

                      _buildSettingCard(
                        icon: Icons.settings,
                        title: 'System Notifications',
                        subtitle: 'App updates and system messages',
                        value: settings.systemNotificationsEnabled,
                        onChanged: (value) async {
                          await ref
                              .read(notificationSettingsProvider.notifier)
                              .updateSetting(
                                  'systemNotificationsEnabled', value);
                        },
                        color: AppTheme.infoBlue,
                      ),

                      _buildSettingCard(
                        icon: Icons.flash_on,
                        title: 'Storm Work',
                        subtitle: 'Emergency storm work opportunities',
                        value: settings.stormWorkEnabled,
                        onChanged: (value) async {
                          await ref
                              .read(notificationSettingsProvider.notifier)
                              .updateSetting('stormWorkEnabled', value);
                        },
                        color: AppTheme.warningYellow,
                      ),

                      _buildSettingCard(
                        icon: Icons.event_note,
                        title: 'Union Reminders',
                        subtitle: 'Reminders for union events and deadlines',
                        value: settings.unionRemindersEnabled,
                        onChanged: (value) async {
                          await ref
                              .read(notificationSettingsProvider.notifier)
                              .updateSetting('unionRemindersEnabled', value);
                        },
                        color: AppTheme.successGreen,
                      ),

                      const SizedBox(height: AppTheme.spacingLg),
                      // Sound & Vibration
                      Text(
                        'Sound & Vibration',
                        style: AppTheme.headlineSmall.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingMd),

                      _buildSettingCard(
                        icon: Icons.volume_up,
                        title: 'Sound',
                        subtitle: 'Play sound for notifications',
                        value: settings.soundEnabled,
                        onChanged: (value) async {
                          await ref
                              .read(notificationSettingsProvider.notifier)
                              .updateSetting('soundEnabled', value);
                        },
                        color: AppTheme.accentCopper,
                      ),

                      _buildSettingCard(
                        icon: Icons.vibration,
                        title: 'Vibration',
                        subtitle: 'Vibrate for notifications',
                        value: settings.vibrationEnabled,
                        onChanged: (value) async {
                          await ref
                              .read(notificationSettingsProvider.notifier)
                              .updateSetting('vibrationEnabled', value);
                        },
                        color: AppTheme.primaryNavy,
                      ),

                      const SizedBox(height: AppTheme.spacingLg),
                      // Quiet Hours
                      Text(
                        'Quiet Hours',
                        style: AppTheme.headlineSmall.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingMd),

                      _buildQuietHoursCard(settings),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: [AppTheme.shadowSm],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          onTap: () {
            onChanged(!value);
          },
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: AppTheme.iconMd,
                  ),
                ),
                const SizedBox(width: AppTheme.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTheme.bodyLarge.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingXs),
                      Text(
                        subtitle,
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: value,
                  onChanged: onChanged,
                  activeThumbColor: AppTheme.accentCopper,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMasterToggleCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: [AppTheme.shadowSm],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          onTap: () {
            _handleMasterToggle(!_notificationsEnabled);
          },
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.accentCopper.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: AppTheme.accentCopper,
                    size: AppTheme.iconMd,
                  ),
                ),
                const SizedBox(width: AppTheme.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notifications',
                        style: AppTheme.bodyLarge.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingXs),
                      Text(
                        'Enable or disable all notifications',
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _notificationsEnabled,
                  onChanged: _handleMasterToggle,
                  activeThumbColor: AppTheme.accentCopper,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuietHoursCard(NotificationSettingsModel settings) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: [AppTheme.shadowSm],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          onTap: () async {
            await ref.read(notificationSettingsProvider.notifier).updateSetting(
                'quietHoursEnabled', !settings.quietHoursEnabled);
          },
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTheme.infoBlue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                      ),
                      child: Icon(
                        Icons.schedule,
                        color: AppTheme.infoBlue,
                        size: AppTheme.iconMd,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quiet Hours',
                            style: AppTheme.bodyLarge.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingXs),
                          Text(
                            'Silence notifications during specified hours',
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: settings.quietHoursEnabled,
                      onChanged: (value) async {
                        await ref
                            .read(notificationSettingsProvider.notifier)
                            .updateSetting('quietHoursEnabled', value);
                      },
                      activeThumbColor: AppTheme.accentCopper,
                    ),
                  ],
                ),
                if (settings.quietHoursEnabled) ...[
                  const SizedBox(height: AppTheme.spacingMd),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMd,
                      vertical: AppTheme.spacingSm,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () =>
                                _selectQuietHoursTime(true, settings),
                            child: Text(
                              'Start: ${TimeOfDay(hour: settings.quietHoursStart, minute: 0).format(context)}',
                              style: AppTheme.bodyMedium,
                            ),
                          ),
                        ),
                        Text(
                          'to',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () =>
                                _selectQuietHoursTime(false, settings),
                            child: Text(
                              'End: ${TimeOfDay(hour: settings.quietHoursEnd, minute: 0).format(context)}',
                              style: AppTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
